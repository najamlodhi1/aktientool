// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'BalanceReportModel.dart';
import 'BarChartBalanceScreen.dart';
import 'data.dart';

class CreateChart3 extends StatefulWidget {
  const CreateChart3({super.key});

  @override
  State<CreateChart3> createState() => CreateChart3State();
}

class CreateChart3State extends State<CreateChart3> {
  List<BalanceReportModel> tableData = [];

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  Widget build(BuildContext context) {
    if (tableData.isEmpty) {
      return Column(
        children: [
          FutureBuilder<List<BalanceReportModel>>(
              future: BalanceService().getData(
                  "https://financialmodelingprep.com/api/v3/balance-sheet-statement/$stock?limit=20&apikey=${Env.fmpKey}"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data!.isNotEmpty) {
                  tableData = snapshot.data!;
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.teal,
                        style: BorderStyle.none,
                        width: 2,
                      ),
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Balance Sheet",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.white)),
                        //const Text(
                        //    "All numbers are in thousands, Currency in USD"),
                        const SizedBox(
                          height: 10,
                        ),
                        buildTable(),
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
      return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.teal,
            style: BorderStyle.none,
            width: 2,
          ),
          color: primaryColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text("Balance Sheet",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white)),
            //const Text("All numbers are in thousands, Currency in USD"),
            const SizedBox(
              height: 10,
            ),
            buildTable(),
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
        dataRowColor: const MaterialStatePropertyAll(primaryColor),
        headingRowColor: const MaterialStatePropertyAll(primaryColor),
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
                  label: Text("Year", style: TextStyle(color: Colors.white)),
                )
              : const DataColumn2(
                  fixedWidth: 220,
                  label: Text("Year", style: TextStyle(color: Colors.white)),
                ),
          for (int x = 0; x < tableData.length; x++) ...[
            DataColumn2(
                label: Text(
                    tableData[tableData.length - 1 - x].date.year.toString(),
                    style: const TextStyle(color: Colors.white))),
          ],
        ],
      ),
    );
  }

  List<DataRow> get buildTableRows {
    return List.generate(
        tableData[0].reports.length,
        (index) => DataRow(
              selected: BalanceService
                  .isSelected.value[tableData[0].reports[index].title]!,
              onSelectChanged: (bool? value) {
                BalanceService.isSelected
                    .value[tableData[0].reports[index].title] = value!;
                BalanceService.isSelected.notifyListeners();
                setState(() {});
              },
              cells: [
                DataCell(
                  Text(tableData[0].reports[index].title,
                      style: const TextStyle(color: Colors.white)),
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
                              numberToKFormat(
                                  tableData[tableData.length - 1 - x]
                                      .reports[index]
                                      .value),
                              style: const TextStyle(color: Colors.white))),
                    ),
                  ),
                ],
              ],
            ));
  }
}
