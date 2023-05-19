import 'package:custom_charts/flutter.dart';
import 'package:flutter/material.dart';
import '../chart2/IncomeReportModel.dart';
import 'BarChartBalanceScreen.dart';

class DonutChart extends StatefulWidget {
  const DonutChart(this.data, {super.key});
  final List<ReportItemModel> data;

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  double totalAssets = 0;
  List<String> titles = [
    "Total Current Assets",
    "Cash and Short Term Investments",
    "Receivables",
    "Other Current Assets",
    "Total non-current Assets",
    "Property, Plant & Equipment Net",
    "Long Term Investments",
    "Other non-current Assets"
  ];

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
  @override
  void initState() {
    for (var element in widget.data) {
      if (titles.contains(element.title)) {
        totalAssets += element.value;
      }
    }
    super.initState();
  }

  int calculatePercentage(String title) {
    return ((widget.data.firstWhere((element) => element.title == title).value /
                totalAssets) *
            100)
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 400,
          child: Center(
            child: PieChart<String>(createSampleData(),
                animate: true,
                defaultRenderer:
                    ArcRendererConfig(arcWidth: 85, arcRendererDecorators: [
                  ArcLabelDecorator(
                      labelPosition: ArcLabelPosition.outside,
                      leaderLineStyleSpec: ArcLabelLeaderLineStyleSpec(
                          color: CustomChartColor.fromHex(code: '#B6C2D0'),
                          length: 20,
                          thickness: 2)),
                ])),
          ),
        ),
        Center(
          child: SizedBox(
            height: 400,
            width: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Total Assets',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: numberToKFormat(totalAssets),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const TextSpan(
                    text: ' USD',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ])),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Series<ChartData, String>> createSampleData() {
    final data =
        titles.map((e) => ChartData(e, calculatePercentage(e))).toList();

    return [
      Series<ChartData, String>(
        id: 'Categories',
        domainFn: (ChartData chartData, _) => chartData.category,
        measureFn: (ChartData chartData, _) => chartData.value,
        data: data,
        labelAccessorFn: (ChartData chartData, _) =>
            '${chartData.category}:\n${chartData.value}%',
        colorFn: (_, index) => CustomChartColor.fromHex(code: colors[index!]),
      ),
    ];
  }
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}
