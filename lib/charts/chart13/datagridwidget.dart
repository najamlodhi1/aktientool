import 'package:aktientool/charts/chart13/post.dart';
import 'package:flutter/material.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:intl/intl.dart';

class DataGridWidget extends StatelessWidget {
  final List<Post> companyInfoList;

  const DataGridWidget({Key? key, required this.companyInfoList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 50,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: MaterialButton(
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          const Text(
            'IPO Calendar',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[300]),
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Company')),
                  DataColumn(label: Text('Symbol')),
                  DataColumn(label: Text('Exchange')),
                  DataColumn(label: Text('PriceRange')),
                ],
                rows: [
                  ...companyInfoList.map((e) {
                    final date = DateFormat('MMM dd yyyy').format(e.date);
                    return DataRow(cells: [
                      DataCell(Text(date)),
                      DataCell(Text(e.company), onTap: () {
                        html.window.open(
                            'https://www.google.com/search?q=${e.company}',
                            e.company);
                      }),
                      DataCell(Text(e.symbol)),
                      DataCell(Text(e.exchange)),
                      DataCell(Text(e.priceRange.toString())),
                    ]);
                  }).toList(),
                ]),
          ),
        ],
      ),
    );
  }
}
