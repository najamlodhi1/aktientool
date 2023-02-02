// ignore_for_file: deprecated_member_use

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
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  final DataGridController _dataGridController = DataGridController();
  late List<Data> myDatas;
  late DataSource myDataSource;
  var selectList = [];

  List<Data> getData() {
    return [
      //RemoteService().getData(
      //"https://financialmodelingprep.com/api/v3/income-statement/$stock?limit=20&apikey=${Env.fmpKey}"),

      Data(1.5, DateTime.now()),
    ];
  }

  @override
  void initState() {
    super.initState();
    myDatas = getData();
    myDataSource = DataSource(myDatas);
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
                                    child: Center(
                                        child: Text(
                                      snapshot.data[0].year
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))),
                              ),
                              frozenColumnsCount: 1,
                              controller: _dataGridController,
                              showCheckboxColumn: true,
                              checkboxShape: const CircleBorder(),
                              allowSorting: false,
                              selectionMode: SelectionMode.multiple,
                              source: myDataSource,
                              columns: [
                                for (int i = 0; i < 2; i++) ...[
                                  GridTextColumn(
                                      columnName: "Date",
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          snapshot.data[i].year
                                              .toString()
                                              .substring(0, 4),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )),
                                ],
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

class DataSource extends DataGridSource {
  DataSource(List<Data> employees) {
    dataGridRows = employees
        .map<DataGridRow>((value) => DataGridRow(cells: [
              for (int i = 0; i < 2; i++) ...[
                DataGridCell<double>(
                    columnName: 'revenue', value: value.revenue)
              ],
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
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
