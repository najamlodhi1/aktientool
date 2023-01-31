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

                                if (selectList.contains(
                                    details.rowColumnIndex.rowIndex)) {
                                  selectList
                                      .remove(details.rowColumnIndex.rowIndex);
                                } else {
                                  selectList
                                      .add(details.rowColumnIndex.rowIndex);
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
                                          fontWeight: FontWeight.bold),
                                    ))),
                              ),
                              frozenColumnsCount: 1,
                              controller: _dataGridController,
                              showCheckboxColumn: true,
                              checkboxShape: const CircleBorder(),
                              allowSorting: false,
                              selectionMode: SelectionMode.multiple,
                              source: _employeeDataSource,
                              columns: [
                                GridTextColumn(
                                    columnName: 'id',
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'ID',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                                GridTextColumn(
                                    columnName: 'A',
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'A',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                GridTextColumn(
                                    columnName: 'B',
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'B',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                GridTextColumn(
                                    columnName: 'C',
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'C',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                GridTextColumn(
                                    columnName: 'D',
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'D',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                                GridTextColumn(
                                    columnName: 'E',
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'E',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                GridTextColumn(
                                    columnName: 'F',
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'F',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                GridTextColumn(
                                    columnName: 'G',
                                    label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'G',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
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
}

List<Datas> getData() {
  return [
    Datas(1, "A", 'B', 'C', 'D', 'E', 'F', 'G'),
    //Datas(2, "A", 'B', 'C', 'D', 'E', 'F', 'G'),
  ];
}

class DataSource extends DataGridSource {
  DataSource(List<Datas> employees) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'A', value: dataGridRow.a),
              DataGridCell<String>(columnName: 'B', value: dataGridRow.b),
              DataGridCell<String>(columnName: 'C', value: dataGridRow.c),
              DataGridCell<String>(columnName: 'D', value: dataGridRow.d),
              DataGridCell<String>(columnName: 'E', value: dataGridRow.e),
              DataGridCell<String>(columnName: 'F', value: dataGridRow.f),
              DataGridCell<String>(columnName: 'G', value: dataGridRow.g),
            ]))
        .toList();
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
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.center
              : Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

class Datas {
  Datas(this.id, this.a, this.b, this.c, this.d, this.e, this.f, this.g);
  final int id;
  final String a;
  final String b;
  final String c;
  final String d;
  final String e;
  final String f;
  final String g;
}
