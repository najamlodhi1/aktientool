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

    final List<Color> color2 = <Color>[];
    color.add(const Color.fromARGB(255, 58, 255, 202));
    color.add(const Color.fromARGB(255, 33, 254, 195));
    color.add(const Color.fromARGB(255, 0, 255, 200));

    final List<Color> color3 = <Color>[];
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

    //fromURL =
    //   "https://financialmodelingprep.com/api/v3/historical-price-full/$stock?from=$modifiedDate&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";

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
                              //title: ChartTitle(text: 'YESSS'),
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                header: "",
                              ),
                              series: <ChartSeries>[
                                ColumnSeries<Data1, DateTime>(
                                  dataSource: chartData1,
                                  xValueMapper: (Data1 data, _) => data.year,
                                  yValueMapper: (Data1 data, _) =>
                                      data.information,
                                  color:
                                      const Color.fromARGB(255, 48, 220, 174),
                                ),
                                ColumnSeries<Data2, DateTime>(
                                  dataSource: chartData2,
                                  xValueMapper: (Data2 data, _) => data.year,
                                  yValueMapper: (Data2 data, _) =>
                                      data.information,
                                  color:
                                      const Color.fromARGB(255, 33, 210, 254),
                                ),
                                ColumnSeries<Data3, DateTime>(
                                  dataSource: chartData3,
                                  xValueMapper: (Data3 data, _) => data.year,
                                  yValueMapper: (Data3 data, _) =>
                                      data.information,
                                  color: const Color.fromARGB(255, 25, 0, 255),
                                ),
                              ],
                              primaryXAxis: DateTimeAxis(),
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
