import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/charts/chart3/BalanceReportModel.dart';
import 'package:aktientool/constants/responsive.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart2/IncomeReportModel.dart';
import '../chart3/BarChartBalanceScreen.dart';
import 'DonutChart.dart';

class DonutChartBalanceScreen extends StatefulWidget {
  const DonutChartBalanceScreen(this.tableData, {super.key});
  final List<BalanceReportModel> tableData;

  @override
  State<DonutChartBalanceScreen> createState() =>
      _DonutChartBalanceScreenState();
}

class _DonutChartBalanceScreenState extends State<DonutChartBalanceScreen> {
  late AppLocalizations trans;
  late int selectedYear;
  bool isassets = true;

  List<String> assetsList = [
        "Total Current Assets",
        "Cash and Short Term Investments",
        "Receivables",
        "Other Current Assets",
        "Total non-current Assets",
        "Property, Plant & Equipment Net",
        "Long Term Investments",
        "Other non-current Assets"
      ],
      liabilities = [
        'Total current liabilities',
        'Payables',
        'Short Term debt',
        'Other Current Liabilities',
        'Total non-current liabilities',
        'Long Term debt',
        'Other non-current Liabilities'
      ];

  @override
  void initState() {
    selectedYear = widget.tableData.map((e) => e.date.year).toList().last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
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
                        flex: 3, child: DonutChart(getcurrentreport, isassets)),
                  ],
                ),
              ],
            )
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              customDropDown,
              const SizedBox(height: 10),
              waterfallDetails,
              const SizedBox(height: 15),
              DonutChart(getcurrentreport, isassets)
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

  String calculatetotalamount(List<String> list) {
    double totalAssets = 0;
    for (var element in getcurrentreport) {
      if (list.contains(element.title)) {
        if (element.title == "Total Current Assets" ||
            element.title == "Total non-current Assets" ||
            element.title == "Total current liabilities" ||
            element.title == "Total non-current liabilities") {
          totalAssets += element.value;
        }
      }
    }
    return numberToKFormat(totalAssets);
  }

  Widget get waterfallDetails {
    return Container(
      color: Colors.white10.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Expanded(
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: isassets == true ? primaryColor : null,
                        fixedSize: const Size.fromHeight(50)),
                    onPressed: () {
                      setState(() {
                        isassets = true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(calculatetotalamount(assetsList),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB6C2D0))),
                        const Text('ASSETS', style: TextStyle(fontSize: 12)),
                      ],
                    ))),
            Expanded(
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            isassets == false ? primaryColor : null,
                        fixedSize: const Size.fromHeight(50)),
                    onPressed: () {
                      setState(() {
                        isassets = false;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(calculatetotalamount(liabilities),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB6C2D0))),
                        const Text('LIABILITIES',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ))),
          ]),
          ...List.generate(
              isassets ? assetsList.length : liabilities.length,
              (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customtile(
                          isassets ? assetsList[index] : liabilities[index]),
                      const Divider(color: Colors.white24, height: 0),
                    ],
                  ))
        ],
      ),
    );
  }

  List<ReportItemModel> get getcurrentreport {
    final BalanceReportModel selectedData = widget.tableData
        .firstWhere((element) => element.date.year == selectedYear);
    return selectedData.reports;
  }

  double gettotalAmount(String title) {
    int selectedReportIndex = widget.tableData[0].reports
        .indexWhere((element) => element.title == title);
    return getcurrentreport[selectedReportIndex].value;
  }

  Widget customtile(String title) {
    String amount = numberToKFormat(gettotalAmount(title));
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: Text(trans.translate(title),
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
