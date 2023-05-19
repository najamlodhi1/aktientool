import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart2/createchart.dart';
import 'BalanceHistoryWidget.dart';
import 'BalanceReportModel.dart';
import 'BarChartBalanceScreen.dart';
import 'DonutChartBalanceScreen.dart';
import 'data.dart';

class CreateChart3 extends StatefulWidget {
  const CreateChart3(this.data, {super.key});
  final dynamic data;
  @override
  State<CreateChart3> createState() => CreateChart3State();
}

class CreateChart3State extends State<CreateChart3> {
  List<BalanceReportModel> tableData = [];
  late Future<List<BalanceReportModel>> getFuture;
  late AppLocalizations trans;

  @override
  void initState() {
    getFuture = BalanceService().getData(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return FutureBuilder<List<BalanceReportModel>>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data!.isNotEmpty) {
            tableData = snapshot.data!;

            Map<String, bool> selectedcolumns = Map.fromEntries(BalanceService
                .isSelected.value.entries
                .where((entry) => entry.value == true));

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.teal,
                      style: BorderStyle.none,
                      width: 2,
                    ),
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: DonutChartBalanceScreen(tableData),
                ),
                Container(
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
                      Text(trans.translate("Balance Sheet"),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTable(),
                    ],
                  ),
                ),
                Container(
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
                    child: BarChartBalanceScreen(
                        widget.data)), // Bar Chart income,
                if (selectedcolumns.isNotEmpty)
                  GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: MediaQuery.of(context).size.width > 1500
                          ? 3
                          : MediaQuery.of(context).size.width > 1000
                              ? 2
                              : 1,
                      childAspectRatio: 16 / 9,
                      children: List.generate(
                          selectedcolumns.length,
                          (index) => BalanceHistoryWidget(
                              data: tableData,
                              selectedtitle:
                                  selectedcolumns.keys.toList()[index],
                              selectedindex: index))),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  buildTable() {
    return SizedBox(
      width: (tableData.length * 170) < MediaQuery.of(context).size.width
          ? MediaQuery.of(context).size.width
          : tableData.length * 170,
      height: tableData[0].reports.length * 50,
      child: DataTable2(
        columnSpacing: 50,
        horizontalMargin: 24,
        minWidth: tableData.length * 170,
        fixedLeftColumns: 2,
        fixedTopRows: 0,
        dataRowColor: MaterialStatePropertyAll(primaryColor),
        headingRowColor: MaterialStatePropertyAll(primaryColor),
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
                  fixedWidth: 220,
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
