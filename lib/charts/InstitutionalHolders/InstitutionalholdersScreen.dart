import 'package:flutter/material.dart';
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
        border: Border.all(
          color: Colors.teal,
          style: BorderStyle.none,
          width: 2,
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: PaginatedDataTable(
        header: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Top Shareholders",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),

            /*
            if (top25 > 0)
              Text(
                  "Top 25 shareholders own ${top25.toStringAsFixed(2)}% of the company",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),

                      */
          ],
        ),
        source: tempdata,
        columns: const [
          DataColumn(label: Text("Ownership")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Shares")),
          DataColumn(label: Text("Change")),
          DataColumn(label: Text("Reported Date"))
        ],
      ),
    );
  }
}
