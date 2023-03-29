import 'package:aktientool/charts/chart13/data.dart';
import 'package:aktientool/charts/chart13/post.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart0/createchart.dart';
import 'DataSource.dart';

class CreateChart13 extends StatefulWidget {
  const CreateChart13(this.data, {super.key});
  final dynamic data;
  @override
  State<CreateChart13> createState() => CreateChart13State();
}

class CreateChart13State extends State<CreateChart13> {
  late Future<List<Post>> getFuture;
  late AppLocalizations trans;

  loadData() {
    return RemoteService().getData(widget.data);
  }

  @override
  void initState() {
    getFuture = loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder<List<Post>>(
            future: getFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return bodyWidget(snapshot.data!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget bodyWidget(List<Post> data) {
    final DataTableSource tempdata = DataSource(context, data);
    return SingleChildScrollView(
      child: Container(
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
            header: Center(
              child: Text(trans.translate('IPO Calendar'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.white)),
            ),
            source: tempdata,
            columns: [
              DataColumn(
                  label: Text(trans.translate('Date'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('Company'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('Symbol'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('Exchange'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('PriceRange'),
                      style: const TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
