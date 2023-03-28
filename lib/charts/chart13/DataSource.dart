// ignore_for_file: file_names

import 'package:aktientool/charts/chart13/post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

class DataSource extends DataTableSource {
  final BuildContext context;
  final List<Post> _data;
  DataSource(this.context, this._data);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(DateFormat('MMM dd yyyy').format(_data[index].date),
          style: const TextStyle(color: Colors.white))),
      DataCell(
          Text(_data[index].company,
              style: const TextStyle(color: Colors.white)), onTap: () {
        html.window.open(
            'https://www.google.com/search?q=${_data[index].company}',
            _data[index].company);
      }),
      DataCell(Text(_data[index].symbol,
          style: const TextStyle(color: Colors.white))),
      DataCell(Text(_data[index].exchange,
          style: const TextStyle(color: Colors.white))),
      DataCell(Text(_data[index].priceRange.toString(),
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
