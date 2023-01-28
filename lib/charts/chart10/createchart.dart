import 'package:aktientool/charts/chart10/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CreateChart10 extends StatefulWidget {
  @override
  State<CreateChart10> createState() => CreateChart10State();
}

class CreateChart10State extends State<CreateChart10> {
  var selectedDate = DateTime.now();
  static String modifiedDate = "";
  var fromURL = "";

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
        "https://financialmodelingprep.com/api/v4/advanced_discounted_cash_flow?symbol=$stock&apikey=${Env.fmpKey}";

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
                                enable: true, format: 'revenue',

                                //header: ,
                              ),
                              title: ChartTitle(text: 'discounted_cash_flow'),
                              series: <ChartSeries>[
                                ColumnSeries<Data1, DateTime>(
                                    dataSource: chartData1,
                                    markerSettings:
                                        const MarkerSettings(isVisible: true),
                                    name: 'revenue',
                                    xValueMapper: (Data1 data, _) => data.year,
                                    yValueMapper: (Data1 data, _) =>
                                        data.information,
                                    color:
                                        const Color.fromARGB(255, 48, 220, 174),
                                    spacing: 0.5,
                                    width: 1),
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
