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
      DataCell(Text('${_data[index].ownership.toStringAsFixed(2)}%',
          style: const TextStyle(color: Colors.white))),
      DataCell(Text(_data[index].holder,
          style: const TextStyle(color: Colors.white))),
      DataCell(Text(_data[index].shares.toString(),
          style: const TextStyle(color: Colors.white))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
