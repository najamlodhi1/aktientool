import 'dart:developer';

import 'package:aktientool/charts/chart13/post.dart';
import 'package:aktientool/charts/chart13/data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'dart:html' as html;

class DataGridWidget extends StatelessWidget {
  final List<Post> companyInfoList;
  CompanyInfoDataSource companyInfoDatasource =
      CompanyInfoDataSource(companyInfo: companyInfo);

  DataGridWidget({Key? key, required this.companyInfoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'IPO Calendar',
          style: TextStyle(fontSize: 20),
        ),
        SfDataGridTheme(
            data: SfDataGridThemeData(
                headerHoverColor: Colors.transparent,
                gridLineColor: Colors.transparent),
            child: SfDataGrid(
                columnWidthMode: ColumnWidthMode.fill,
                source: companyInfoDatasource,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'company',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Company',
                          ))),
                  GridColumn(
                      columnName: 'symbol',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Symbol',
                          ))),
                  GridColumn(
                      columnName: 'exchange',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Exchange',
                          ))),
                  GridColumn(
                      columnName: 'priceRange',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Price Range',
                          )))
                ])),
        SfDataPager(
            pageCount: companyInfoList.length / 5,
            delegate: companyInfoDatasource,
            visibleItemsCount: 5)
      ],
    );
  }
}

class CompanyInfoDataSource extends DataGridSource {
  int startRowIndex = 0;
  int endRowIndex = 5;

  CompanyInfoDataSource({required List<Post> companyInfo}) {
    _companyInfo = companyInfo
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'company', value: e.company),
              DataGridCell(columnName: 'symbol', value: e.exchange),
              DataGridCell(columnName: 'exchange', value: e.exchange),
              DataGridCell(columnName: 'priceRange', value: e.priceRange),
            ]))
        .toList();
  }

  List<DataGridRow> _paginatedCompanyInfo = [];

  List<DataGridRow> _companyInfo = [];

  @override
  List<DataGridRow> get rows => _paginatedCompanyInfo;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: Colors.transparent,
        cells: row.getCells().map<Widget>((dataGridCell) {
          // log('clumn name from datagrid is : ${dataGridCell.columnName}');
          if (dataGridCell.columnName == 'company') {
            return InkWell(
              onTap: () {
                log('company cell is clicked : ${dataGridCell.value}');
                html.window.open(
                    'https://www.google.com/search?q=${dataGridCell.value}',
                    dataGridCell.columnName);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: Text(dataGridCell.value.toString()),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(dataGridCell.value.toString()),
            );
          }
        }).toList());
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    startRowIndex = newPageIndex * 5;
    endRowIndex = startRowIndex + 5;
    _paginatedCompanyInfo = _companyInfo
        .getRange(startRowIndex, endRowIndex)
        .toList(growable: false);
    notifyDataSourceListeners();
    return true;
  }
}
