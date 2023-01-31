import 'package:aktientool/charts/chart1/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants/constants.dart';

class CreateChart1 extends StatefulWidget {
  @override
  State<CreateChart1> createState() => CreateChart1State();
}

class CreateChart1State extends State<CreateChart1> {
  var selectedDate = DateTime.now();
  static String modifiedDate = "";

  // Für 4 h
  //https://financialmodelingprep.com/api/v3/historical-chart/4hour/AAPL?apikey=${FMPKEY}";
  var fromURL = "";
  int yearsBack = 10;

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  initState() {
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

    modifiedDate = DateTime(
            selectedDate.year - yearsBack, selectedDate.month, selectedDate.day)
        .toString()
        .substring(0, 10);
    //print("$stock $modifiedDate");

    fromURL =
        "https://financialmodelingprep.com/api/v3/historical-price-full/$stock?from=$modifiedDate&apikey=${Env.fmpKey}";

    return Column(
      children: [
        FutureBuilder(
          future: RemoteService().getData(fromURL),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot);
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
                            //title: ChartTitle(text: 'YESSS'),
                            legend: Legend(isVisible: false),
                            trackballBehavior: TrackballBehavior(
                              shouldAlwaysShow: true,
                              activationMode: ActivationMode.singleTap,
                              enable: true,
                            ),
                            enableAxisAnimation: true,
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              header: "",
                            ),
                            crosshairBehavior: CrosshairBehavior(enable: true, activationMode: ActivationMode.singleTap, lineWidth: 0.6,),
                            series: <ChartSeries<SalesData, DateTime>>[
                              AreaSeries<SalesData, DateTime>(
                                dataSource: chartData2,
                                xValueMapper: (SalesData data, _) => data.year,
                                yValueMapper: (SalesData data, _) => data.price,
                                gradient: gradientColors,
                                borderWidth: 1,
                                borderGradient: const LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 0, 0, 0),
                                      Color.fromARGB(255, 0, 0, 0)
                                    ],
                                    stops: <double>[
                                      0.2,
                                      0.9
                                    ]),
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
                                      yearsBack = 1;
                                    });
                                  },
                                  child: const Text("1 y")),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black, // background
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      yearsBack = 3;
                                    });
                                  },
                                  child: const Text("3 y")),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black, // background
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      yearsBack = 5;
                                    });
                                  },
                                  child: const Text("5 y")),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // background
                                ),
                                onPressed: () {
                                  setState(() {
                                    yearsBack = 10;
                                  });
                                },
                                child: const Text("10 y"),
                              ),
                              /*ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black, // background
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 20;
                                      });
                                    },
                                    child: const Text("20 y")),*/
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // background
                                ),
                                onPressed: () {
                                  setState(() {
                                    yearsBack = 40;
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
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
