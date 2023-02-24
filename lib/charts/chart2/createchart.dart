import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:aktientool/charts/chart2/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'IncomeReportModel.dart';

class CreateChart2 extends StatefulWidget {
  const CreateChart2({super.key});

  @override
  State<CreateChart2> createState() => CreateChart2State();
}

class CreateChart2State extends State<CreateChart2> {
  List<IncomeReportModel> tableData = [];
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  Widget build(BuildContext context) {
    if (tableData.isEmpty) {
      return Column(
        children: [
          FutureBuilder<List<IncomeReportModel>>(
              future: IncomeService().getData(
                  "https://financialmodelingprep.com/api/v3/income-statement/$stock?limit=20&apikey=${Env.fmpKey}"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data!.isNotEmpty) {
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
                              const Text("Income Statement",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22)),
                              // const Text(
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
                  //return const Center(child: CircularProgressIndicator());
                  return const SizedBox();
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
                  const Text("Income Statement",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
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
    return SizedBox(
      width: tableData.length * 220,
      height: tableData[0].reports.length * 52,
      child: DataTable2(
        columnSpacing: 50,
        horizontalMargin: 24,
        minWidth: tableData.length * 220,
        fixedLeftColumns: 2,
        fixedTopRows: 0,
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        rows: buildTableRows,
        columns: <DataColumn2>[
          MediaQuery.of(context).size.width < 1000
              ? const DataColumn2(
                  fixedWidth: 100,
                  label: Text("Year"),
                )
              : const DataColumn2(
                  fixedWidth: 330,
                  label: Text("Year"),
                ),
          for (int x = 0; x < tableData.length; x++) ...[
            DataColumn2(
                label: Text(
                    tableData[tableData.length - 1 - x].date.year.toString())),
          ],
        ],
      ),
    );
  }

  List<DataRow> get buildTableRows {
    return List.generate(
        tableData[0].reports.length,
        (index) => DataRow(
              selected: IncomeService
                  .isSelected.value[tableData[0].reports[index].title]!,
              onSelectChanged: (bool? value) {
                IncomeService.isSelected
                    .value[tableData[0].reports[index].title] = value!;

                IncomeService.isSelected.notifyListeners();
                setState(() {});
              },
              cells: [
                DataCell(
                  Text(tableData[0].reports[index].title),
                ),
                for (int x = 0; x < tableData.length; x++) ...[
                  DataCell(
                    ColoredBox(
                      color: x < tableData.length - 1
                          ? tableData[tableData.length - 1 - x]
                                      .reports[index]
                                      .value >=
                                  tableData[tableData.length - 1 - x - 1]
                                      .reports[index]
                                      .value
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      child: Center(
                        child: Text(
                          tableData[tableData.length - 1 - x]
                              .reports[index]
                              .value
                              .toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ));
  }
}
