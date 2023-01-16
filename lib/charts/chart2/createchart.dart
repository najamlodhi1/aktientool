import 'package:aktientool/charts/chart2/data.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CreateChart2 extends StatefulWidget {
  @override
  State<CreateChart2> createState() => CreateChart2State();
}

class CreateChart2State extends State<CreateChart2> {
  var selectedDate = DateTime.now();
  static String modifiedDate = "";
  var fromURL = "";
  int yearsBack = 10;
  late TrackballBehavior _trackballBehavior;

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  late CrosshairBehavior _crosshairBehavior;

  @override
  void initState() {
    _crosshairBehavior = CrosshairBehavior(
        enable: true,
        lineColor: Colors.red,
        lineDashArray: <double>[5, 5],
        lineWidth: 2,
        lineType: CrosshairLineType.vertical);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fromURL =
        "https://financialmodelingprep.com/api/v3/income-statement/$stock?limit=20&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
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
                              crosshairBehavior: _crosshairBehavior,
                              primaryXAxis: DateTimeAxis(),
                              tooltipBehavior: TooltipBehavior(
                                enable: true, format: 'point.y',

                                //header: ,
                              ),
                              title:
                                  ChartTitle(text: 'Umsatz & Gewinn & Verlust'),
                              series: <ChartSeries>[
                                ColumnSeries<Data1, DateTime>(
                                    dataSource: chartData1,
                                    markerSettings:
                                        const MarkerSettings(isVisible: true),
                                    name: 'Umsatz',
                                    xValueMapper: (Data1 data, _) => data.year,
                                    yValueMapper: (Data1 data, _) =>
                                        data.information,
                                    color:
                                        const Color.fromARGB(255, 48, 220, 174),
                                    spacing: 0.5,
                                    width: 1),
                                LineSeries<Data4, DateTime>(
                                    dataSource: chartData4,
                                    markerSettings:
                                        const MarkerSettings(isVisible: true),
                                    name: 'Gewinnmarge',
                                    xValueMapper: (Data4 data, _) => data.year,
                                    yValueMapper: (Data4 data, _) =>
                                        data.information,
                                    color:
                                        const Color.fromARGB(255, 220, 48, 166),
                                    width: 2),
                                ColumnSeries<Data2, DateTime>(
                                  markerSettings:
                                      const MarkerSettings(isVisible: true),
                                  name: 'incomeBeforeTax ',
                                  dataSource: chartData2,
                                  xValueMapper: (Data2 data, _) => data.year,
                                  yValueMapper: (Data2 data, _) =>
                                      data.information,
                                  color:
                                      const Color.fromARGB(255, 33, 210, 254),
                                  spacing: 0.5,
                                ),
                                ColumnSeries<Data3, DateTime>(
                                  markerSettings:
                                      const MarkerSettings(isVisible: true),
                                  name: 'netIncome ',
                                  dataSource: chartData3,
                                  xValueMapper: (Data3 data, _) => data.year,
                                  yValueMapper: (Data3 data, _) =>
                                      data.information,
                                  color: const Color.fromARGB(255, 25, 0, 255),
                                  spacing: 0.5,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
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
