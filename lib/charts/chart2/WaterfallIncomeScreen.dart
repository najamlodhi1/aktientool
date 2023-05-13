import 'package:aktientool/charts/chart2/WaterfallChart.dart';
import 'package:aktientool/constants/responsive.dart';
import 'package:flutter/material.dart';
import '../chart3/BarChartBalanceScreen.dart';
import 'IncomeReportModel.dart';

class WaterfallIncomeScreen extends StatefulWidget {
  const WaterfallIncomeScreen(this.tableData, {super.key});
  final List<IncomeReportModel> tableData;

  @override
  State<WaterfallIncomeScreen> createState() => _WaterfallIncomeScreenState();
}

class _WaterfallIncomeScreenState extends State<WaterfallIncomeScreen> {
  late int selectedYear;
  @override
  void initState() {
    selectedYear = widget.tableData.map((e) => e.date.year).toList().last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: MediaQuery.of(context).size.width > 1000
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customDropDown,
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(flex: 1, child: waterfallDetails),
                    const SizedBox(width: 20),
                    Expanded(
                        flex: 3,
                        child: SizedBox(
                            height: 250,
                            child: WaterfallChart(getcurrentreport))),
                  ],
                ),
              ],
            )
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              customDropDown,
              const SizedBox(height: 10),
              waterfallDetails,
              const SizedBox(height: 15),
              SizedBox(height: 250, child: WaterfallChart(getcurrentreport))
            ]),
    );
  }

  Widget get customDropDown {
    return SizedBox(
      width: 150,
      child: DropdownButtonFormField<int>(
        alignment: Alignment.center,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor))),
        value: selectedYear,
        style: const TextStyle(color: Colors.white),
        dropdownColor: Colors.black,
        menuMaxHeight: 200,
        items: widget.tableData
            .map((e) => e.date.year)
            .toList()
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item.toString(),
                    style: const TextStyle(color: Colors.white))))
            .toList(),
        onChanged: (newValue) {
          setState(() {
            selectedYear = newValue!;
          });
        },
      ),
    );
  }

  Widget get waterfallDetails {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        customtile('Revenue', numberToKFormat(gettotalAmount("Revenue"))),
        const Divider(color: Colors.white24, height: 0),
        customtile('Cost of Revenue',
            numberToKFormat(gettotalAmount("Cost of Revenue"))),
        const Divider(color: Colors.white24, height: 0),
        customtile(
            'Gross Profit', numberToKFormat(gettotalAmount("Gross Profit"))),
        const Divider(color: Colors.white24, height: 0),
        customtile('Operating Expenses',
            numberToKFormat(gettotalAmount("Operating Expenses"))),
        const Divider(color: Colors.white24, height: 0),
        customtile('Operating Income',
            numberToKFormat(gettotalAmount("Interest Expense"))),
        const Divider(color: Colors.white24, height: 0),
        customtile('Other Expenses',
            numberToKFormat(gettotalAmount("Other Expenses"))),
        const Divider(color: Colors.white24, height: 0),
        const Divider(color: Colors.white24, height: 0),
        customtile('Net Income', numberToKFormat(gettotalAmount("Net Income"))),
      ],
    );
  }

  List<ReportItemModel> get getcurrentreport {
    final IncomeReportModel selectedData = widget.tableData
        .firstWhere((element) => element.date.year == selectedYear);
    return selectedData.reports;
  }

  double gettotalAmount(String title) {
    int selectedReportIndex = widget.tableData[0].reports
        .indexWhere((element) => element.title == title);
    return getcurrentreport[selectedReportIndex].value;
  }

  Widget customtile(String title, String amount) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        trailing: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '$amount ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
          const TextSpan(text: 'USD', style: TextStyle(color: Colors.white))
        ])));
  }
}
