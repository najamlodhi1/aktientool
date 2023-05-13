import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../chart3/BarChartBalanceScreen.dart';
import 'IncomeReportModel.dart';

class WaterfallChart extends StatefulWidget {
  const WaterfallChart(this.data, {super.key});
  final List<ReportItemModel> data;

  @override
  State<WaterfallChart> createState() => _WaterfallChartState();
}

class _WaterfallChartState extends State<WaterfallChart> {
  List<String> titles = [
    "Revenue",
    "Cost of Revenue",
    "Gross Profit",
    "Operating Expenses",
    "Operating Income",
    "Other Expenses",
    "Net Income"
  ];

  double get calculateChartWidth {
    double interval = MediaQuery.of(context).size.width < 1200
        ? MediaQuery.of(context).size.width + 50
        : MediaQuery.of(context).size.width / 2;

    return interval;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        groupsSpace: calculateChartWidth,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(border: Border.all(width: 0)),
        alignment: BarChartAlignment.spaceBetween,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            tooltipBgColor: Colors.black,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${titles[groupIndex]}\n${numberToKFormat(widget.data.firstWhere((element) => element.title == titles[groupIndex]).value)}',
                TextStyle(
                    color: groupIndex % 2 == 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(
                sideTitles: SideTitles(
                    reservedSize: 30,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            numberToKFormat(((value.toInt() % 2) != 0 &&
                                    value.toInt() > 0)
                                ? ((widget.data
                                        .firstWhere((element) =>
                                            element.title ==
                                            titles[value.toInt()])
                                        .value) -
                                    (widget.data
                                        .firstWhere((element) =>
                                            element.title ==
                                            titles[value.toInt() - 1])
                                        .value))
                                : (widget.data
                                    .firstWhere((element) =>
                                        element.title == titles[value.toInt()])
                                    .value)),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ));
                    })),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              reservedSize: 100,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Transform.rotate(
                      alignment: Alignment.centerLeft,
                      angle: 0.785398,
                      child: Text(
                        titles[value.toInt()],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ));
              },
            )),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: List.generate(
            titles.length,
            (index) => BarChartGroupData(x: index, barRods: [
                  BarChartRodData(
                      borderRadius: BorderRadius.circular(3),
                      fromY: ((index % 2) != 0 && index > 0)
                          ? widget.data
                              .firstWhere((element) =>
                                  element.title == titles[index - 1])
                              .value
                          : null,
                      toY: ((index % 2) != 0 && index > 0)
                          ? widget.data
                              .firstWhere((element) =>
                                  element.title == titles[index + 1])
                              .value
                          : widget.data
                              .firstWhere(
                                  (element) => element.title == titles[index])
                              .value,
                      color: (index % 2) == 0 ? Colors.green : Colors.red,
                      width:
                          MediaQuery.of(context).size.width > 1200 ? 70 : 20),
                ]))));
  }
}
