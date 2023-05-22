import 'package:custom_charts/flutter.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import '../chart0/createchart.dart';
import 'DataSource.dart';
import 'InstitutionalholdersModel.dart';
import 'InstitutionalholdersService.dart';

class Institutionalholders extends StatefulWidget {
  const Institutionalholders(this.shareFloat, this.data, {super.key});
  final dynamic data;
  final dynamic shareFloat;
  @override
  State<Institutionalholders> createState() => _InstitutionalholdersState();
}

class _InstitutionalholdersState extends State<Institutionalholders> {
  late Future<List<InstitutionalholdersModel>> getFuture;
  bool iseditable = true;
  late AppLocalizations trans;
  double shareFloat = 0;
  @override
  void initState() {
    super.initState();
    shareFloat = InstitutionalholdersService().getShareFloat(widget.shareFloat);
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
    double top25 = 0;
    for (var i = 0; i < data.length; i++) {
      data[i].ownership = (data[i].shares * 100) / shareFloat;
    }
    data.sort((a, b) => b.shares.compareTo(a.shares));
    if (data.length > 25) {
      for (var i = 0; i < 25; i++) {
        top25 = top25 + data[i].shares;
      }
    }
    double top25Percentage = (top25 / shareFloat) * 100;
    final DataTableSource tempdata = DataSource(context, data);
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        border:
            Border.all(color: Colors.teal, style: BorderStyle.none, width: 2),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(trans.translate("Top Shareholders"),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white)),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    trans
                        .translate("Top 25 shareholders")
                        .replaceAll('10', top25Percentage.toStringAsFixed(2)),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
                SizedBox(
                  width: double.maxFinite,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        cardColor: primaryColor,
                        textTheme: const TextTheme(
                            bodySmall: TextStyle(color: Colors.white))),
                    child: PaginatedDataTable(
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          shareHolderPieChart(data)
        ],
      ),
    );
  }

  Widget shareHolderPieChart(List<InstitutionalholdersModel> data) {
    return AspectRatio(
      aspectRatio:
          MediaQuery.of(context).size.width < 800 ? (23 / 16) : (22 / 7),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: PieChart<String>(createData(data),
                  animate: true,
                  layoutConfig: LayoutConfig(
                      leftMarginSpec: MarginSpec.fixedPixel(0),
                      topMarginSpec: MarginSpec.fixedPixel(0),
                      rightMarginSpec: MarginSpec.fixedPixel(0),
                      bottomMarginSpec: MarginSpec.fixedPixel(0)),
                  defaultRenderer: ArcRendererConfig(
                      arcWidth:
                          MediaQuery.of(context).size.width < 800 ? 30 : 85,
                      arcRendererDecorators: [
                        ArcLabelDecorator(
                            labelPosition: ArcLabelPosition.outside,
                            leaderLineStyleSpec: ArcLabelLeaderLineStyleSpec(
                                color:
                                    CustomChartColor.fromHex(code: '#B6C2D0'),
                                length: 30,
                                thickness: 1)),
                      ])),
            ),
          ),
          // Center(
          //   child: SizedBox(
          //     height: 200,
          //     width: 200,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       verticalDirection: VerticalDirection.down,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text('Top 5 Total',
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize:
          //                     MediaQuery.of(context).size.width < 800 ? 10 : 12,
          //                 fontWeight: FontWeight.bold)),
          //         Text( numberToKFormat(top5totalShares),
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize:
          //                     MediaQuery.of(context).size.width < 800 ? 8 : 12,
          //                 fontWeight: FontWeight.w500),
          //           ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  List<Series<ShareHolderChartData, String>> createData(
      List<InstitutionalholdersModel> data) {
    List<ShareHolderChartData> resultdata = [];
    for (var i = 0; i < data.length; i++) {
      if (i <= 5) {
        resultdata.add(ShareHolderChartData(data[i].holder, data[i].ownership));
      } else {
        resultdata.last = ShareHolderChartData(
            "Others", (resultdata.last.value + data[i].ownership));
      }
    }
    return [
      Series<ShareHolderChartData, String>(
          id: 'Shareholders',
          domainFn: (ShareHolderChartData chartData, _) => chartData.category,
          measureFn: (ShareHolderChartData chartData, _) => chartData.value,
          data: resultdata,
          outsideLabelStyleAccessorFn: (datum, index) => MediaQuery.of(context)
                      .size
                      .width <
                  800
              ? const TextStyleSpec(fontSize: 8, color: CustomChartColor.white)
              : const TextStyleSpec(color: CustomChartColor.white),
          labelAccessorFn: (ShareHolderChartData chartData, _) =>
              '${breakline(chartData.category)}:\n${chartData.value.toStringAsFixed(2)}%',
          colorFn: (_, index) => CustomChartColor.fromHex(code: colors[index!]))
    ];
  }

  String breakline(String string) {
    String result = "";
    List<String> parts = string.split(" ");
    if (MediaQuery.of(context).size.width < 800) {
      for (int i = 0; i < parts.length; i++) {
        if (i != 0) {
          result += "\n";
        }
        result += "${parts[i]} ";
      }
    } else {
      return string;
    }
    return result;
  }

  List colors = [
    '#63778E',
    '#708296',
    '#77889b',
    '#8494A8',
    '#94A3B5',
    '#94A3B5',
    '#A5B3C3',
    '#B6C2D0'
  ];
}

class ShareHolderChartData {
  final String category;
  final double value;

  ShareHolderChartData(this.category, this.value);
}
