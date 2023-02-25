// ignore_for_file: file_names

import 'package:aktientool/charts/InstitutionalHolders/InstitutionalholdersModel.dart';
import 'package:flutter/material.dart';

class DataSource extends DataTableSource {
  final BuildContext context;
  final List<InstitutionalholdersModel> _data;
  DataSource(this.context, this._data);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('${_data[index].ownership.toStringAsFixed(2)}%')),
      DataCell(Text(_data[index].holder)),
      DataCell(Text(_data[index].shares.toString())),
      DataCell(Text(_data[index].change.toString())),
      DataCell(Text(_data[index].dateReported)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
