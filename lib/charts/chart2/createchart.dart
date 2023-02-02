import 'package:aktientool/charts/chart2/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CreateChart2 extends StatefulWidget {
  @override
  State<CreateChart2> createState() => CreateChart2State();
}

class CreateChart2State extends State<CreateChart2> {
  final DataGridController _dataGridController = DataGridController();

  late List<Datas> _employees;
  late DataSource _employeeDataSource;

  var selectList = [];

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  void initState() {
    super.initState();
    _employees = getData();
    _employeeDataSource = DataSource(_employees);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<dynamic>(
            future: RemoteService().getData(
                "https://financialmodelingprep.com/api/v3/income-statement/$stock?limit=20&apikey=${Env.fmpKey}"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
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
                            SfDataGrid(
                              onCellTap: ((details) {
                                var selectedIndex =
                                    _dataGridController.selectedIndex;
                                //print(selectedIndex);

                                if (selectList.contains(details.rowColumnIndex.rowIndex)) {
                                  selectList.remove(details.rowColumnIndex.rowIndex);
                                } else {
                                  selectList.add(details.rowColumnIndex.rowIndex);
                                }
                                print(selectList.toString());
                              }),
                              footer: InkWell(
                                onTap: () {
                                  print(selectList.toString());

                                  // iterriere durch Liste und hole alle felder

/*
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0))),
                                          content: SizedBox(
                                            height: 300,
                                            width: 300,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(children: [
                                                    Text(selectList.toString()),

                                                  ]),
                                                  SizedBox(
                                                    width: 300,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("OK")),
                                                  )
                                                ]),
                                          )));*/
                                },
                                child: Container(
                                  color: Colors.grey[400],
                                  child: const Center(
                                    child: Text(
                                      'Show Chart',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              frozenColumnsCount: 1,
                              controller: _dataGridController,
                              showCheckboxColumn: false,
                              checkboxShape: const CircleBorder(),
                              allowSorting: false,
                              allowEditing: false,
                              allowColumnsResizing: false,
                              gridLinesVisibility: GridLinesVisibility.none,
                              headerGridLinesVisibility: GridLinesVisibility.none,
                              highlightRowOnHover: false,
                              selectionMode: SelectionMode.singleDeselect,
                              source: _employeeDataSource,
                              columns: [
                                GridTextColumn(
                                  columnName: 'Revenue',
                                  columnWidthMode: ColumnWidthMode.fill,
                                   width: 400,
                                   minimumWidth: 400,
                                  // maximumWidth: 200,
                                  allowEditing: false,
                                  label: Container(
                                    width: 200,
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    alignment: Alignment.centerLeft,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey,
                                          width: 0.6,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Year',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                GridTextColumn(
                                  columnName: 'A',
                                  minimumWidth: 150,
                                  label: labelTextWidget(boxColor: Colors.grey.withOpacity(0.1), text: '2022'),
                                ),
                                GridTextColumn(
                                  columnName: 'B',
                                  minimumWidth: 150,
                                  label: labelTextWidget(boxColor: Colors.white, text: '2021'),
                                ),
                                GridTextColumn(
                                  columnName: 'C',
                                  minimumWidth: 150,
                                  label: labelTextWidget(boxColor: Colors.grey.withOpacity(0.1), text: '2020'),
                                ),
                                GridTextColumn(
                                  columnName: 'D',
                                  minimumWidth: 150,
                                  label: labelTextWidget(boxColor: Colors.white, text: '2019'),
                                ),
                                GridTextColumn(
                                  columnName: 'E',
                                  minimumWidth: 150,
                                  label: labelTextWidget(boxColor: Colors.grey.withOpacity(0.1), text: '2018'),
                                ),
                                GridTextColumn(
                                  columnName: 'F',
                                  minimumWidth: 150,
                                  label: labelTextWidget(boxColor: Colors.white, text: '2017'),
                                ),
                                GridTextColumn(
                                  columnName: 'G',
                                  minimumWidth: 150,
                                  label: labelTextWidget(boxColor: Colors.grey.withOpacity(0.1), text: '2016'),
                                ),
                              ],
                            ),
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
  }

  /// label text widget
  Widget labelTextWidget({required Color boxColor, required String text, bool isCenter = true}) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: isCenter == true ?  Alignment.center : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: boxColor,
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.6,
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w900,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}



List<Datas> getData() {
  return [
    Datas('Revenue', "2,765,766,900,", '2,432,766,900', '2,123,766,900', '2,345,766,900', '2,543,766,900', '2,123,564,900', '2,223,567,900'),
  ];
}

class DataSource extends DataGridSource {
  DataSource(List<Datas> employees) {
    dataGridRows = employees
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'head', value: dataGridRow.head),
              DataGridCell<String>(columnName: 'A', value: dataGridRow.a),
              DataGridCell<String>(columnName: 'B', value: dataGridRow.b),
              DataGridCell<String>(columnName: 'C', value: dataGridRow.c),
              DataGridCell<String>(columnName: 'D', value: dataGridRow.d),
              DataGridCell<String>(columnName: 'E', value: dataGridRow.e),
              DataGridCell<String>(columnName: 'F', value: dataGridRow.f),
              DataGridCell<String>(columnName: 'G', value: dataGridRow.g),
            ],
          ),
        ).toList();
  }

  late List<DataGridRow> dataGridRows;
  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: (dataGridCell.columnName == 'head' ||
                dataGridCell.columnName == 'salary')
            ? Alignment.centerLeft
            : Alignment.center,
        color: Colors.white,
        child: Text(
          dataGridCell.value.toString(),
          overflow: TextOverflow.ellipsis,
          style: dataGridCell.columnName == 'head' ||
              dataGridCell.columnName == 'salary' ? const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ) : const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }).toList());
  }
}

class Datas {
  Datas(this.head, this.a, this.b, this.c, this.d, this.e, this.f, this.g);
  final String head;
  final String a;
  final String b;
  final String c;
  final String d;
  final String e;
  final String f;
  final String g;
}
