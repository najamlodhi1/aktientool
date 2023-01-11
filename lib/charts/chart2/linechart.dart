import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'createchart.dart';
import 'data.dart';

class MyLineChart extends StatelessWidget {
  final List<ChartData> points;
  List<Color> bgradientColors = [const Color.fromARGB(255, 255, 255, 255)];
  MyLineChart(this.points, {Key? key}) : super(key: key);

  static int xlength = 0;

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              barWidth: 2,
              spots: points
                  .map((point) => FlSpot(
                        point.year.toDouble(),
                        point.price,
                      ))
                  .toList(),
              dotData: FlDotData(show: false),
              show: true,
            ),
          ],
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }
}

SideTitles get _bottomTitles => SideTitles(
      //interval: 4,
      showTitles: true,
      getTitlesWidget: (value, meta) {
        print(value.toString());
        int inter = MyLineChart.xlength;

        if (inter <= 250) {
          // 1 Jahr
          String text;
          switch (value.toInt()) {
            case 0:
              text = CreateChartState.modifiedDate.toString();
              break;
            case 50:
              text = 'Mar';
              break;
            case 100:
              text = 'Mai';
              break;
            case 150:
              text = 'Jul';
              break;
            case 200:
              text = 'Sep';
              break;
            case 250:
              text = 'Nov';
              break;

            default:
              return Container();
          }

          return Text(text);
        } else if (inter > 250 && inter <= 755) {
          // 3 years
          if (value.toInt() == 0) {
            return const Text("2021");
          } else if (value.toInt() == 400) {
            return const Text("2022");
          } else if (value.toInt() == inter) {
            return const Text("2023");
          }
        } else if (inter > 800 && inter <= 1300) {
          // 5 years
          if (value.toInt() == 0) {
            return const Text("2018");
          } else if (value.toInt() == 300) {
            return const Text("2019");
          } else if (value.toInt() == 500) {
            return const Text("2020");
          } else if (value.toInt() == 700) {
            return const Text("2021");
          } else if (value.toInt() == 1000) {
            return const Text("2022");
          } else if (value.toInt() == inter) {
            return const Text("2023");
          }
        }

        return const Text("");
      },
    );

Widget get_bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 10,
    color: Colors.purple,
    fontWeight: FontWeight.bold,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Jan';
      break;
    case 1:
      text = 'Feb';
      break;
    case 2:
      text = 'Mar';
      break;
    case 3:
      text = 'Apr';
      break;
    case 4:
      text = 'May';
      break;
    case 5:
      text = 'Jun';
      break;
    case 6:
      text = 'Jul';
      break;
    case 7:
      text = 'Aug';
      break;
    case 8:
      text = 'Sep';
      break;
    case 9:
      text = 'Oct';
      break;
    case 10:
      text = 'Nov';
      break;
    case 11:
      text = 'Dec';
      break;
    default:
      return Container();
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}


/*
class MyLineChart extends StatelessWidget {
  final List<ChartData> points;
  List<Color> bgradientColors = [const Color.fromARGB(255, 255, 255, 255)];

  MyLineChart(this.points, {Key? key}) : super(key: key);
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6,
      child: Padding(
        padding: const EdgeInsets.only(left: 28, right: 18),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: points.map((point) => FlSpot(1, point.y)).toList(),
                isCurved: true,
                barWidth: 3,
                color: Colors.blue,
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            betweenBarsData: [
              BetweenBarsData(
                fromIndex: 0,
                toIndex: 2,
                color: Colors.red.withOpacity(0.3),
              )
            ],
            minY: 0,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 6 || value == 4 || value == 5;
              },
            ),
          ),
        ),
      ),
    );
  }
}
*/