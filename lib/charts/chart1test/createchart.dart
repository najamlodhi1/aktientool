import 'package:aktientool/charts/chart1test/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CreateChart1Test extends StatefulWidget {
  @override
  State<CreateChart1Test> createState() => CreateChart1TestState();
}

class CreateChart1TestState extends State<CreateChart1Test> {
  List<FlSpot> getFLData = [];
  int buttonIndex = 3;

  var selectedDate = DateTime.now();
  var fromURL = "";
  int anzeige = 2;

  final List<Color> color = [
    const Color(0xFF6FFF7C),
    const Color(0xFF0087FF),
    const Color(0xFF5620FF),
  ];

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  Widget build(BuildContext context) {
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
                    getFLData = flchartData1;
                    buttonIndex = 0;
                  });
                },
                child: const Text("1 y")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background
                ),
                onPressed: () {
                  setState(() {
                    getFLData = flchartData3;
                    buttonIndex = 1;
                  });
                },
                child: const Text("3 y")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background
                ),
                onPressed: () {
                  setState(() {
                    getFLData = flchartData5;
                    buttonIndex = 2;
                  });
                },
                child: const Text("5 y")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background
              ),
              onPressed: () {
                setState(() {
                  getFLData = flchartData10;
                  buttonIndex = 3;
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
                  getFLData = flchartDataMax;
                  buttonIndex = 4;
                });
              },
              child: const Text("Max"),
            ),

            //
          ],
        ),
      );
    }

    double calculateDateTitlesInterval(int btnIndex) {
      int maxScreenWidth = 1200;
      switch (btnIndex) {
        // 1 y
        case 0:
          return maxScreenWidth / MediaQuery.of(context).size.width * 30;
        // 3 y
        case 1:
          return maxScreenWidth / MediaQuery.of(context).size.width * 45;
        // 5 y
        case 2:
          return maxScreenWidth / MediaQuery.of(context).size.width * 70;
        // Max
        case 4:
          return maxScreenWidth / MediaQuery.of(context).size.width * 600;
        // 10 y
        default:
          return maxScreenWidth / MediaQuery.of(context).size.width * 150;
      }
    }

    flc() {
      if (getFLData.isEmpty) {
        getFLData = flchartData10;
      }

      return AspectRatio(
          aspectRatio: 2,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: getFLData
                      .map((point) => FlSpot(point.x, point.y))
                      .toList(),
                  //isCurved: false,
                  color: Colors.white,
                  barWidth: 2,
                  //isStrokeCapRound: false,
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
              ],
              borderData: FlBorderData(
                  border:
                      const Border(bottom: BorderSide(), left: BorderSide())),
              backgroundColor: Colors.black,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: calculateDateTitlesInterval(buttonIndex),
                    getTitlesWidget: (value, meta) {
                      //anzeige += 1;
                      //if (anzeige == 3) {
                      //anzeige = 0;
                      if (value == meta.min || value == meta.max) {
                        return const Text("");
                      }

                      String date = chartDataMax[value.toInt()]
                          .year
                          .toString()
                          .substring(0, 7);

                      return Text(date);
                      //} else {
                      //return const Text("");
                      //}
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
          ));
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

    if (getFLData.isNotEmpty) {
      return showChart();
    } else {
      return Column(
        children: [
          FutureBuilder(
            future: RemoteService().getData(fromURL),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
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
