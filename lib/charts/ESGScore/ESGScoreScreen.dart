// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../models/ESGScoreModel.dart';
import '../../settings/app_localizations.dart';
import 'ESGScoreService.dart';

class ESGScoreScreen extends StatefulWidget {
  const ESGScoreScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<ESGScoreScreen> createState() => ESGScoreScreenState();
}

class ESGScoreScreenState extends State<ESGScoreScreen> {
  late AppLocalizations trans;

  late Future<List<ESGScoreModel>> getDataFuture;
  List<ESGScoreModel> tableData = [];

  @override
  void initState() {
    getDataFuture = ESGScoreService().getData(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return FutureBuilder<List<ESGScoreModel>>(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const Text("ESG Score",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white)),
                  const SizedBox(height: 10),
                  MediaQuery.of(context).size.width > 700
                      ? Row(
                          children: [
                            Expanded(child: firstwidget()),
                            const SizedBox(width: 30),
                            Expanded(child: secondwidget()),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [firstwidget(), secondwidget()],
                        ),
                  const SizedBox(height: 10),
                  buildTable()
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget firstwidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${((tableData.first.environmentalScore + tableData.first.socialScore + tableData.first.governanceScore) / 3).toStringAsFixed(2)}\n/ 100',
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          'Environment ${tableData.first.environmentalScore.toStringAsFixed(2)}',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }

  Widget secondwidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Social ${tableData.first.socialScore.toStringAsFixed(2)}',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          'Governance ${tableData.first.governanceScore.toStringAsFixed(2)}',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }

  buildTable() {
    return SizedBox(
      width: (tableData.length * 220) < MediaQuery.of(context).size.width
          ? MediaQuery.of(context).size.width
          : 9 * 220,
      height: 9 * 52,
      child: DataTable2(
        columnSpacing: 50,
        horizontalMargin: 24,
        minWidth: tableData.length * 220,
        fixedLeftColumns: 1,
        dataRowColor: const MaterialStatePropertyAll(primaryColor),
        headingRowColor: const MaterialStatePropertyAll(primaryColor),
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
                  label: Text(trans.translate("Date"),
                      style: const TextStyle(color: Colors.white)),
                )
              : DataColumn2(
                  fixedWidth: 330,
                  label: Text(trans.translate("Date"),
                      style: const TextStyle(color: Colors.white)),
                ),
          for (int x = 0; x < tableData.length; x++) ...[
            DataColumn2(
                label: Center(
              child: Text(tableData[x].date,
                  style: const TextStyle(color: Colors.white)),
            )),
          ],
        ],
      ),
    );
  }

  DataCell customcolumns(String title) {
    return DataCell(
      Center(
          child: Text(trans.translate(title),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white))),
    );
  }

  List<DataRow> get buildTableRows {
    return [
      DataRow(
        cells: [
          customcolumns("CIK"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Center(
                  child: Text(tableData[x].cik,
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Company Name"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Center(
                  child: Text(tableData[x].companyName,
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Form Type"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Center(
                  child: Text(tableData[x].formType,
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Accepted Date"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Center(
                  child: Text(tableData[x].acceptedDate,
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Environmental Score"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Center(
                  child: Text(
                      tableData[x].environmentalScore.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Social Score"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Center(
                  child: Text(tableData[x].socialScore.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Governance Score"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Center(
                  child: Text(tableData[x].governanceScore.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("ESG Score"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Center(
                  child: Text(tableData[x].ESGScore.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ],
      )
    ];
  }
}
