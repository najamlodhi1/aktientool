import 'package:flutter/material.dart';

import 'CompanyModel.dart';

class DataSource extends DataTableSource {
  final BuildContext context;
  final List<DividendModel> _data;
  DataSource(this.context, this._data);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index].declarationDate)),
      DataCell(Text(_data[index].recordDate)),
      DataCell(Text(_data[index].paymentDate)),
      DataCell(Text(_data[index].dividend))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
