// ignore_for_file: empty_catches, file_names

import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../settings/app_localizations.dart';
import '../chart2/IncomeReportModel.dart';
import 'CashFlowReportModel.dart';
import 'data.dart';

class BarChartCashFlowScreen extends StatefulWidget {
  const BarChartCashFlowScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<BarChartCashFlowScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartCashFlowScreen> {
  String numberToKFormat(double number) {
    final formatter = NumberFormat.compact(locale: 'en_US');
    formatter.significantDigits = 3;
    formatter.maximumFractionDigits = 3;
    return formatter.format(number);
  }

  late AppLocalizations trans;

  late Future<List<CashFlowReportModel>> getDataFuture;

  @override
  void initState() {
    getDataFuture = CashFlowService().getData(widget.data);
    super.initState();
  }

  double calculateChartWidth(
      Map<String, bool> showBarsNotifier, List<CashFlowReportModel> data) {
    double interval = MediaQuery.of(context).size.width < 1000 ? 200 : 400;
    double chartWidth = MediaQuery.of(context).size.width >= interval
        ? MediaQuery.of(context).size.width - interval
        : MediaQuery.of(context).size.width;

    try {
      for (int i = 0; i < data.length; i++) {
        if (showBarsNotifier[data[0].reports[i].title]!) {
          chartWidth += interval;
        }
      }
    } catch (err) {}

    return chartWidth;
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return FutureBuilder<List<CashFlowReportModel>>(
      future: getDataFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CashFlowReportModel> data = snapshot.data!;
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
            child: ValueListenableBuilder<Map<String, bool>>(
                valueListenable: CashFlowService.isSelected,
                builder: (BuildContext context,
                    Map<String, bool> showBarsNotifier, Widget? child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Cashflow",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 600,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(12.0),
                          child: BarChart(BarChartData(
                              backgroundColor: primaryColor,
                              borderData:
                                  FlBorderData(border: Border.all(width: 0)),
                              groupsSpace:
                                  calculateChartWidth(showBarsNotifier, data),
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  fitInsideVertically: true,
                                  fitInsideHorizontally: true,
                                  tooltipBgColor: Colors.black,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    Color? rodColor =
                                        rod.gradient?.colors[0] ?? rod.color;

                                    int currentIndex = 0;
                                    for (int colorIndex = 0;
                                        colorIndex < data.length;
                                        colorIndex++) {
                                      if (CashFlowService.colors[colorIndex] ==
                                          rodColor) {
                                        currentIndex = colorIndex;
                                        break;
                                      }
                                    }
                                    return BarTooltipItem(
                                      '${data[0].reports[currentIndex].title}\n${numberToKFormat(rod.toY)}',
                                      TextStyle(
                                        color: rodColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval:
                                          MediaQuery.of(context).size.width <
                                                  1000
                                              ? 2
                                              : null,
                                      getTitlesWidget: (double value, meta) {
                                        return Text(
                                          value.toStringAsFixed(0),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      1000
                                                  ? 11.5
                                                  : null,
                                              color: Colors.white),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          reservedSize: 70,
                                          showTitles: true,
                                          getTitlesWidget:
                                              (double value, meta) {
                                            if (value == meta.max ||
                                                value == meta.min) {
                                              return const Text("");
                                            } else {
                                              return Text(
                                                numberToKFormat(value),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              );
                                            }
                                          }))),
                              barGroups: data
                                  .map((e) => BarChartGroupData(
                                          x: MediaQuery.of(context).size.width <
                                                  1000
                                              ? int.parse(DateFormat('yy')
                                                  .format(e.date))
                                              : e.date.year,
                                          barRods: [
                                            for (int i = 0;
                                                i < e.reports.length;
                                                i++)
                                              if (showBarsNotifier[
                                                      e.reports[i].title] ==
                                                  true)
                                                createRod(e.reports[i],
                                                    CashFlowService.colors[i])
                                          ]))
                                  .toList()))),
                      Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: List.generate(
                              data.length,
                              (index) => showBarsNotifier[
                                      data[0].reports[index].title]!
                                  ? createLegend(data[0].reports[index].title,
                                      CashFlowService.colors[index])
                                  : Container())),
                      const SizedBox(width: 15),
                    ],
                  );
                }),
          );
        }
        //return const Center(child: CircularProgressIndicator());
        return const SizedBox();
      },
    );
  }

  Widget createLegend(String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(100))),
        const SizedBox(width: 5),
        Text(title, style: const TextStyle(color: Colors.white)),
        const SizedBox(width: 10),
      ],
    );
  }

  BarChartRodData createRod(ReportItemModel value, Color color) {
    return BarChartRodData(
        toY: value.value,
        width: MediaQuery.of(context).size.width < 1000 ? 4 : 13,
        color: color,
        borderRadius: BorderRadius.circular(5));
  }
}
