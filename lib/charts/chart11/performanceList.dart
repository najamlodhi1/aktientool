import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/charts/chart11/data.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';

class PerformanceList extends StatefulWidget {
  const PerformanceList(this.data, {super.key});
  final dynamic data;
  @override
  State<PerformanceList> createState() => PerformanceListState();
}

class PerformanceListState extends State<PerformanceList> {
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
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${trans.translate('Performance with')} 1000\$",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.white)),
                    Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                            children: List.generate(
                                9,
                                (index) => _buildGridViewItem(
                                    index, snapshot.data[0])))),
                  ],
                ));
          } else {
            return const SizedBox();
          }
        });
  }

  Widget _buildGridViewItem(int index, data) {
    return LayoutBuilder(builder: (_, c) {
      var fontSize = 15.5;
      return Column(
        children: [
          Container(
            padding: index == 0
                ? const EdgeInsets.only(bottom: 4.8)
                : index == 8
                    ? const EdgeInsets.only(top: 4.8)
                    : const EdgeInsets.symmetric(vertical: 4.8),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '${index == 0 ? '1D' : index == 1 ? '1M' : index == 2 ? '3M' : index == 3 ? '6M' : index == 4 ? '1J' : index == 5 ? '3J' : index == 6 ? '5J' : index == 7 ? '10J' : 'MAX'}: ${index == 0 ? data.the1D : index == 1 ? data.the1M : index == 2 ? data.the3M : index == 3 ? data.the6M : index == 4 ? data.the1Y : index == 5 ? data.the3Y : index == 6 ? data.the5Y : index == 7 ? data.the10Y : data.max}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      // fontWeight: FontWeight.bold
                    )),
                Text(
                    '${index == 0 ? (1000 + (10 * double.parse(data.the1D))).toStringAsFixed(2) : index == 1 ? (1000 + (10 * double.parse(data.the1M))).toStringAsFixed(2) : index == 2 ? (1000 + (10 * double.parse(data.the3M))).toStringAsFixed(2) : index == 3 ? (1000 + (10 * double.parse(data.the6M))).toStringAsFixed(2) : index == 4 ? (1000 + (10 * double.parse(data.the1Y))).toStringAsFixed(2) : index == 5 ? (1000 + (10 * double.parse(data.the3Y))).toStringAsFixed(2) : index == 6 ? (1000 + (10 * double.parse(data.the5Y))).toStringAsFixed(2) : index == 7 ? (1000 + (10 * double.parse(data.the10Y))).toStringAsFixed(2) : (1000 + (10 * double.parse(data.max))).toStringAsFixed(2)} \$',
                    style: TextStyle(
                        color: index == 0 && double.parse(data.the1D) < 1000
                            ? Colors.red
                            : (index == 1 &&
                                    double.parse(data.the5D) >
                                        double.parse(data.the1M))
                                ? Colors.red
                                : (index == 2 &&
                                        double.parse(data.the1M) >
                                            double.parse(data.the3M))
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
                                                        double.parse(
                                                            data.the3Y))
                                                ? Colors.red
                                                : (index == 6 &&
                                                        double.parse(
                                                                data.the3Y) >
                                                            double.parse(
                                                                data.the5Y))
                                                    ? Colors.red
                                                    : (index == 7 &&
                                                            double.parse(data
                                                                    .the5Y) >
                                                                double.parse(data
                                                                    .the10Y))
                                                        ? Colors.red
                                                        : (index == 8 &&
                                                                double.parse(data
                                                                        .the10Y) >
                                                                    double.parse(
                                                                        data.max))
                                                            ? Colors.red
                                                            : Colors.green,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          (index == 8)
              ? const SizedBox()
              : const SizedBox(
                  // width: double.maxFinite,
                  child: Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                ),
        ],
      );
    });
  }
}
