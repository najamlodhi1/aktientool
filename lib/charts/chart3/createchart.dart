import 'package:aktientool/charts/chart3/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';

class CreateChart3 extends StatefulWidget {
  @override
  State<CreateChart3> createState() => CreateChart3State();
}

class CreateChart3State extends State<CreateChart3> {
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
                  "https://financialmodelingprep.com/api/v3/balance-sheet-statement/$stock?limit=20&apikey=${Env.fmpKey}"),
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
                              const Text("Balance Sheet"),
                              const Text(
                                  "All numbers are in thousands, Currency in USD"),
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
                  const Text("Balance Sheet"),
                  const Text("All numbers are in thousands, Currency in USD"),
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
                      saveList.add(int.parse(data[i].goodwill.toString()));
                    }
                  }
                });
              },
              cells: [
                const DataCell(
                  Text('goodwill'),
                ),
                for (int x = 0; x < data.length; x++) ...[
                  DataCell(
                    ColoredBox(
                      color: x < data.length - 1
                          ? data[data.length - 1 - x].goodwill >=
                                  data[data.length - 1 - x - 1].goodwill
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      child: Center(
                        child: Text(
                          data[data.length - 1 - x].goodwill.toString(),
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
                      saveList.add(int.parse(
                          data[i].cashAndShortTermInvestments.toString()));
                    }
                  }
                });
              },
              cells: [
                const DataCell(
                  Text('cashAndShortTermInvestments'),
                ),
                for (int x = 0; x < data.length; x++) ...[
                  DataCell(
                    ColoredBox(
                      color: x < data.length - 1
                          ? data[data.length - 1 - x]
                                      .cashAndShortTermInvestments >=
                                  data[data.length - 1 - x - 1]
                                      .cashAndShortTermInvestments
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      child: Center(
                        child: Text(
                          data[data.length - 1 - x]
                              .cashAndShortTermInvestments
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
  Data(this.goodwill, this.year);
  final double goodwill;
  final DateTime year;
}
