import 'package:flutter/material.dart';
import '../../constants/responsive.dart';
import '../../settings/app_localizations.dart';
import '../chart2/createchart.dart';
import '../chart3/createchart.dart';
import '../chart4/createchart.dart';

class FinancialsNavPage extends StatefulWidget {
  const FinancialsNavPage(this.parentData, {super.key});
  final dynamic parentData;
  @override
  State<FinancialsNavPage> createState() => _FinancialsNavPageState();
}

class _FinancialsNavPageState extends State<FinancialsNavPage> {
  int pageIndex = 0;
  late List<Widget> widgets;
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    widgets = [
      CreateChart2(widget.parentData[0]),
      CreateChart3(widget.parentData[1]),
      CreateChart4(widget.parentData[2])
    ];
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return Column(children: [
      if (MediaQuery.of(context).size.width > 1000)
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          topButton(0, trans.translate("Income Statement")),
          const SizedBox(width: 20),
          topButton(1, trans.translate("Balance Sheet")),
          const SizedBox(width: 20),
          topButton(2, trans.translate("Cashflow Statement"))
        ])
      else
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            topButton(0, trans.translate("Income Statement")),
            const SizedBox(height: 5),
            topButton(1, trans.translate("Balance Sheet")),
            const SizedBox(height: 5),
            topButton(2, trans.translate("Cashflow Statement"))
          ]),
        ),
      widgets[pageIndex]
    ]);
  }

  Widget topButton(int index, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          pageIndex = index;
        });
      },
      child: Container(
        width:
            MediaQuery.of(context).size.width < 1000 ? double.maxFinite : 250,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: pageIndex == index ? kPrimaryColor : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPrimaryColor)),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}

class SingleCartDataModel {
  final DateTime time;
  final int sales;

  SingleCartDataModel(this.time, this.sales);
}
