import 'package:aktientool/charts/chart2/data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyLineChart extends StatelessWidget {
  final List<ChartData> points;
  List<Color> bgradientColors = [const Color.fromARGB(255, 255, 255, 255)];

  MyLineChart(this.points, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: LineChart(LineChartData(lineBarsData: [
        LineChartBarData(
            colors: bgradientColors,
            barWidth: 1,
            spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
            dotData: FlDotData(show: false)),
      ])),
    );
  }
}
