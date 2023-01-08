import 'package:aktientool/charts/chart2/data.dart';
import 'package:aktientool/charts/chart2/linechart.dart';
import 'package:flutter/material.dart';

class CreateChart extends StatefulWidget {
  const CreateChart({Key? key}) : super(key: key);

  @override
  State<CreateChart> createState() => _CreateChartState();
}

class _CreateChartState extends State<CreateChart> {
  var data = chartData4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
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
                  MyLineChart(data),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              data = chartData1;
                            });
                          },
                          child: const Text("1 years")),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              data = chartData2;
                            });
                          },
                          child: const Text("3 years")),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              data = chartData3;
                            });
                          },
                          child: const Text("5 years")),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              data = chartData4;
                            });
                          },
                          child: const Text("Max"))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
