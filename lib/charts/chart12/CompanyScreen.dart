// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../chart0/createchart.dart';
import 'CompanyModel.dart';
import 'CompanyService.dart';
import 'DataSource.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  late Future<List<DividendModel>> getFuture;

  @override
  void initState() {
    super.initState();
    getFuture = CompanyService().getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DividendModel>>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return bodyWidget(snapshot.data!);
          } else {
            //return const Center(child: CircularProgressIndicator());
            return const SizedBox();
          }
        });
  }

  Widget bodyWidget(List<DividendModel> data) {
    final DataTableSource tempdata = DataSource(context, data);
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
          style: BorderStyle.none,
          width: 2,
        ),
        color: primaryColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            cardColor: primaryColor,
            textTheme:
                const TextTheme(bodySmall: TextStyle(color: Colors.white))),
        child: PaginatedDataTable(
          arrowHeadColor: Colors.white,
          header: const Center(
            child: Text("Dividend History",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white)),
          ),
          source: tempdata,
          columns: const [
            DataColumn(
                label: Text("Declared", style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text("Record", style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text("Payable", style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text("Amount", style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
