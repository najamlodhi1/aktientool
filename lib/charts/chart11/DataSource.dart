import 'package:flutter/material.dart';

class DataSource extends DataTableSource {
  final BuildContext context;
  final dynamic data;
  DataSource(this.context, this.data);

  @override
  DataRow? getRow(int index) {
    if (index == 0) {
      return DataRow(cells: [
        const DataCell(Text('1D', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the1D}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the1D))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 1) {
      return DataRow(cells: [
        const DataCell(Text('5D', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the5D}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the5D))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 2) {
      return DataRow(cells: [
        const DataCell(Text('1M', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the1M}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the1M))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 3) {
      return DataRow(cells: [
        const DataCell(Text('3M', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the3M}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the3M))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 4) {
      return DataRow(cells: [
        const DataCell(Text('6M', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the6M}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the6M))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 5) {
      return DataRow(cells: [
        const DataCell(Text('1Y', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the1Y}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the1Y))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 6) {
      return DataRow(cells: [
        const DataCell(Text('3Y', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the3Y}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the3Y))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 7) {
      return DataRow(cells: [
        const DataCell(Text('5Y', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the5Y}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the5Y))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 8) {
      return DataRow(cells: [
        const DataCell(Text('10Y', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].the10Y}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].the10Y))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    if (index == 9) {
      return DataRow(cells: [
        const DataCell(Text('MAX', style: TextStyle(color: Colors.white))),
        DataCell(Text('${data[0].max}%',
            style: const TextStyle(color: Colors.white))),
        DataCell(Text(
            (1000 + (10 * double.parse(data[0].max))).toStringAsFixed(2),
            style: const TextStyle(color: Colors.white)))
      ]);
    }
    return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
