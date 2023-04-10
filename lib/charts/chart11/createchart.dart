import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/charts/chart11/data.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';

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
            // final DataTableSource tempdata = DataSource(context, snapshot.data);
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
                child: Column(
                  children: [
                    Text("${trans.translate('Performance with')} 1000\$",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 20 / 9,
                          clipBehavior: Clip.antiAlias,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          shrinkWrap: true,
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 800 ? 3 : 2,
                          children: List.generate(
                              9,
                              (index) =>
                                  _buildGridViewItem(index, snapshot.data[0]))),
                    ),
                  ],
                )

                // Theme(
                //   data: Theme.of(context).copyWith(
                //     cardColor: primaryColor,
                //     textTheme: const TextTheme(
                //         bodySmall: TextStyle(color: primaryColor)),
                //   ),
                //   child: DataTableTheme(
                //     data: DataTableThemeData(
                //       dataRowHeight: 48,
                //       headingRowHeight: 48,
                //       horizontalMargin: 0,
                //       columnSpacing: 0,
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.transparent),
                //       ),
                //     ),
                //     child: PaginatedDataTable(
                //       arrowHeadColor: primaryColor,
                //       header: Center(
                //         child: Text(
                //             "${trans.translate('Performance with')} 1000\$",
                //             style: const TextStyle(
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 22,
                //                 color: Colors.white)),
                //       ),
                //       source: tempdata,
                //       columns: [
                //         DataColumn(
                //             label: Text(trans.translate("Time"),
                //                 style: const TextStyle(color: Colors.white))),
                //         DataColumn(
                //             label: Text(trans.translate("Performance"),
                //                 style: const TextStyle(color: Colors.white))),
                //         DataColumn(
                //             label: Text("${trans.translate("Price")} in \$",
                //                 style: const TextStyle(color: Colors.white)))
                //       ],
                //     ),
                //   ),
                // ),
                );
          } else {
            //return const Center(child: CircularProgressIndicator());
            return const SizedBox();
          }
        });
  }

  Widget _buildGridViewItem(int index, data) {
    return LayoutBuilder(builder: (_, c) {
      final width = c.maxWidth;
      var fontSize = 16.0;
      if (width <= 480) {
        fontSize = 16.0;
      } else if (width > 480 && width <= 960) {
        fontSize = 25.0;
      } else {
        fontSize = 50.0;
      }
      return Container(
        decoration: BoxDecoration(
            color: index == 0 && double.parse(data.the1D) < 1000
                ? Colors.red
                : (index == 1 &&
                        double.parse(data.the5D) > double.parse(data.the1M))
                    ? Colors.red
                    : (index == 2 &&
                            double.parse(data.the1M) > double.parse(data.the3M))
                        ? Colors.red
                        : (index == 3 &&
                                double.parse(data.the3M) >
                                    double.parse(data.the6M))
                            ? Colors.red
                            : (index == 4 &&
                                    double.parse(data.the6M) >
                                        double.parse(data.the1Y))
                                ? Colors.red
                                : (index == 5 &&
                                        double.parse(data.the1Y) >
                                            double.parse(data.the3Y))
                                    ? Colors.red
                                    : (index == 6 &&
                                            double.parse(data.the3Y) >
                                                double.parse(data.the5Y))
                                        ? Colors.red
                                        : (index == 7 &&
                                                double.parse(data.the5Y) >
                                                    double.parse(data.the10Y))
                                            ? Colors.red
                                            : (index == 8 &&
                                                    double.parse(data.the10Y) >
                                                        double.parse(data.max))
                                                ? Colors.red
                                                : Colors.green,
            borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '${index == 0 ? '1D' : index == 1 ? '1M' : index == 2 ? '3M' : index == 3 ? '6M' : index == 4 ? '1J' : index == 5 ? '3J' : index == 6 ? '5J' : index == 7 ? '10J' : 'MAX'}: ${index == 0 ? data.the1D : index == 1 ? data.the1M : index == 2 ? data.the3M : index == 3 ? data.the6M : index == 4 ? data.the1Y : index == 5 ? data.the3Y : index == 6 ? data.the5Y : index == 7 ? data.the10Y : data.max}%',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold)),
            Text(
                '${index == 0 ? (1000 + (10 * double.parse(data.the1D))).toStringAsFixed(2) : index == 1 ? (1000 + (10 * double.parse(data.the5D))).toStringAsFixed(2) : index == 2 ? (1000 + (10 * double.parse(data.the1M))).toStringAsFixed(2) : index == 3 ? (1000 + (10 * double.parse(data.the3M))).toStringAsFixed(2) : index == 4 ? (1000 + (10 * double.parse(data.the6M))).toStringAsFixed(2) : index == 5 ? (1000 + (10 * double.parse(data.the1Y))).toStringAsFixed(2) : index == 6 ? (1000 + (10 * double.parse(data.the3Y))).toStringAsFixed(2) : index == 7 ? (1000 + (10 * double.parse(data.the5Y))).toStringAsFixed(2) : index == 8 ? (1000 + (10 * double.parse(data.the10Y))).toStringAsFixed(2) : (1000 + (10 * double.parse(data.max))).toStringAsFixed(2)} \$',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ],
        ),
      );
    });
  }
}
