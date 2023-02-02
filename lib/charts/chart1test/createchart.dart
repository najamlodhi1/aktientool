import 'package:aktientool/charts/chart1test/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CreateChart1Test extends StatefulWidget {
  @override
  State<CreateChart1Test> createState() => CreateChart1TestState();
}

class CreateChart1TestState extends State<CreateChart1Test> {
  var chartData;
  List<FlSpot> getFLData = [];

  var selectedDate = DateTime.now();
  var fromURL = "";
  int anzeige = 2;

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(const Color.fromARGB(255, 58, 255, 202));
    color.add(const Color.fromARGB(255, 33, 254, 195));
    color.add(const Color.fromARGB(255, 0, 255, 200));

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);

    //print("$stock $modifiedDate");

    sfc() {
      return SfCartesianChart(
        title: ChartTitle(text: 'Chart'),
        legend: Legend(isVisible: false),
        trackballBehavior: TrackballBehavior(
          shouldAlwaysShow: true,
          activationMode: ActivationMode.singleTap,
          tooltipDisplayMode: TrackballDisplayMode.none,
          enable: true,
        ),
        crosshairBehavior: CrosshairBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          lineWidth: 0.6,
        ),
        enableAxisAnimation: true,
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: "",
        ),
        series: <ChartSeries<ChartData, DateTime>>[
          AreaSeries<ChartData, DateTime>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.year,
            yValueMapper: (ChartData data, _) => data.data,
            gradient: gradientColors,
            borderWidth: 1,
            borderGradient: const LinearGradient(
              colors: <Color>[
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0)
              ],
              stops: <double>[0.2, 0.9],
            ),
          ),
        ],
        primaryXAxis: DateTimeAxis(),
      );
    }

    btn() {
      return SizedBox(
        child: Wrap(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background
                ),
                onPressed: () {
                  setState(() {
                    chartData = chartData1;
                    getFLData = flchartData1;
                  });
                },
                child: const Text("1 y")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background
                ),
                onPressed: () {
                  setState(() {
                    chartData = chartData3;
                    getFLData = flchartData3;
                  });
                },
                child: const Text("3 y")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background
                ),
                onPressed: () {
                  setState(() {
                    chartData = chartData5;
                    getFLData = flchartData5;
                  });
                },
                child: const Text("5 y")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background
              ),
              onPressed: () {
                setState(() {
                  chartData = chartData10;
                  getFLData = flchartData10;
                });
              },
              child: const Text("10 y"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background
              ),
              onPressed: () {
                setState(() {
                  chartData = chartDataMax;
                  getFLData = flchartDataMax;
                });
              },
              child: const Text("Max"),
            ),

            //
          ],
        ),
      );
    }

    flc() {
      return FutureBuilder(
        future: RemoteService().getData(fromURL),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (getFLData.isEmpty) {
              getFLData = flchartData10;
            }

            var x = snapshot.data as List<FlSpot>;

            //print(getFLData);
            //print("--------------------------------------------------------");
            //print(x);
            return AspectRatio(
              aspectRatio: 2,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                        spots: //flchartData10,

                            getFLData
                                .map((point) => FlSpot(point.x, point.y))
                                .toList(),
                        isCurved: true,
                        dotData: FlDotData(
                          show: false,
                        ),
                        color: Colors.red),
                  ],
                  borderData: FlBorderData(
                      border: const Border(
                          bottom: BorderSide(), left: BorderSide())),
                  gridData: FlGridData(show: true),
                  backgroundColor: Colors.black,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          anzeige += 1;

                          if (anzeige == 3) {
                            anzeige = 0;
                            String date = chartDataMax[value.toInt()]
                                .year
                                .toString()
                                .substring(0, 7);

                            return Text(date);
                          }
                          return const Text("");
                        },
                      ),
                    ),
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    }

    fromURL =
        "https://financialmodelingprep.com/api/v3/historical-price-full/$stock?serietype=line&apikey=${Env.fmpKey}";

    showChart() {
      return SingleChildScrollView(
        child: Wrap(
          children: [
            Container(
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
                children: [
                  /*const SizedBox(
                    height: 20,
                  ),
                  sfc(),
                */

                  flc(),
                  const SizedBox(
                    height: 20,
                  ),
                  btn(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (chartData != null) {
      return showChart();
    } else {
      return Column(
        children: [
          FutureBuilder(
            future: RemoteService().getData(fromURL),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                chartData ??= chartData10;
                return showChart();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      );
    }
  }
}
