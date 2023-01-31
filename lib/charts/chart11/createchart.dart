import 'package:aktientool/charts/chart11/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import '../../webpage/constants.dart';

class CreateChart11 extends StatefulWidget {
  const CreateChart11({super.key});

  @override
  State<CreateChart11> createState() => CreateChart11State();
}

class CreateChart11State extends State<CreateChart11> {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "PLTR";

  loadData() {
    return RemoteService().getData(
        "https://financialmodelingprep.com/api/v3/stock-price-change/$stock?apikey=${Env.fmpKey}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<dynamic>(
            future: loadData(),
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Wrap(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.teal,
                            style: BorderStyle.none,
                            width: 2,
                          ),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Performance',
                              style: TextStyle(fontSize: 20),
                            ),
                            const Divider(),
                            Text(
                              '${'1D: ' + snapshot.data[0].the1D}% - ${(1000 + (10 * double.parse(snapshot.data[0].the1D))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the1D)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),

                            Text(
                              '${'5D: ' + snapshot.data[0].the5D}% - ${(1000 + (10 * double.parse(snapshot.data[0].the5D))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the5D)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              '${'1M: ' + snapshot.data[0].the1M}% - ${(1000 + (10 * double.parse(snapshot.data[0].the1M))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the1M)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              '${'3M: ' + snapshot.data[0].the3M}% - ${(1000 + (10 * double.parse(snapshot.data[0].the3M))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the3M)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              '${'6M: ' + snapshot.data[0].the6M}% - ${(1000 + (10 * double.parse(snapshot.data[0].the6M))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the6M)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              '${'1Y: ' + snapshot.data[0].the1Y}% - ${(1000 + (10 * double.parse(snapshot.data[0].the1Y))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the1Y)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              '${'3Y: ' + snapshot.data[0].the3Y}% - ${(1000 + (10 * double.parse(snapshot.data[0].the3Y))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the3Y)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              '${'5Y: ' + snapshot.data[0].the5Y}% - ${(1000 + (10 * double.parse(snapshot.data[0].the5Y))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the5Y)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              '${'10Y: ' + snapshot.data[0].the10Y}% - ${(1000 + (10 * double.parse(snapshot.data[0].the10Y))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(snapshot
                                                      .data[0].the10Y)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              '${'MAX: ' + snapshot.data[0].max}% - ${(1000 + (10 * double.parse(snapshot.data[0].max))).toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  color: (1000 +
                                              (10 *
                                                  double.parse(
                                                      snapshot.data[0].the1D)) >
                                          1000.00)
                                      ? kPrimaryColor
                                      : Colors.red,
                                  fontSize: 16),
                            ),
                            const Divider(),
                            ////////////////////
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}
