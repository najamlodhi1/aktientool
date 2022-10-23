import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartUsers extends StatelessWidget {
  const BarChartUsers({Key? key}) : super(key: key);

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 2:
              text = 'jan 6';
              break;
            case 4:
              text = 'Mar';
              break;
            case 6:
              text = 'May';
              break;
            case 8:
              text = 'Jul';
              break;
            case 10:
              text = 'Sep';
              break;
            case 12:
              text = 'Nov';
              break;
          }

          return Text(text);
        },
      );

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        borderData: FlBorderData(border: Border.all(width: 0)),
        groupsSpace: 15,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(sideTitles: _bottomTitles),
          leftTitles: AxisTitles(sideTitles: _bottomTitles),
        ),
        barGroups: []));
  }
}
