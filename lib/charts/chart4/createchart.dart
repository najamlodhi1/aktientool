import 'package:aktientool/charts/chart4/CashFlowReportModel.dart';
import 'package:aktientool/charts/chart4/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateChart4 extends StatefulWidget {
  const CreateChart4({super.key});

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
                              const Text("Cashflow Statement",
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
                  const Text("Cashflow Statement",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
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
    return SizedBox(
      width: tableData.length * 170,
      height: tableData[0].reports.length * 50,
      child: DataTable2(
        columnSpacing: 50,
        horizontalMargin: 24,
        minWidth: tableData.length * 170,
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
                  fixedWidth: 220,
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
              selected: CashFlowService
                  .isSelected.value[tableData[0].reports[index].title]!,
              onSelectChanged: (bool? value) {
                CashFlowService.isSelected
                    .value[tableData[0].reports[index].title] = value!;
                CashFlowService.isSelected.notifyListeners();
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
