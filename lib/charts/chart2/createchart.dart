import 'package:aktientool/charts/chart2/data.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CreateChart extends StatefulWidget {
  @override
  State<CreateChart> createState() => CreateChartState();
}

class CreateChartState extends State<CreateChart> {
  var selectedDate = DateTime.now();
  static String modifiedDate = "";
  // Für 4 h
  //https://financialmodelingprep.com/api/v3/historical-chart/4hour/AAPL?apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
  var fromURL = "";
  int yearsBack = 10;

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "PLTR";

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
    print("$stock $modifiedDate");

    fromURL =
        "https://financialmodelingprep.com/api/v3/historical-price-full/$stock?from=$modifiedDate&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";

    return Column(
      children: [
        FutureBuilder(
            future: RemoteService().getData(fromURL),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
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
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                header: "",
                              ),
                              series: <ChartSeries<SalesData, DateTime>>[
                                AreaSeries<SalesData, DateTime>(
                                  dataSource: chartData2,
                                  xValueMapper: (SalesData data, _) =>
                                      data.year,
                                  yValueMapper: (SalesData data, _) =>
                                      data.price,
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
                                      backgroundColor:
                                          Colors.black, // background
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 1;
                                      });
                                    },
                                    child: const Text("1 y")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black, // background
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 3;
                                      });
                                    },
                                    child: const Text("3 y")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black, // background
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 5;
                                      });
                                    },
                                    child: const Text("5 y")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black, // background
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 10;
                                      });
                                    },
                                    child: const Text("10 y")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black, // background
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 20;
                                      });
                                    },
                                    child: const Text("20 y")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black, // background
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 40;
                                      });
                                    },
                                    child: const Text("Max")),
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
            }),
      ],
    );
  }
}
