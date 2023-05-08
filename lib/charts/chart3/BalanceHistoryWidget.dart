import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart0/createchart.dart';
import '../chart3/BarChartBalanceScreen.dart';
import 'BalanceReportModel.dart';

class BalanceHistoryWidget extends StatefulWidget {
  const BalanceHistoryWidget(
      {super.key,
      required this.data,
      required this.selectedtitle,
      required this.selectedindex});
  final List<BalanceReportModel> data;
  final String selectedtitle;
  final int selectedindex;

  @override
  State<BalanceHistoryWidget> createState() => _BalanceHistoryWidgetState();
}

class _BalanceHistoryWidgetState extends State<BalanceHistoryWidget> {
  int selectedReportIndex = 0;
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.teal,
            style: BorderStyle.none,
            width: 2,
          ),
          color: primaryColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    numberToKFormat(
                        gettotalAmount(widget.data, widget.selectedtitle)),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 60,
                        color: Colors.blueGrey)),
                Text(trans.translate(widget.selectedtitle),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Colors.white)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Growth Rate:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Colors.white)),
                const SizedBox(height: 5),
                Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      createLegend(1),
                      createLegend(3),
                      createLegend(5),
                      createLegend(7),
                      createLegend(10),
                    ]),
              ],
            )
          ],
        ));
  }

  Widget createLegend(int year) {
    double current = 0, previous = 0;

    for (var i = 0; i < year; i++) {
      current += widget
          .data[widget.data.length - 1 - i].reports[widget.selectedindex].value;
    }
    for (var i = year; i < (year + year); i++) {
      previous += widget
          .data[widget.data.length - 1 - i].reports[widget.selectedindex].value;
    }

    double value = ((current * 100) / previous) - 100;

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white10,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$year Year',
              style: const TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(width: 5),
          Text(
            '${value.toStringAsFixed(2)}%',
            style: TextStyle(
                color: !value.isNegative ? Colors.green : Colors.red,
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  double gettotalAmount(List<BalanceReportModel> data, String title) {
    double amount = 0;
    selectedReportIndex =
        data[0].reports.indexWhere((element) => element.title == title);

    for (var report in data) {
      amount += report.reports[selectedReportIndex].value;
    }
    return amount;
  }
}
