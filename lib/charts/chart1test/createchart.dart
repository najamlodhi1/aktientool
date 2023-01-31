import 'package:aktientool/charts/chart1test/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CreateChart1Test extends StatefulWidget {
  @override
  State<CreateChart1Test> createState() => CreateChart1TestState();
}

class CreateChart1TestState extends State<CreateChart1Test> {
  var chartData;

  var selectedDate = DateTime.now();

  var fromURL = "";

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  initState() {
    FutureBuilder(
      future: RemoteService().getData(fromURL), // async work
      builder: (ctx, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Result: ${snapshot.data}');
            }
        }
      },
    );

    super.initState();
  }

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
                  const SizedBox(
                    height: 20,
                  ),
                  SfCartesianChart(
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // background
                          ),
                          onPressed: () {
                            setState(() {
                              chartData = chartData1;
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
                          });
                        },
                        child: const Text("Max"),
                      ),
                    ],
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
