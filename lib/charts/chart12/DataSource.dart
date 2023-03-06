// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'CompanyModel.dart';

class DataSource extends DataTableSource {
  final BuildContext context;
  final List<DividendModel> _data;
  DataSource(this.context, this._data);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index].declarationDate,
          style: const TextStyle(color: Colors.white))),
      DataCell(Text(_data[index].recordDate,
          style: const TextStyle(color: Colors.white))),
      DataCell(Text(_data[index].paymentDate,
          style: const TextStyle(color: Colors.white))),
      DataCell(Text(_data[index].dividend,
          style: const TextStyle(color: Colors.white)))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
