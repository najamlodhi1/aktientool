// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../chart0/createchart.dart';
import 'DataSource.dart';
import 'InstitutionalholdersModel.dart';
import 'InstitutionalholdersService.dart';

class Institutionalholders extends StatefulWidget {
  const Institutionalholders({super.key});

  @override
  State<Institutionalholders> createState() => _InstitutionalholdersState();
}

class _InstitutionalholdersState extends State<Institutionalholders> {
  late Future<List<InstitutionalholdersModel>> getFuture;
  bool iseditable = true;

  @override
  void initState() {
    super.initState();
    getFuture = InstitutionalholdersService().getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InstitutionalholdersModel>>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return bodyWidget(snapshot.data!);
          } else {
            //return const Center(child: CircularProgressIndicator());
            return const SizedBox();
          }
        });
  }

  Widget bodyWidget(List<InstitutionalholdersModel> data) {
    int totalshares =
        data.map((e) => e.shares).reduce((value, element) => value + element);
    double top25 = 0;
    for (var i = 0; i < data.length; i++) {
      data[i].ownership = (data[i].shares / totalshares) * 100;
    }
    data.sort((a, b) => b.shares.compareTo(a.shares));
    if (data.length > 25) {
      for (var i = 0; i < 25; i++) {
        top25 = top25 + data[i].ownership;
      }
    }
    final DataTableSource tempdata = DataSource(context, data);
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryColor,
        border:
            Border.all(color: Colors.teal, style: BorderStyle.none, width: 2),
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
            child: Text("Top Shareholders",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white)),
          ),
          source: tempdata,
          columns: const [
            DataColumn(
                label:
                    Text("Ownership", style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text("Name", style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text("Shares", style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text("Change", style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text("Reported Date",
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
