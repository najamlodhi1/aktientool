// ignore_for_file: empty_catches, file_names

import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../settings/app_localizations.dart';
import '../chart2/IncomeReportModel.dart';
import '../chart2/createchart.dart';
import '../chart3/BarChartBalanceScreen.dart';
import 'CashFlowReportModel.dart';
import 'data.dart';

class BarChartCashFlowScreen extends StatefulWidget {
  const BarChartCashFlowScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<BarChartCashFlowScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartCashFlowScreen> {
  int selectedReportIndex = 0;

  late AppLocalizations trans;

  late Future<List<CashFlowReportModel>> getDataFuture;

  @override
  void initState() {
    getDataFuture = CashFlowService().getData(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return FutureBuilder<List<CashFlowReportModel>>(
      future: getDataFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CashFlowReportModel> data = snapshot.data!;
          data.sort((a, b) => b.date.compareTo(a.date));
          List<CashFlowReportModel> barData = data;
          barData.sort((a, b) => a.date.compareTo(b.date));
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                style: BorderStyle.none,
                width: 2,
              ),
              color: primaryColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ValueListenableBuilder<String>(
                valueListenable: CashFlowService.selectedTitle,
                builder: (BuildContext context, String showBarsNotifier,
                    Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                                numberToKFormat(
                                    gettotalAmount(data, showBarsNotifier)),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 60,
                                    color: Colors.blueGrey)),
                            Text(trans.translate(showBarsNotifier),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    color: Colors.white)),
                            // const Text(
                            //    "All numbers are in thousands, Currency in USD"),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Container(
                          height: 400,
                          padding: const EdgeInsets.all(12.0),
                          child: BarChart(BarChartData(
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(
                                  border: Border.all(width: 0), show: false),
                              groupsSpace:
                                  MediaQuery.of(context).size.width - 450,
                              // groupsSpace:
                              //     calculateChartWidth(showBarsNotifier, data),
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  fitInsideVertically: true,
                                  fitInsideHorizontally: true,
                                  tooltipBgColor: Colors.black,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                      '${DateFormat('yyyy-MM-dd').format(data[groupIndex].date)}\n${trans.translate(data[0].reports[rodIndex].title)}\n${numberToKFormat(rod.toY)}',
                                      TextStyle(
                                        color: rod.color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              alignment: BarChartAlignment.spaceEvenly,
                              titlesData: FlTitlesData(show: false),
                              barGroups: data
                                  .map((e) => BarChartGroupData(
                                          barsSpace: 10,
                                          x: MediaQuery.of(context).size.width <
                                                  1000
                                              ? int.parse(DateFormat('yy')
                                                  .format(e.date))
                                              : e.date.year,
                                          barRods: [
                                            createRod(e.reports[e.reports
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    showBarsNotifier)])
                                          ]))
                                  .toList()))),
                      const SizedBox(height: 10),
                      const Text("Growth Rate:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Colors.white)),
                      const SizedBox(height: 5),
                      Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: List.generate(
                              data.length,
                              (index) => createLegend(
                                  barData[index], barData, index))),
                      const SizedBox(width: 15),
                    ],
                  );
                }),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget createLegend(
      CashFlowReportModel report, List<CashFlowReportModel> data, int index) {
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
          Text(report.date.year.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(width: 5),
          Text(
            '${index < (data.length - 1) ? calculatepercentage(data[data.length - 1 - index].reports[selectedReportIndex].value, data[data.length - 1 - index - 1].reports[selectedReportIndex].value).toStringAsFixed(2) : 'N/A'}%',
            style: TextStyle(
                color: (index < data.length - 1
                    ? data[data.length - 1 - index]
                                .reports[selectedReportIndex]
                                .value >=
                            data[data.length - 1 - index - 1]
                                .reports[selectedReportIndex]
                                .value
                        ? Colors.green
                        : Colors.red
                    : Colors.grey),
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  double gettotalAmount(List<CashFlowReportModel> data, String title) {
    double amount = 0;
    selectedReportIndex =
        data[0].reports.indexWhere((element) => element.title == title);

    for (var report in data) {
      amount += report.reports[selectedReportIndex].value;
    }
    return amount;
  }

  BarChartRodData createRod(ReportItemModel value) {
    return BarChartRodData(
        toY: value.value,
        width: MediaQuery.of(context).size.width < 1000 ? 4 : 13,
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5));
  }
}
