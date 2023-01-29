import 'package:aktientool/charts/chart12/data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class DataGridWidget extends StatelessWidget {
  final List<CompanyInfo> companyInfoList;
  CompanyInfoDataSource companyInfoDatasource =
      CompanyInfoDataSource(companyInfo: companyInfo);

  DataGridWidget({Key? key, required this.companyInfoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Dividen History',
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
                      columnName: 'declared',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Declared',
                          ))),
                  GridColumn(
                      columnName: 'record',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Record',
                          ))),
                  GridColumn(
                      columnName: 'payable',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Payable',
                          ))),
                  GridColumn(
                      columnName: 'amount',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Amount',
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

  CompanyInfoDataSource({required List<CompanyInfo> companyInfo}) {
    _companyInfo = companyInfo
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'declared', value: e.declarationDate),
              DataGridCell(columnName: 'record', value: e.recordDate),
              DataGridCell(columnName: 'payable', value: e.paymentDate),
              DataGridCell(columnName: 'amount', value: e.dividend),
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
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text(dataGridCell.value.toString()),
          );
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
