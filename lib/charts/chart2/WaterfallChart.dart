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
    "Interest Expense",
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
                '${((titles[groupIndex] == 'Interest Expense') ? 'Operating Income' : titles[groupIndex])}\n${numberToKFormat(rod.toY)}',
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
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              reservedSize: 30,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int value = int.parse(meta.formattedValue);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(titles[value],
                      style: const TextStyle(color: Colors.white)),
                );
              },
            )),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: List.generate(
            titles.length,
            (index) => BarChartGroupData(x: index, barRods: [
                  BarChartRodData(
                      borderRadius: BorderRadius.circular(3),
                      toY: widget.data
                          .firstWhere(
                              (element) => element.title == titles[index])
                          .value,
                      color: (index % 2) == 0 ? Colors.green : Colors.red,
                      width:
                          MediaQuery.of(context).size.width > 1200 ? 70 : 20),
                ]))));
  }
}
