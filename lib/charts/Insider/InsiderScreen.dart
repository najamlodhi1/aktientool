import 'package:aktientool/charts/Insider/InsiderModel.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart0/createchart.dart';
import 'DataSource.dart';
import 'InsiderService.dart';

class InsiderScreen extends StatefulWidget {
  const InsiderScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<InsiderScreen> createState() => InsiderScreenState();
}

class InsiderScreenState extends State<InsiderScreen> {
  late Future<List<InsiderModel>> getFuture;
  late AppLocalizations trans;

  loadData() {
    return InsiderService().getData(widget.data);
  }

  @override
  void initState() {
    getFuture = loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return FutureBuilder<List<InsiderModel>>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return bodyWidget(snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget bodyWidget(List<InsiderModel> data) {
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
              child: Text(trans.translate('Insider'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.white)),
            ),
            source: tempdata,
            columns: [
              DataColumn(
                  label: Text(trans.translate('Name'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('Transaction'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('Date'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('Trading Shares'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('Price'),
                      style: const TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text(trans.translate('Owned Stocks'),
                      style: const TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
