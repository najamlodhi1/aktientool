import 'package:aktientool/charts/chart2/data.dart';
import 'package:aktientool/charts/chart2/linechart.dart';
import 'package:flutter/material.dart';

class CreateChart extends StatefulWidget {
  const CreateChart({Key? key}) : super(key: key);

  @override
  State<CreateChart> createState() => _CreateChartState();
}

class _CreateChartState extends State<CreateChart> {
  // Für 4 h
  //https://financialmodelingprep.com/api/v3/historical-chart/4hour/AAPL?apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
  var fromURL =
      "https://financialmodelingprep.com/api/v3/historical-price-full/AAPL?from=2000-12-21&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";

  @override
  initState() {
    super.initState();
  }

  getDatas(String url) async {
    var posts = await RemoteService().getData(url);

    //print("----");
    //print(posts.symbol.length.toString());
    //print(posts.historical[0].open);

    data1 = [];
    for (int i = 0; i < lengthJson; i++) {
      data1.add(posts.historical[i].open.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> data;
    return FutureBuilder(
        future: getDatas(fromURL),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.teal,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Line Chart',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyLineChart(chartData1),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    fromURL =
                                        "https://financialmodelingprep.com/api/v3/historical-price-full/AAPL?from=2022-12-21&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
                                  });
                                },
                                child: const Text("1 years")),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    fromURL =
                                        "https://financialmodelingprep.com/api/v3/historical-price-full/GOOG?from=2020-12-21&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
                                  });
                                },
                                child: const Text("3 years")),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    fromURL =
                                        "https://financialmodelingprep.com/api/v3/historical-price-full/AAPL?from=2018-12-21&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
                                  });
                                },
                                child: const Text("5 years")),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    fromURL =
                                        "https://financialmodelingprep.com/api/v3/historical-price-full/AAPL?from=2000-12-21&apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
                                  });
                                },
                                child: const Text("Max")),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
