import 'package:aktientool/charts/chart4/CashFlowReportModel.dart';
import 'package:aktientool/charts/chart4/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateChart4 extends StatefulWidget {
  @override
  State<CreateChart4> createState() => CreateChart4State();
}

class CreateChart4State extends State<CreateChart4> {
  List<CashFlowReportModel> tableData = [];
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  Widget build(BuildContext context) {
    if (tableData.isEmpty) {
      return Column(
        children: [
          FutureBuilder<List<CashFlowReportModel>>(
              future: CashFlowService().getData(
                  "https://financialmodelingprep.com/api/v3/cash-flow-statement/$stock?limit=20&apikey=${Env.fmpKey}"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  tableData = snapshot.data!;
                  if (kDebugMode) {
                    print("-----");
                    print(tableData.length.toString());
                    print("-----");
                  }
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
                              const Text("cash-flow-statement"),
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
                  const Text("cash-flow-statement"),
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
          rows: buildTableRows,
          columns: <DataColumn>[
            const DataColumn(label: Text("Year")),
            for (int x = 0; x < tableData.length; x++) ...[
              DataColumn(
                  label: Text(tableData[tableData.length - 1 - x]
                      .date
                      .year
                      .toString())),
            ],
          ],
        ),
      ),
    );
  }

  List<DataRow> get buildTableRows {
    return tableData
        .map((data) => DataRow(
              selected: CashFlowService.isSelected
                  .value[data.reports[tableData.indexOf(data)].title]!,
              onSelectChanged: (bool? value) {
                var temp = CashFlowService.isSelected.value;
                temp[data.reports[tableData.indexOf(data)].title] = value!;
                CashFlowService.isSelected.value = temp;
                CashFlowService.isSelected.notifyListeners();
                setState(() {});
              },
              cells: [
                DataCell(
                  Text(data.reports[tableData.indexOf(data)].title),
                ),
                for (int x = 0; x < tableData.length; x++) ...[
                  DataCell(
                    ColoredBox(
                      color: x < tableData.length - 1
                          ? tableData[tableData.length - 1 - x]
                                      .reports[tableData.indexOf(data)]
                                      .value >=
                                  tableData[tableData.length - 1 - x - 1]
                                      .reports[tableData.indexOf(data)]
                                      .value
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      child: Center(
                        child: Text(
                          tableData[tableData.length - 1 - x]
                              .reports[tableData.indexOf(data)]
                              .value
                              .toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ))
        .toList();
  }
}
