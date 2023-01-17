import 'package:aktientool/charts/chart4/data.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CreateChart4 extends StatefulWidget {
  @override
  State<CreateChart4> createState() => CreateChart4State();
}

class CreateChart4State extends State<CreateChart4> {
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
        "https://financialmodelingprep.com/api/v3/cash-flow-statement/$stock?limit=20&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";

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
                              title: ChartTitle(text: 'Cash Flow Statement'),
                              series: <ChartSeries>[
                                ColumnSeries<Data1, DateTime>(
                                    dataSource: chartData1,
                                    markerSettings:
                                        const MarkerSettings(isVisible: true),
                                    name: '1',
                                    xValueMapper: (Data1 data, _) => data.year,
                                    yValueMapper: (Data1 data, _) =>
                                        data.information,
                                    color:
                                        const Color.fromARGB(255, 48, 220, 174),
                                    spacing: 0.5,
                                    width: 1),
                                ColumnSeries<Data2, DateTime>(
                                  markerSettings:
                                      const MarkerSettings(isVisible: true),
                                  name: '2',
                                  dataSource: chartData2,
                                  xValueMapper: (Data2 data, _) => data.year,
                                  yValueMapper: (Data2 data, _) =>
                                      data.information,
                                  color:
                                      const Color.fromARGB(255, 33, 210, 254),
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
