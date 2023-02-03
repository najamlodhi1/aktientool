import 'package:aktientool/charts/chart2/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../allCharts.dart';

class CreateChart2 extends StatefulWidget {
  @override
  State<CreateChart2> createState() => CreateChart2State();
}

class CreateChart2State extends State<CreateChart2> {
  bool? isRowSelected;
  int selectedIndex1 = -1;
  int selectedIndex2 = -1;
  var saveList = [0];
  var tableData;
  int datalength = 0;
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";
  late int showingTooltip;

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(toY: y.toDouble()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(tableData);

    if (tableData == null) {
      return Column(
        children: [
          FutureBuilder<dynamic>(
              future: RemoteService().getData(
                  "https://financialmodelingprep.com/api/v3/income-statement/$stock?limit=20&apikey=${Env.fmpKey}"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  tableData = snapshot.data;
                  print("-----");

                  datalength = data.length;
                  print(datalength.toString());

                  print("-----");

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
                                height: 10,
                              ),
                              const Text("Income Statement"),
                              const Text(
                                  "All numbers are in thousands, Currency in USD"),
                              const SizedBox(
                                height: 10,
                              ),
                              buildTable(),
                              const SizedBox(
                                height: 30,
                              ),
                              loadChart(),
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
    } else {
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
                    height: 10,
                  ),
                  const Text("Income Statement"),
                  const Text("All numbers are in thousands, Currency in USD"),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTable(),
                  const SizedBox(
                    height: 30,
                  ),
                  loadChart(),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  loadChart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: AspectRatio(
          aspectRatio: 3,
          child: BarChart(
            BarChartData(
              barGroups: [
                for (int i = 0; i < saveList.length; i++)
                  generateGroupData(i, saveList[i]),
              ],
              barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchCallback: (event, response) {
                    if (response != null &&
                        response.spot != null &&
                        event is FlTapUpEvent) {
                      setState(() {
                        final x = response.spot!.touchedBarGroup.x;
                        final isShowing = showingTooltip == x;
                        if (isShowing) {
                          showingTooltip = -1;
                        } else {
                          showingTooltip = x;
                        }
                      });
                    }
                  },
                  mouseCursorResolver: (event, response) {
                    return response == null || response.spot == null
                        ? MouseCursor.defer
                        : SystemMouseCursors.click;
                  }),
            ),
          ),
        ),
      ),
    );
  }

  buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: const TableBorder(
            top: BorderSide(color: Colors.grey, width: 0.5),
            bottom: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
            right: BorderSide(color: Colors.grey, width: 0.5),
            horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
            verticalInside: BorderSide(color: Colors.grey, width: 0.5),
          ),
          rows: [
            DataRow(
              selected: 1 == selectedIndex1,
              onSelectChanged: (bool? value) {
                setState(() {
                  if (selectedIndex1 == 1) {
                    selectedIndex1 = 0;
                    saveList = [];
                  } else {
                    selectedIndex1 = 1;
                    saveList = [];
                    for (int i = 0; i < data.length; i++) {
                      saveList.add(int.parse(data[i].revenue.toString()));
                    }
                  }
                });
              },
              cells: [
                const DataCell(
                  Text('Revenue'),
                ),
                for (int x = 0; x < data.length; x++) ...[
                  DataCell(
                    Text(data[data.length - 1 - x].revenue.toString()),
                  ),
                ],
              ],
            ),
            DataRow(
              selected: 1 == selectedIndex2,
              onSelectChanged: (bool? value) {
                const AllCharts().checkPopup(context);

                setState(() {
                  if (selectedIndex2 == 1) {
                    selectedIndex2 = 0;
                    saveList = [];
                  } else {
                    selectedIndex2 = 1;
                    print("1");
                    saveList = [];
                    for (int i = 0; i < data.length; i++) {
                      saveList
                          .add(int.parse(data[i].costOfRevenueData.toString()));
                    }
                  }
                });
              },
              cells: [
                const DataCell(
                  Text('Cost of Revenue'),
                ),
                for (int x = 0; x < data.length; x++) ...[
                  DataCell(
                    Text(
                        data[data.length - 1 - x].costOfRevenueData.toString()),
                  ),
                ],
              ],
            ),
          ],
          columns: <DataColumn>[
            const DataColumn(label: Text("Year")),
            for (int x = 0; x < data.length; x++) ...[
              DataColumn(
                  label: Text(data[data.length - 1 - x]
                      .year
                      .toString()
                      .substring(0, 4))),
            ],
          ],
        ),
      ),
    );
  }
}

class Data {
  Data(this.revenue, this.year);
  final double revenue;
  final DateTime year;
}
