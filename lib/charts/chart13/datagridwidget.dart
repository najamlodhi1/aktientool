import 'package:aktientool/charts/chart13/post.dart';
import 'package:flutter/material.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class DataGridWidget extends StatelessWidget {
  final List<Post> companyInfoList;

  const DataGridWidget({Key? key, required this.companyInfoList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'IPO Calendar',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey[300]),
            columns: const [
              DataColumn(label: Text('Company')),
              DataColumn(label: Text('Symbol')),
              DataColumn(label: Text('Exchange')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('PriceRange')),
            ],
            rows: [
              ...companyInfoList.map((e) {
                return DataRow(cells: [
                  DataCell(Text(e.company), onTap: () {
                    html.window.open(
                        'https://www.google.com/search?q=${e.company}',
                        e.company);
                  }),
                  DataCell(Text(e.symbol)),
                  DataCell(Text(e.exchange)),
                  DataCell(Text(e.date.toString())),
                  DataCell(Text(e.priceRange.toString())),
                ]);
              }).toList(),
            ]),
      ],
    );
  }
}
