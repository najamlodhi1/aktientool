import 'package:aktientool/charts/chart2/data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyLineChart extends StatelessWidget {
  final List<ChartData> points;
  List<Color> bgradientColors = [const Color.fromARGB(255, 255, 255, 255)];

  MyLineChart(this.points, {Key? key}) : super(key: key);
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
              rightTitles: SideTitles(showTitles: false),
              topTitles: SideTitles(showTitles: false),
              bottomTitles: _bottomTitles),
          lineBarsData: [
            LineChartBarData(
              colors: gradientColors,
              barWidth: 2,
              spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
              dotData: FlDotData(show: false),
              show: true,
            ),
          ],
        ),
      ),
    );
  }
}

SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      interval: 9,
      getTitles: (xValue) {
        String text = '';
        switch (xValue.toInt()) {
          case 1:
            text = 'Jan';
            break;
          case 2:
            text = 'Feb';
            break;
          case 3:
            text = 'Mar';
            break;
          case 4:
            text = 'Apr';
            break;
          case 5:
            text = 'May';
            break;
          case 6:
            text = 'Jun';
            break;
          case 7:
            text = 'Jul';
            break;
          case 8:
            text = 'Aug';
            break;
          case 9:
            text = 'Sep';
            break;
          case 10:
            text = 'Oct';
            break;
          case 11:
            text = 'Nov';
            break;
          case 12:
            text = 'Dec';
            break;
        }

        return text;
      },
    );
