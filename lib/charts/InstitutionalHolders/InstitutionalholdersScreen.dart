// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart0/createchart.dart';
import 'DataSource.dart';
import 'InstitutionalholdersModel.dart';
import 'InstitutionalholdersService.dart';

class Institutionalholders extends StatefulWidget {
  const Institutionalholders(this.data, {super.key});
  final dynamic data;
  @override
  State<Institutionalholders> createState() => _InstitutionalholdersState();
}

class _InstitutionalholdersState extends State<Institutionalholders> {
  late Future<List<InstitutionalholdersModel>> getFuture;
  bool iseditable = true;
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    getFuture = InstitutionalholdersService().getData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
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
          header: Center(
            child: Text(trans.translate("Top Shareholders"),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white)),
          ),
          source: tempdata,
          columns: [
            DataColumn(
                label: Text(trans.translate("Ownership"),
                    style: const TextStyle(color: Colors.white))),
            DataColumn(
                label: Text(trans.translate("Name"),
                    style: const TextStyle(color: Colors.white))),
            DataColumn(
                label: Text(trans.translate("Shares"),
                    style: const TextStyle(color: Colors.white))),
            DataColumn(
                label: Text(trans.translate("Change"),
                    style: const TextStyle(color: Colors.white))),
            DataColumn(
                label: Text(trans.translate("Reported Date"),
                    style: const TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
