import 'dart:math';
import 'package:aktientool/charts/DCFLevered/DCFLeveredModel.dart';
import 'package:aktientool/charts/DCFLevered/DCFLeveredService.dart';
import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../settings/app_localizations.dart';

class DCFLeveredScreen extends StatefulWidget {
  const DCFLeveredScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<DCFLeveredScreen> createState() => _DCFLeveredScreenState();
}

class _DCFLeveredScreenState extends State<DCFLeveredScreen> {
  List<DCFLeveredModel> tableData = [];
  late AppLocalizations trans;

  late Future<List<DCFLeveredModel>> getFuture;
  bool iseditable = true;
  bool showData = false;

  @override
  void initState() {
    super.initState();
    getFuture = DCFLeveredService().getData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);

    return FutureBuilder<List<DCFLeveredModel>>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (tableData.isEmpty) {
              tableData = snapshot.data!;
            }
            calculateFreeCashFlow();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                overValue(),
                if (showData) ...[
                  freeCashFlow(),
                  weightedAverage(),
                  terminalValue(),
                  intrinsicValue()
                ],
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget intrinsicValue() {
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
          Text(trans.translate("Intrinsic Value"),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white)),
          const SizedBox(
            height: 10,
          ),
          buildIntrinsicValueTable(),
        ],
      ),
    );
  }

  Widget overValue() {
    double width = MediaQuery.of(context).size.width - 40;
    double overvalue =
        (tableData.last.price - tableData.last.equityValuePerShare);
    double overvaluepercent =
        (overvalue / tableData.last.equityValuePerShare) * 100;

    double undervalue =
        (tableData.last.equityValuePerShare - tableData.last.price);
    double undervaluepercent =
        (undervalue / tableData.last.equityValuePerShare) * 100;

    return Container(
      width: MediaQuery.of(context).size.width,
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
          Text(trans.translate("Discounted Cash Flow (DCF) Analysis Levered"),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white)),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Stack(
              children: [
                Container(color: Colors.red, height: 210, width: width),
                Container(
                    color: Colors.yellow,
                    height: 210,
                    width: tableData.last.price <
                            tableData.last.equityValuePerShare
                        ? ((tableData.last.equityValuePerShare /
                                (((tableData.last.price >
                                            tableData.last.equityValuePerShare)
                                        ? tableData.last.price
                                        : tableData.last.equityValuePerShare) *
                                    1.3)) *
                            width)
                        : ((tableData.last.price /
                                (((tableData.last.price >
                                            tableData.last.equityValuePerShare)
                                        ? tableData.last.price
                                        : tableData.last.equityValuePerShare) *
                                    1.3)) *
                            width)),
                Container(
                    color: Colors.green,
                    height: 210,
                    width: tableData.last.price >
                            tableData.last.equityValuePerShare
                        ? ((tableData.last.equityValuePerShare /
                                (((tableData.last.price >
                                            tableData.last.equityValuePerShare)
                                        ? tableData.last.price
                                        : tableData.last.equityValuePerShare) *
                                    1.3)) *
                            width)
                        : ((tableData.last.price /
                                (((tableData.last.price >
                                            tableData.last.equityValuePerShare)
                                        ? tableData.last.price
                                        : tableData.last.equityValuePerShare) *
                                    1.3)) *
                            width)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      height: 70,
                      color: Colors.black54,
                      width: (tableData.last.equityValuePerShare /
                              (((tableData.last.price >
                                          tableData.last.equityValuePerShare)
                                      ? tableData.last.price
                                      : tableData.last.equityValuePerShare) *
                                  1.3)) *
                          width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(trans.translate('Fair Value'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  const SizedBox(height: 5),
                                  Text(
                                      tableData.last.equityValuePerShare
                                          .toStringAsFixed(2),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white))
                                ],
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 70,
                      width: (tableData.last.price /
                              (((tableData.last.price >
                                          tableData.last.equityValuePerShare)
                                      ? tableData.last.price
                                      : tableData.last.equityValuePerShare) *
                                  1.3)) *
                          width,
                      color: const Color(0xff1C222D),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(trans.translate('Current Price'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  const SizedBox(height: 5),
                                  Text(
                                      ' ${tableData.last.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white))
                                ],
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          if (tableData.last.price > tableData.last.equityValuePerShare)
            Center(
              child: Text(
                  '${overvaluepercent.toStringAsFixed(1)}% ${trans.translate('Overvalued')}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.red)),
            ),
          if (tableData.last.price < tableData.last.equityValuePerShare)
            Center(
              child: Text(
                  '${undervaluepercent.toStringAsFixed(1)}% ${trans.translate('Undervalued')}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.green)),
            ),
          const SizedBox(height: 15),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: showData ? Colors.grey : Colors.black),
              onPressed: () {
                setState(() {
                  showData = !showData;
                  iseditable = true;
                  calculateFreeCashFlow();
                });
              },
              child: Text(
                showData ? 'Hide Data' : 'Show Data',
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  Widget terminalValue() {
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
          Text(trans.translate("Terminal Value"),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white)),
          const SizedBox(
            height: 10,
          ),
          buildTerminalValueTable(),
        ],
      ),
    );
  }

  Widget weightedAverage() {
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
          Text(trans.translate("Weighted Average Cost Of Capital"),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white)),
          const SizedBox(
            height: 10,
          ),
          buildWeightedAverageTable(),
        ],
      ),
    );
  }

  Widget freeCashFlow() {
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
          Text(trans.translate("Free Cash Flow"),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white)),
          const SizedBox(height: 10),
          buildCashFlowTable(),
        ],
      ),
    );
  }

  Widget buildUp() {
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
          Text(trans.translate("Build Up Free Cash Flow"),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white)),
          const SizedBox(
            height: 10,
          ),
          buildbuildUpTable(),
        ],
      ),
    );
  }

  Widget buildCashFlowTable() {
    return SizedBox(
      width: (tableData.length * 220) < MediaQuery.of(context).size.width
          ? MediaQuery.of(context).size.width
          : tableData.length * 220,
      height: 7 * 60,
      child: DataTable2(
        dataRowColor: const MaterialStatePropertyAll(primaryColor),
        headingRowColor: const MaterialStatePropertyAll(primaryColor),
        columnSpacing: 50,
        horizontalMargin: 24,
        minWidth: tableData.length * 220,
        fixedLeftColumns: 1,
        fixedTopRows: 0,
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        rows: buildCashFlowTableRows,
        columns: <DataColumn>[
          DataColumn(
              label: Text(trans.translate("Year"),
                  style: const TextStyle(color: Colors.white))),
          ...List.generate(
            tableData.length,
            (index) => DataColumn(
                label: Text(tableData[index].year.toString(),
                    style: const TextStyle(color: Colors.white))),
          )
        ],
      ),
    );
  }

  Widget buildbuildUpTable() {
    return SizedBox(
      width: (tableData.length * 220) < MediaQuery.of(context).size.width
          ? MediaQuery.of(context).size.width
          : tableData.length * 220,
      height: 7 * 60,
      child: DataTable2(
        dataRowColor: const MaterialStatePropertyAll(primaryColor),
        headingRowColor: const MaterialStatePropertyAll(primaryColor),
        columnSpacing: 50,
        horizontalMargin: 24,
        minWidth: tableData.length * 220,
        fixedLeftColumns: 1,
        fixedTopRows: 0,
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        rows: buildbuildUpTableRows,
        columns: <DataColumn>[
          DataColumn(
              label: Text(trans.translate("Year"),
                  style: const TextStyle(color: Colors.white))),
          ...List.generate(
            tableData.length,
            (index) => DataColumn(
                label: Text(tableData[index].year.toString(),
                    style: const TextStyle(color: Colors.white))),
          )
        ],
      ),
    );
  }

  Widget buildWeightedAverageTable() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        rows: buildWeightedAverageTableRows,
        columns: <DataColumn>[
          DataColumn(
              label: Text(trans.translate("Title"),
                  style: const TextStyle(color: Colors.white))),
          DataColumn(
              label: Text(trans.translate("Price"),
                  style: const TextStyle(color: Colors.white)),
              numeric: true)
        ],
      ),
    );
  }

  Widget buildTerminalValueTable() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        rows: buildTerminalValueTableRows,
        columns: <DataColumn>[
          DataColumn(
              label: Text(trans.translate("Title"),
                  style: const TextStyle(color: Colors.white))),
          DataColumn(
              label: Text(trans.translate("Price"),
                  style: const TextStyle(color: Colors.white)),
              numeric: true)
        ],
      ),
    );
  }

  Widget buildIntrinsicValueTable() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        rows: buildIntrinsicValueTableRows,
        columns: <DataColumn>[
          DataColumn(
              label: Text(trans.translate("Title"),
                  style: const TextStyle(color: Colors.white))),
          DataColumn(
              label: Text(trans.translate("Price"),
                  style: const TextStyle(color: Colors.white)),
              numeric: true)
        ],
      ),
    );
  }

  List<DataRow> get buildIntrinsicValueTableRows {
    return [
      simpleCashFlowRow('Enterprise Value', [tableData.last.enterpriseValue]),
      simpleCashFlowRow('Net Debt', [tableData.last.netDebt]),
      simpleCashFlowRow('Equity Value', [tableData.last.equityValue]),
      simpleCashFlowRow(
          'Shares Outstanding', [tableData.last.dilutedSharesOutstanding]),
    ];
  }

  List<DataRow> get buildTerminalValueTableRows {
    return [
      simpleCashFlowRow('Growth in perpetuity method:', [0]),
      fieldLongTermValueRow(
          'Long-term growth rate', [tableData.last.longTermGrowthRate]),
      simpleCashFlowRow('WACC (%)', [tableData.first.wacc]),
      simpleCashFlowRow(
          'Free cash flow (t + 1)', [tableData.last.freeCashFlowT1]),
      simpleCashFlowRow('Terminal Value', [tableData.last.terminalValue]),
      simpleCashFlowRow('Present Value of Terminal Value',
          [tableData.last.presentTerminalValue])
    ];
  }

  List<DataRow> get buildWeightedAverageTableRows {
    return [
      simpleCashFlowRow('Share price', [tableData.last.price]),
      simpleCashFlowRow('Beta', [tableData.last.beta]),
      simpleCashFlowRow('Diluted Shares Outstanding',
          [tableData.last.dilutedSharesOutstanding]),
      fieldCostofDebtRow('Cost of Debt', [tableData.last.costofDebt]),
      simpleCashFlowRow('Tax Rate', [tableData.last.taxRate]),
      simpleCashFlowRow(
          'After-tax Cost of Debt', [tableData.last.afterTaxCostOfDebt]),
      fieldRiskFreeRateRow('Risk-Free Rate', [tableData.last.riskFreeRate]),
      fieldMarketRiskRow(
          'Market Risk Premium', [tableData.last.marketRiskPremium]),
      simpleCashFlowRow('Cost of Equity', [tableData.last.costOfEquity]),
      simpleCashFlowRow('Total Debt', [tableData.last.totalDebt]),
      simpleCashFlowRow('Total Equity', [tableData.last.totalEquity]),
      simpleCashFlowRow('Total Capital', [tableData.last.totalCapital]),
      simpleCashFlowRow('Debt Weighting', [tableData.last.debtWeighting]),
      simpleCashFlowRow('Equity Weighting', [tableData.last.equityWeighting]),
      fieldWaccRow('Wacc', [tableData.first.wacc]),
    ];
  }

  List<DataRow> get buildCashFlowTableRows {
    return [
      simpleCashFlowRow('Revenue', tableData.map((e) => e.revenue).toList()),
      fieldCashFlowRow(
          'Revenue (%)', tableData.map((e) => e.revenuePercentage).toList(), 0),
      simpleCashFlowRow('Operating Cash Flow',
          tableData.map((e) => e.operatingCashFlow).toList()),
      fieldCashFlowRow('Operating Cash Flow (%)',
          tableData.map((e) => e.operatingCashFlowPercentage).toList(), 1),
      simpleCashFlowRow('Capital Expenditure',
          tableData.map((e) => e.capitalExpenditure).toList()),
      fieldCashFlowRow(
          'Capital Expenditure (%)',
          tableData
              .map((e) => e.year >= DateTime.now().year
                  ? e.capitalExpenditurePercentage.abs()
                  : e.capitalExpenditurePercentage)
              .toList(),
          2),
      simpleCashFlowRow(
          'Free Cash Flow', tableData.map((e) => e.freeCashFlow).toList())
    ];
  }

  List<DataRow> get buildbuildUpTableRows {
    return [
      simpleCashFlowRow('Revenue', tableData.map((e) => e.revenue).toList()),
      simpleCashFlowRow('Operating Cash Flow',
          tableData.map((e) => e.operatingCashFlow).toList()),
      simpleCashFlowRow('Capital Expenditure',
          tableData.map((e) => e.capitalExpenditure).toList()),
      simpleCashFlowRow(
          'Free Cash Flow', tableData.map((e) => e.freeCashFlow).toList()),
      fieldBuildUpRow('WACC', tableData.map((e) => e.wacc).toList()),
      simpleBuildUpRow('PV LFCF', tableData.map((e) => e.pvLfcf).toList()),
      lastBuildUpRow('SUM PV LFCF', tableData.map((e) => e.sumPvLfcf).toList()),
    ];
  }

  DataRow simpleCashFlowRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(trans.translate(title),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        ...List.generate(
          data.length,
          (index) => DataCell(Text(
              (title == 'Share price' ? '' : '') +
                  (data[index] == 0
                      ? ''
                      : ((data[index] > 1000000)
                          ? (data[index] / 1000000).toStringAsFixed(2)
                          : data[index].toStringAsFixed(2))) +
                  (title == 'After-tax Cost of Debt' ? '%' : ''),
              style: const TextStyle(color: Colors.white))),
        )
      ],
    );
  }

  DataRow simpleBuildUpRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(trans.translate(title),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        ...List.generate(
          data.length,
          (index) {
            if (tableData[index].year < DateTime.now().year) {
              return DataCell(Container());
            }
            return DataCell(Text(
                data[index] > 1000000
                    ? (data[index] / 1000000).toStringAsFixed(2)
                    : data[index].toStringAsFixed(2),
                style: const TextStyle(color: Colors.white)));
          },
        )
      ],
    );
  }

  DataRow lastBuildUpRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(trans.translate(title),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        ...List.generate(
          data.length,
          (index) {
            if (data[index] == 0) {
              return DataCell(Container());
            }
            return DataCell(Text(
                data[index] > 1000000
                    ? (data[index] / 1000000).toStringAsFixed(2)
                    : data[index].toStringAsFixed(2),
                style: const TextStyle(color: Colors.white)));
          },
        )
      ],
    );
  }

  DataRow fieldCashFlowRow(String title, List<double> data, int type) {
    return DataRow(
      cells: [
        DataCell(
          Text(trans.translate(title),
              style: const TextStyle(color: Colors.white)),
        ),
        ...List.generate(data.length, (index) {
          return DataCell(Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 100,
              child: TextFormField(
                readOnly: title == 'Capital Expenditure (%)',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                  DecimalTextInputFormatter(
                      decimalRange: 5, beforeDecimalRange: 30)
                ],
                textAlign: TextAlign.center,
                controller: !iseditable
                    ? null
                    : TextEditingController(
                        text: data[index].isNaN
                            ? "NaN"
                            : data[index].toStringAsFixed(3)),
                onChanged: (value) {
                  if (double.tryParse(value) is double) {
                    setState(() {
                      if (type == 0) {
                        tableData[index].revenuePercentage =
                            double.tryParse(value)!;
                      } else if (type == 1) {
                        tableData[index].operatingCashFlowPercentage =
                            double.tryParse(value)!;
                      } else if (type == 2) {
                        tableData[index].capitalExpenditurePercentage =
                            double.tryParse(value)!;
                      }
                    });
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white)),
                    suffixIcon: title == 'Capital Expenditure (%)'
                        ? null
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  iseditable = true;
                                  setState(() {
                                    if (type == 0) {
                                      tableData[index].revenuePercentage++;
                                    } else if (type == 1) {
                                      tableData[index]
                                          .operatingCashFlowPercentage++;
                                    } else if (type == 2) {
                                      tableData[index]
                                          .capitalExpenditurePercentage++;
                                    }
                                  });
                                },
                                child: const SizedBox(
                                  height: 17,
                                  width: 25,
                                  child: Icon(
                                    Icons.arrow_drop_up,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  iseditable = true;
                                  setState(() {
                                    if (type == 0) {
                                      tableData[index].revenuePercentage--;
                                    } else if (type == 1) {
                                      tableData[index]
                                          .operatingCashFlowPercentage--;
                                    } else if (type == 2) {
                                      tableData[index]
                                          .capitalExpenditurePercentage--;
                                    }
                                  });
                                },
                                child: const SizedBox(
                                  height: 17,
                                  width: 25,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )),
              )));
        })
      ],
    );
  }

  DataRow fieldLongTermValueRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(trans.translate(title),
              style: const TextStyle(color: Colors.white)),
        ),
        ...List.generate(data.length, (index) {
          return DataCell(Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 100,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                  DecimalTextInputFormatter(
                      decimalRange: 5, beforeDecimalRange: 30)
                ],
                textAlign: TextAlign.center,
                controller: !iseditable
                    ? null
                    : TextEditingController(
                        text: data[index].toStringAsFixed(3)),
                onChanged: (value) {
                  if (double.tryParse(value) is double) {
                    setState(() {
                      tableData.last.longTermGrowthRate =
                          double.tryParse(value)!;
                    });
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white)),
                    suffixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.last.longTermGrowthRate++;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.last.longTermGrowthRate--;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              )));
        })
      ],
    );
  }

  void changeWacc() {
    double wacc = (((tableData.last.totalEquity / tableData.last.totalCapital) *
                (tableData.last.costOfEquity / 100)) +
            ((tableData.last.totalDebt / tableData.last.totalCapital) *
                (tableData.last.costofDebt / 100) *
                (1 - tableData.last.taxRate / 100))) *
        100;
    for (var i = 0; i < tableData.length; i++) {
      tableData[i].wacc = wacc;
    }
  }

  DataRow fieldCostofDebtRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        ...List.generate(data.length, (index) {
          return DataCell(Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 100,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                  DecimalTextInputFormatter(
                      decimalRange: 5, beforeDecimalRange: 30)
                ],
                textAlign: TextAlign.center,
                controller: !iseditable
                    ? null
                    : TextEditingController(
                        text: data[index].toStringAsFixed(3)),
                onChanged: (value) {
                  if (double.tryParse(value) is double) {
                    setState(() {
                      tableData.last.costofDebt = double.tryParse(value)!;
                      changeWacc();
                    });
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white)),
                    suffixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.last.costofDebt++;
                              changeWacc();
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.last.costofDebt--;
                              changeWacc();
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              )));
        })
      ],
    );
  }

  DataRow fieldRiskFreeRateRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        ...List.generate(data.length, (index) {
          return DataCell(Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 100,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                  DecimalTextInputFormatter(
                      decimalRange: 5, beforeDecimalRange: 30)
                ],
                textAlign: TextAlign.center,
                controller: !iseditable
                    ? null
                    : TextEditingController(
                        text: data[index].toStringAsFixed(3)),
                onChanged: (value) {
                  if (double.tryParse(value) is double) {
                    setState(() {
                      tableData.last.riskFreeRate = double.tryParse(value)!;
                    });
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white)),
                    suffixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.last.riskFreeRate++;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.last.riskFreeRate--;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              )));
        })
      ],
    );
  }

  DataRow fieldMarketRiskRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(trans.translate(title),
              style: const TextStyle(color: Colors.white)),
        ),
        ...List.generate(data.length, (index) {
          return DataCell(Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 100,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                  DecimalTextInputFormatter(
                      decimalRange: 5, beforeDecimalRange: 30)
                ],
                textAlign: TextAlign.center,
                controller: !iseditable
                    ? null
                    : TextEditingController(
                        text: data[index].toStringAsFixed(3)),
                onChanged: (value) {
                  if (double.tryParse(value) is double) {
                    setState(() {
                      tableData.last.marketRiskPremium =
                          double.tryParse(value)!;
                    });
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white)),
                    suffixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.last.marketRiskPremium++;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.last.marketRiskPremium--;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              )));
        })
      ],
    );
  }

  DataRow fieldWaccRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(trans.translate(title),
              style: const TextStyle(color: Colors.white)),
        ),
        ...List.generate(data.length, (index) {
          return DataCell(Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 100,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                  DecimalTextInputFormatter(
                      decimalRange: 5, beforeDecimalRange: 30)
                ],
                textAlign: TextAlign.center,
                controller: !iseditable
                    ? null
                    : TextEditingController(
                        text: data[index].toStringAsFixed(3)),
                onChanged: (value) {
                  if (double.tryParse(value) is double) {
                    setState(() {
                      tableData.first.wacc = double.tryParse(value)!;
                    });
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white)),
                    suffixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.first.wacc++;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData.first.wacc--;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              )));
        })
      ],
    );
  }

  DataRow fieldBuildUpRow(String title, List<double> data) {
    return DataRow(
      cells: [
        DataCell(
          Text(trans.translate(title),
              style: const TextStyle(color: Colors.white)),
        ),
        ...List.generate(data.length, (index) {
          if (tableData[index].year < DateTime.now().year) {
            return DataCell(Container());
          }
          return DataCell(Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 100,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                  DecimalTextInputFormatter(
                      decimalRange: 5, beforeDecimalRange: 30)
                ],
                textAlign: TextAlign.center,
                controller: !iseditable
                    ? null
                    : TextEditingController(
                        text: data[index].toStringAsFixed(3)),
                onChanged: (value) {
                  if (double.tryParse(value) is double) {
                    setState(() {
                      tableData[index].wacc = double.tryParse(value)!;
                    });
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white)),
                    suffixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData[index].wacc++;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            iseditable = true;
                            setState(() {
                              tableData[index].wacc--;
                            });
                          },
                          child: const SizedBox(
                            height: 17,
                            width: 25,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              )));
        })
      ],
    );
  }

  void calculateFreeCashFlow() {
    for (var i = 0; i < tableData.length; i++) {
      if (i != 0) {
        var temp =
            tableData[i - 1].revenue * (tableData[i].revenuePercentage / 100) +
                tableData[i - 1].revenue;
        tableData[i].revenue = temp;
      }
      var temp = tableData[i].revenue *
          (tableData[i].operatingCashFlowPercentage / 100);
      tableData[i].operatingCashFlow =
          tableData[i].year >= DateTime.now().year ? temp.abs() : temp;

      temp = tableData[i].revenue *
          (tableData[i].capitalExpenditurePercentage / 100);
      tableData[i].capitalExpenditure = temp;

      temp = tableData[i].operatingCashFlow + tableData[i].capitalExpenditure;
      tableData[i].freeCashFlow = temp;
    }

    tableData.last.afterTaxCostOfDebt = tableData.last.costofDebt -
        ((tableData.last.costofDebt / 100) * tableData.last.taxRate);

    tableData.last.costOfEquity =
        (((tableData.last.marketRiskPremium / 100) * tableData.last.beta) +
                tableData.last.riskFreeRate / 100) *
            100;

    // tableData.last.totalEquity =
    //     tableData.last.price * tableData.last.dilutedSharesOutstanding;

    // tableData.last.totalCapital =
    //     tableData.last.totalDebt * tableData.last.totalEquity;

    // tableData.last.debtWeighting =
    //     tableData.last.totalDebt / tableData.last.totalCapital * 100;

    // tableData.last.equityWeighting =
    //     tableData.last.totalEquity / tableData.last.totalCapital * 100;

    int pvlfcfIndex = 0;
    double sumpvlfcf = 0;

    for (var i = 0; i < tableData.length; i++) {
      if (tableData[i].year < DateTime.now().year) {
        continue;
      }
      tableData[i].pvLfcf = tableData[i].freeCashFlow /
          pow((1 + (tableData[i].wacc / 100)), ((pvlfcfIndex + 5) - 4));
      sumpvlfcf = sumpvlfcf + tableData[i].pvLfcf;
      pvlfcfIndex++;
    }

    tableData.last.sumPvLfcf = sumpvlfcf;

    tableData.last.freeCashFlowT1 = tableData.last.freeCashFlow *
        (1 + tableData.last.longTermGrowthRate / 100); // correct

    tableData.last.terminalValue = tableData.last.freeCashFlowT1 /
        ((tableData.first.wacc / 100) -
            (tableData.last.longTermGrowthRate / 100));

    tableData.last.presentTerminalValue = tableData.last.terminalValue /
        pow((1 + (tableData.first.wacc / 100)), 5);

    tableData.last.enterpriseValue =
        tableData.last.sumPvLfcf + tableData.last.presentTerminalValue;

    tableData.last.equityValue =
        tableData.last.enterpriseValue - tableData.last.netDebt;

    tableData.last.equityValuePerShare =
        tableData.last.equityValue / tableData.last.dilutedSharesOutstanding;

    Future.delayed(const Duration(seconds: 1))
        .then((value) => iseditable = false);
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter(
      {required this.decimalRange, required this.beforeDecimalRange})
      : assert(decimalRange > 0 || beforeDecimalRange > 0);

  final int decimalRange;
  final int beforeDecimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value;

    value = newValue.text;

    if (value.contains(".")) {
      if (value.split(".")[0].length > beforeDecimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }
    } else {
      if (value.length > beforeDecimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }
    }

    value = newValue.text;

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: min(truncated.length, truncated.length + 1),
        extentOffset: min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}
