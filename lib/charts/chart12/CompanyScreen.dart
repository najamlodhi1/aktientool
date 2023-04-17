// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart0/createchart.dart';
import 'CompanyModel.dart';
import 'CompanyService.dart';
import 'DataSource.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  late Future<List<DividendModel>> getFuture;
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    getFuture = CompanyService().getData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
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
    return ValueListenableBuilder(
      valueListenable: currencyNotifier,
      builder: (context, value, child) {
        DataTableSource tempdata = DataSource(context, data, value);
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
              header: Center(
                child: Text(trans.translate("Dividend History"),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Colors.white)),
              ),
              source: tempdata,
              columns: [
                /*DataColumn(
                  label: Text(trans.translate("Declared"),
                      style: const TextStyle(color: Colors.white))),
                      */
                DataColumn(
                    label: Text(trans.translate("Record"),
                        style: const TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text(trans.translate("Payable"),
                        style: const TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text(trans.translate("Amount"),
                        style: const TextStyle(color: Colors.white)))
              ],
            ),
          ),
        );
      },
    );
  }
}
