// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/charts/chart11/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'DataSource.dart';

class CreateChart11 extends StatefulWidget {
  const CreateChart11({super.key});

  @override
  State<CreateChart11> createState() => CreateChart11State();
}

class CreateChart11State extends State<CreateChart11> {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";
  late Future getFuture;

  loadData() {
    return RemoteService().getData(path: 'api/v3/stock-price-change/$stock');
  }

  @override
  void initState() {
    getFuture = loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final DataTableSource tempdata = DataSource(context, snapshot.data);
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.teal, style: BorderStyle.none, width: 2),
                color: primaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                    cardColor: primaryColor,
                    textTheme: const TextTheme(
                        bodySmall: TextStyle(color: Colors.white))),
                child: PaginatedDataTable(
                  arrowHeadColor: Colors.white,
                  header: const Center(
                    child: Text("Performance with 1000\$",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.white)),
                  ),
                  source: tempdata,
                  columns: const [
                    DataColumn(
                        label: Text("Time",
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text("Performance",
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text("Price",
                            style: TextStyle(color: Colors.white)))
                  ],
                ),
              ),
            );
          } else {
            //return const Center(child: CircularProgressIndicator());
            return const SizedBox();
          }
        });
  }
}
