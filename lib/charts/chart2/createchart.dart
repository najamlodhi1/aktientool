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
  int yearsBack = 40;
  static String modifiedDate = "";
  // Für 4 h
  //https://financialmodelingprep.com/api/v3/historical-chart/4hour/AAPL?apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
  var fromURL = "";
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  initState() {
    super.initState();

// Zeigt Alle
  }

  @override
  Widget build(BuildContext context) {
    modifiedDate = DateTime(
            selectedDate.year - yearsBack, selectedDate.month, selectedDate.day)
        .toString()
        .substring(0, 10);
    print(modifiedDate);

    fromURL =
        "https://financialmodelingprep.com/api/v3/historical-price-full/$stock?from=$modifiedDate&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";

    return Column(
      children: [
/*

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SfSparkLineChart.custom(
              trackball: const SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap),
              marker: const SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all),
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              xValueMapper: (int index) => data[index].year,
              yValueMapper: (int index) => data[index].sales,
              dataCount: 5,
            ),
          ),
        ),

*/
        FutureBuilder(
            future: RemoteService().getData(fromURL),
//getDatas(fromURL),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Wrap(
                    children: [
                      SfCartesianChart(
                        primaryXAxis: DateTimeAxis(),
                        title: ChartTitle(text: 'YESSS'),
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          header: "",
                          //decimalPlaces: 111,
                        ),
                        series: <ChartSeries<SalesData, DateTime>>[
                          AreaSeries<SalesData, DateTime>(
                            dataSource: chartData2,
                            xValueMapper: (SalesData data, _) => data.year,
                            yValueMapper: (SalesData data, _) => data.price,
                            borderWidth: 1,
                            borderGradient: const LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(230, 0, 180, 1),
                                  Color.fromRGBO(255, 200, 0, 1)
                                ],
                                stops: <double>[
                                  0.2,
                                  0.9
                                ]),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.teal,
                            style: BorderStyle.none,
                            width: 2,
                          ),
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          children: [
/*
                            const Text(
                              'Line Chart',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),*/
                            const SizedBox(
                              height: 20,
                            ),
                            //MyLineChart(
                            //  chartData,
                            //),
                            const SizedBox(
                              height: 20,
                            ),
                            Wrap(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 1;
                                      });
                                    },
                                    child: const Text("1 y")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 3;
                                      });
                                    },
                                    child: const Text("3 y")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 5;
                                      });
                                    },
                                    child: const Text("5 y")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 10;
                                      });
                                    },
                                    child: const Text("10 y")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        yearsBack = 20;
                                      });
                                    },
                                    child: const Text("20 y")),
                                ElevatedButton(
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
                return const CircularProgressIndicator();
              }
            }),
      ],
    );
  }
}
