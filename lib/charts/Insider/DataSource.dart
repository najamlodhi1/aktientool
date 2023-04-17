// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'InsiderModel.dart';

class DataSource extends DataTableSource {
  final BuildContext context;
  final List<InsiderModel> _data;
  final String currency;
  DataSource(this.context, this._data, this.currency);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
          Column(
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${_data[index].reportingName}\n',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: _data[index].typeOfOwner.split(': ').last),
                  ],
                ),
              ),
            ],
          ), onTap: () {
        html.window.open(
            'https://www.google.com/search?q=${_data[index].reportingName}',
            _data[index].reportingName);
      }),
      DataCell(Text(_data[index].transactionType,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _data[index].transactionType == "S-Sale"
                  ? Colors.redAccent
                  : Colors.green))),
      DataCell(Text(_data[index].filingDate,
          style: const TextStyle(color: Colors.white))),
      DataCell(
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: '${_data[index].securitiesTransacted}\n',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      "${(_data[index].securitiesTransacted * _data[index].price).toStringAsFixed(2)} $currency"),
            ],
          ),
        ),
      ),
      DataCell(Text("${_data[index].price} $currency",
          style: const TextStyle(color: Colors.white))),
      DataCell(Text(_data[index].securitiesOwned.toStringAsFixed(2),
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
