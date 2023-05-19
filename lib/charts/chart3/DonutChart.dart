import 'package:custom_charts/flutter.dart';
import 'package:flutter/material.dart';
import '../chart2/IncomeReportModel.dart';
import 'BarChartBalanceScreen.dart';

class DonutChart extends StatefulWidget {
  const DonutChart(this.data, this.isassets, {super.key});
  final List<ReportItemModel> data;
  final bool isassets;

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  double totalAmount = 0;
  double totalAssets = 0;

  List<String> assets = [
        "Total Current Assets",
        "Cash and Short Term Investments",
        "Receivables",
        "Other Current Assets",
        "Total non-current Assets",
        "Property, Plant & Equipment Net",
        "Long Term Investments",
        "Other non-current Assets"
      ],
      liabilities = [
        'Total current liabilities',
        'Payables',
        'Short Term debt',
        'Other Current Liabilities',
        'Total non-current liabilities',
        'Long Term debt',
        'Other non-current Liabilities'
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
    if (widget.isassets) {
      for (var element in widget.data) {
        if (assets.contains(element.title)) {
          totalAmount += element.value;
          if (element.title == "Total Current Assets" ||
              element.title == "Total non-current Assets") {
            totalAssets += element.value;
          }
        }
      }
    } else {
      for (var element in widget.data) {
        if (liabilities.contains(element.title)) {
          totalAmount += element.value;
          if (element.title == "Total current liabilities" ||
              element.title == "Total non-current liabilities") {
            totalAssets += element.value;
          }
        }
      }
    }
    super.initState();
  }

  int calculatePercentage(String title) {
    return ((widget.data.firstWhere((element) => element.title == title).value /
                totalAmount) *
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
                Text(widget.isassets ? 'Total Assets' : 'Total Liabilities',
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
    var data;
    if (widget.isassets) {
      data = assets.map((e) => ChartData(e, calculatePercentage(e))).toList();
    } else {
      data =
          liabilities.map((e) => ChartData(e, calculatePercentage(e))).toList();
    }

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
