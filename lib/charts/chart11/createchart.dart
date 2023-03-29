import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/charts/chart11/data.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import 'DataSource.dart';

class CreateChart11 extends StatefulWidget {
  const CreateChart11(this.data, {super.key});
  final dynamic data;
  @override
  State<CreateChart11> createState() => CreateChart11State();
}

class CreateChart11State extends State<CreateChart11> {
  late AppLocalizations trans;
  late Future getFuture;

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
                      bodySmall: TextStyle(color: primaryColor)),
                ),
                child: DataTableTheme(
                  data: DataTableThemeData(
                    dataRowHeight: 48,
                    headingRowHeight: 48,
                    horizontalMargin: 0,
                    columnSpacing: 0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                  ),
                  child: PaginatedDataTable(
                    arrowHeadColor: primaryColor,
                    header: Center(
                      child: Text(
                          "${trans.translate('Performance with')} 1000\$",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Colors.white)),
                    ),
                    source: tempdata,
                    columns: [
                      DataColumn(
                          label: Text(trans.translate("Time"),
                              style: const TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text(trans.translate("Performance"),
                              style: const TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text(trans.translate("Price"),
                              style: const TextStyle(color: Colors.white)))
                    ],
                  ),
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
