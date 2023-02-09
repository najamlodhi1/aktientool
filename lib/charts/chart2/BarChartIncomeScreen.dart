import 'package:aktientool/charts/chart2/IncomeReportModel.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:intl/intl.dart';

class BarChartIncomeScreen extends StatefulWidget {
  const BarChartIncomeScreen({super.key});

  @override
  State<BarChartIncomeScreen> createState() => _BarChartIncomeScreenState();
}

class _BarChartIncomeScreenState extends State<BarChartIncomeScreen> {
  String numberToKFormat(double number) {
    final formatter = NumberFormat.compact(locale: 'en_US');
    formatter.significantDigits = 3;
    formatter.maximumFractionDigits = 3;
    return formatter.format(number);
  }

  late Future<List<IncomeReportModel>> getDataFuture;

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  void initState() {
    getDataFuture = IncomeService().getData(
        "https://financialmodelingprep.com/api/v3/income-statement/$stock?limit=20&apikey=${Env.fmpKey}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IncomeReportModel>>(
      future: getDataFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<IncomeReportModel> data = snapshot.data!;
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
            child: ValueListenableBuilder<Map<String, bool>>(
                valueListenable: IncomeService.isSelected,
                builder: (BuildContext context,
                    Map<String, bool> showBarsNotifier, Widget? child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 600,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(12.0),
                          child: BarChart(BarChartData(
                              borderData:
                                  FlBorderData(border: Border.all(width: 0)),
                              groupsSpace: 15,
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
                                                  : null),
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
                                              ? int.parse(DateFormat('yy')
                                                  .format(e.date))
                                              : e.date.year,
                                          barRods: [
                                            for (int i = 0;
                                                i < e.reports.length;
                                                i++)
                                              if (showBarsNotifier[
                                                  e.reports[i].title]!)
                                                createRod(e.reports[i],
                                                    IncomeService.colors[i])
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
                                      IncomeService.colors[index])
                                  : Container())),
                      const SizedBox(width: 15),
                    ],
                  );
                }),
          );
        }
        return const Center(child: CircularProgressIndicator());
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
        Text(title),
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
