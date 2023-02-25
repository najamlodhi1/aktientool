// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:aktientool/charts/shareHolders/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:flutter/material.dart';

class ShareHolders extends StatefulWidget {
  const ShareHolders({super.key});

  @override
  State<ShareHolders> createState() => ShareHoldersState();
}

class ShareHoldersState extends State<ShareHolders> {
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
                              const Text("Income Statement",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22)),
                              //const Text(
                              //    "All numbers are in thousands, Currency in USD"),
                              const SizedBox(
                                height: 10,
                              ),
                              buildTable(),
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
                  //const Text("All numbers are in thousands, Currency in USD"),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTable(),
                ],
              ),
            ),
          ],
        ),
      );
    }
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
                    ColoredBox(
                      color: x < data.length - 1
                          ? data[data.length - 1 - x].revenue >=
                                  data[data.length - 1 - x - 1].revenue
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      child: Center(
                        child: Text(
                          data[data.length - 1 - x].revenue.toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            DataRow(
              selected: 1 == selectedIndex2,
              onSelectChanged: (bool? value) {
                setState(() {
                  if (selectedIndex2 == 1) {
                    selectedIndex2 = 0;
                    saveList = [];
                  } else {
                    selectedIndex2 = 1;
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
                    ColoredBox(
                      color: x < data.length - 1
                          ? data[data.length - 1 - x].costOfRevenueData >=
                                  data[data.length - 1 - x - 1]
                                      .costOfRevenueData
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      child: Center(
                        child: Text(
                          data[data.length - 1 - x]
                              .costOfRevenueData
                              .toString(),
                        ),
                      ),
                    ),
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
