import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'BarChartData.dart';
import 'package:intl/intl.dart';

class BarChartScreen extends StatefulWidget {
  BarChartScreen({super.key});

  static ValueNotifier<bool> showCostOfRevenueNotifier =
      ValueNotifier<bool>(true);

  @override
  State<BarChartScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  String numberToKFormat(double number) {
    final formatter = NumberFormat.compact(locale: 'en_US');
    formatter.significantDigits = 3;
    formatter.maximumFractionDigits = 3;
    return formatter.format(number);
  }

  late Future<List<BarChartDataModel>> getDataFuture;

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  void initState() {
    getDataFuture = RemoteService().getData(
        "https://financialmodelingprep.com/api/v3/income-statement/$stock?limit=20&apikey=${Env.fmpKey}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BarChartDataModel>>(
      future: getDataFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BarChartDataModel> data = snapshot.data!;
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                style: BorderStyle.none,
                width: 2,
              ),
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12.0),
                    child: ValueListenableBuilder(
                      valueListenable: BarChartScreen.showCostOfRevenueNotifier,
                      builder:
                          (BuildContext context, bool showCost, Widget? child) {
                        return BarChart(BarChartData(
                            borderData:
                                FlBorderData(border: Border.all(width: 0)),
                            groupsSpace: 15,
                            titlesData: FlTitlesData(
                                show: true,
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval:
                                        MediaQuery.of(context).size.width < 1000
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
                                                : null),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        reservedSize:
                                            MediaQuery.of(context).size.width <
                                                    1000
                                                ? 50
                                                : 100,
                                        showTitles: true,
                                        getTitlesWidget: (double value, meta) {
                                          return Text(MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  1000
                                              ? numberToKFormat(value)
                                              : value.toStringAsFixed(0));
                                        }))),
                            barGroups: data
                                .map((e) => BarChartGroupData(
                                        x: MediaQuery.of(context).size.width <
                                                1000
                                            ? int.parse(
                                                DateFormat('yy').format(e.year))
                                            : e.year.year,
                                        barRods: [
                                          BarChartRodData(
                                              toY: e.revenue,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      1000
                                                  ? 4
                                                  : 20,
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          if (showCost)
                                            BarChartRodData(
                                                toY: e.costOfRevenueData,
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        1000
                                                    ? 4
                                                    : 20,
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5))
                                        ]))
                                .toList()));
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(100))),
                    const SizedBox(width: 5),
                    const Text('Revenue'),
                    const SizedBox(width: 30),
                    Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100))),
                    const SizedBox(width: 5),
                    const Text('Cost of Revenue')
                  ],
                ),
                const SizedBox(width: 15),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
