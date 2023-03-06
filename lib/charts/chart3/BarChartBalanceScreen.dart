// ignore_for_file: file_names, empty_catches

import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/charts/chart3/BalanceReportModel.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../chart2/IncomeReportModel.dart';
import 'data.dart';

class BarChartBalanceScreen extends StatefulWidget {
  const BarChartBalanceScreen({super.key});

  @override
  State<BarChartBalanceScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartBalanceScreen> {
  late Future<List<BalanceReportModel>> getDataFuture;

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  void initState() {
    getDataFuture = BalanceService().getData(
        "https://financialmodelingprep.com/api/v3/balance-sheet-statement/$stock?limit=20&apikey=${Env.fmpKey}");
    super.initState();
  }

  double calculateChartWidth(
      Map<String, bool> showBarsNotifier, List<BalanceReportModel> data) {
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
    return FutureBuilder<List<BalanceReportModel>>(
      future: getDataFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BalanceReportModel> data = snapshot.data!;
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
                valueListenable: BalanceService.isSelected,
                builder: (BuildContext context,
                    Map<String, bool> showBarsNotifier, Widget? child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                                          reservedSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  1000
                                              ? 50
                                              : 100,
                                          showTitles: true,
                                          getTitlesWidget:
                                              (double value, meta) {
                                            return Text(
                                              MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      1000
                                                  ? numberToKFormat(value)
                                                  : value.toStringAsFixed(0),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            );
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
                                                    BalanceService.colors[i])
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
                                      BalanceService.colors[index])
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
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
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

String numberToKFormat(double number) {
  final formatter = NumberFormat.compact(locale: 'en_US');
  formatter.significantDigits = 3;
  formatter.maximumFractionDigits = 3;
  return formatter.format(number);
}
