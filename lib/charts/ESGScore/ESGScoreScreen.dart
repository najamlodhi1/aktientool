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
                  const Text(
                      "ESG ratings measure a company’s commitment to environmental, social, and governance standards. These ESG ratings focus on a company’s exposure to ESG specific risks. These types of risks are not usually identified during traditional investment analysis but they can have a significant financial impact on companies that choose to ignore ESG."),
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
    Color egsColor = Colors.white;
    String egsText = "";
    var esgscore = ((tableData.first.environmentalScore +
            tableData.first.socialScore +
            tableData.first.governanceScore) /
        3);

    if (esgscore >= 71.0) {
      egsColor = Colors.green;
      egsText =
          "An ESG leader is a company leading its industry in managing the most significant ESG risks and opportunities.";
    } else if (esgscore >= 28.0 && esgscore < 71.0) {
      egsColor = Colors.yellow;
      egsText =
          "An average ESG score means a company has a mixed or unexceptional track record of managing the most significant ESG risks and opportunities relative to industry peers.";
    } else {
      egsText =
          "A laggard is a company lagging its industry based on its high exposure and failure to manage significant ESG risks.";

      egsColor = Colors.red;
    }

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Wrap(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            //color: Colors.red,
            decoration: const BoxDecoration(color: Colors.black),
            child: Expanded(
              child: Row(
                children: [
                  Container(
                    child: Text(
                      ' ${((tableData.first.environmentalScore + tableData.first.socialScore + tableData.first.governanceScore) / 3).toStringAsFixed(2)}\n / 100   ',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: egsColor),
                    ),
                  ),
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          egsText,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 76, 175, 139)),
            child: Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      'Environment ${tableData.first.environmentalScore.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  //const Spacer(),
                  Wrap(
                    children: const [
                      Text(
                        textAlign: TextAlign.left,
                        'Climate Change',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Text(
                    textAlign: TextAlign.left,
                    'Natural Capital',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    textAlign: TextAlign.left,
                    'Pollution & Waste',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'Env. Opportunities',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget secondwidget() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Wrap(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 252, 126, 117)),
            child: Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      'Social ${tableData.first.socialScore.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  //const Spacer(),
                  Wrap(
                    children: const [
                      Text(
                        textAlign: TextAlign.left,
                        'Human Rights',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Text(
                    textAlign: TextAlign.left,
                    'Product Liability',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    textAlign: TextAlign.left,
                    'Stakeholder Opposition',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'Social Opportunities',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 70, 193, 250)),
            child: Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      'Governance ${tableData.first.governanceScore.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  //const Spacer(),
                  Wrap(
                    children: const [
                      Text(
                        textAlign: TextAlign.left,
                        'Corporate Governance',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Text(
                    textAlign: TextAlign.left,
                    'Corporate Behavior',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    textAlign: TextAlign.left,
                    '',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildTable() {
    return SizedBox(
      width: (tableData.length * 220) < MediaQuery.of(context).size.width
          ? MediaQuery.of(context).size.width
          : 9 * 220,
      height: 5 * 52,
      child: DataTable2(
        columnSpacing: 20,
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
                  fixedWidth: 150,
                  label: Text(
                      textAlign: TextAlign.left,
                      trans.translate("Date"),
                      style: const TextStyle(color: Colors.white)),
                )
              : DataColumn2(
                  fixedWidth: 150,
                  label: Text(
                      textAlign: TextAlign.left,
                      trans.translate("Date"),
                      style: const TextStyle(color: Colors.white)),
                ),
          for (int x = 0; x < tableData.length; x++) ...[
            DataColumn2(
              label: Text(tableData[x].date,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
    );
  }

  DataCell customcolumns(String title) {
    return DataCell(
      Text(trans.translate(title),
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.white)),
    );
  }

  List<DataRow> get buildTableRows {
    return [
      DataRow(
        cells: [
          customcolumns("ESG Score"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Text(tableData[x].ESGScore.toStringAsFixed(2),
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Environmental Score"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Text(
                  textAlign: TextAlign.left,
                  tableData[x].environmentalScore.toStringAsFixed(2),
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Social Score"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Text(
                  textAlign: TextAlign.left,
                  tableData[x].socialScore.toStringAsFixed(2),
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
      DataRow(
        cells: [
          customcolumns("Governance Score"),
          for (int x = 0; x < tableData.length; x++) ...[
            DataCell(
              Text(
                  textAlign: TextAlign.left,
                  tableData[x].governanceScore.toStringAsFixed(2),
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
    ];
  }
}
