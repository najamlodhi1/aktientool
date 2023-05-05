// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/charts/chart2/data.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart3/BarChartBalanceScreen.dart';
import 'IncomeReportModel.dart';

class CreateChart2 extends StatefulWidget {
  const CreateChart2(
    this.data, {
    super.key,
  });
  final dynamic data;
  @override
  State<CreateChart2> createState() => CreateChart2State();
}

class CreateChart2State extends State<CreateChart2> {
  late AppLocalizations trans;

  late Future<List<IncomeReportModel>> getDataFuture;
  List<IncomeReportModel> tableData = [];

  @override
  void initState() {
    getDataFuture = IncomeService().getData(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    if (tableData.isEmpty) {
      return FutureBuilder<List<IncomeReportModel>>(
          future: getDataFuture,
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
                    Text(trans.translate("Income Statement"),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.white)),
                    // const Text(
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
          });
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
            Text(trans.translate("Income Statement"),
                style: const TextStyle(
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
      width: (tableData.length * 220) < MediaQuery.of(context).size.width
          ? MediaQuery.of(context).size.width
          : tableData.length * 220,
      height: tableData[0].reports.length * 52,
      child: DataTable2(
        columnSpacing: 50,
        horizontalMargin: 24,
        minWidth: tableData.length * 220,
        fixedLeftColumns: 2,
        dataRowColor: MaterialStatePropertyAll(primaryColor),
        headingRowColor: MaterialStatePropertyAll(primaryColor),
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
              ? DataColumn2(
                  fixedWidth: 100,
                  label: Text(trans.translate("Year"),
                      style: const TextStyle(color: Colors.white)),
                )
              : DataColumn2(
                  fixedWidth: 330,
                  label: Text(trans.translate("Year"),
                      style: const TextStyle(color: Colors.white)),
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
              // selected: IncomeService
              //     .isSelected.value[tableData[0].reports[index].title]!,
              // onSelectChanged: (bool? value) {
              //   IncomeService.isSelected
              //       .value[tableData[0].reports[index].title] = value!;

              //   IncomeService.isSelected.notifyListeners();
              //   setState(() {});
              // },
              cells: [
                DataCell(
                  Text(trans.translate(tableData[0].reports[index].title),
                      style: const TextStyle(color: Colors.white)),
                ),
                for (int x = 0; x < tableData.length; x++) ...[
                  DataCell(
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            numberToKFormat(tableData[tableData.length - 1 - x]
                                .reports[index]
                                .value),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (x < tableData.length - 1
                                      ? tableData[tableData.length - 1 - x]
                                                  .reports[index]
                                                  .value >=
                                              tableData[tableData.length -
                                                      1 -
                                                      x -
                                                      1]
                                                  .reports[index]
                                                  .value
                                          ? Colors.green
                                          : Colors.red
                                      : Colors.grey)
                                  .withOpacity(0.3)),
                          child: Center(
                            child: Text(
                              '${x < (tableData.length - 1) ? calculatepercentage(tableData[tableData.length - 1 - x].reports[index].value, tableData[tableData.length - 1 - x - 1].reports[index].value).toStringAsFixed(2) : 'N/A'}%',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                ],
              ],
            ));
  }
}

double calculatepercentage(double current, double previous) {
  return ((current * 100) / previous) - 100;
}
