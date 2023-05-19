import 'package:custom_charts/flutter.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
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
  double totalAssets = 0;
  late AppLocalizations trans;

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
    calculatetotal;
    super.initState();
  }

  void get calculatetotal {
    totalAssets = 0;
    if (widget.isassets) {
      for (var element in widget.data) {
        if (assets.contains(element.title)) {
          if (element.title == "Total Current Assets" ||
              element.title == "Total non-current Assets") {
            totalAssets += element.value;
          }
        }
      }
    } else {
      for (var element in widget.data) {
        if (liabilities.contains(element.title)) {
          if (element.title == "Total current liabilities" ||
              element.title == "Total non-current liabilities") {
            totalAssets += element.value;
          }
        }
      }
    }
  }

  int calculatePercentage(String title) {
    return ((widget.data.firstWhere((element) => element.title == title).value /
                totalAssets) *
            100)
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);

    return AspectRatio(
      aspectRatio:
          MediaQuery.of(context).size.width < 800 ? (23 / 9) : (22 / 9),
      child: Stack(
        children: [
          Center(
            child: PieChart<String>(createSampleData(),
                animate: true,
                layoutConfig: LayoutConfig(
                    leftMarginSpec: MarginSpec.fixedPixel(0),
                    topMarginSpec: MarginSpec.fixedPixel(0),
                    rightMarginSpec: MarginSpec.fixedPixel(0),
                    bottomMarginSpec: MarginSpec.fixedPixel(0)),
                defaultRenderer: ArcRendererConfig(
                    arcWidth: MediaQuery.of(context).size.width < 800 ? 30 : 85,
                    arcRendererDecorators: [
                      ArcLabelDecorator(
                          labelPosition: ArcLabelPosition.outside,
                          leaderLineStyleSpec: ArcLabelLeaderLineStyleSpec(
                              color: CustomChartColor.fromHex(code: '#B6C2D0'),
                              length: 30,
                              thickness: 1)),
                    ])),
          ),
          Center(
            child: SizedBox(
              height: 200,
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
                          fontSize:
                              MediaQuery.of(context).size.width < 800 ? 10 : 12,
                          fontWeight: FontWeight.bold)),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: numberToKFormat(totalAssets),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.width < 800 ? 8 : 12,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: ' USD',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.width < 800 ? 8 : 12,
                          fontWeight: FontWeight.bold),
                    )
                  ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Series<ChartData, String>> createSampleData() {
    calculatetotal;
    var data;
    if (widget.isassets) {
      data = assets
          .where((element) =>
              element != 'Total Current Assets' &&
              element != 'Total non-current Assets')
          .map((e) => ChartData(e, calculatePercentage(e)))
          .toList();
    } else {
      data = liabilities
          .where((element) =>
              element != 'Total current liabilities' &&
              element != 'Total non-current liabilities')
          .map((e) => ChartData(e, calculatePercentage(e)))
          .toList();
    }

    return [
      Series<ChartData, String>(
          id: 'Categories',
          domainFn: (ChartData chartData, _) => chartData.category,
          measureFn: (ChartData chartData, _) => chartData.value,
          data: data,
          outsideLabelStyleAccessorFn: (datum, index) => MediaQuery.of(context)
                      .size
                      .width <
                  800
              ? const TextStyleSpec(fontSize: 8, color: CustomChartColor.white)
              : const TextStyleSpec(color: CustomChartColor.white),
          labelAccessorFn: (ChartData chartData, _) =>
              '${breakline(trans.translate(chartData.category))}:\n${chartData.value}%',
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
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}
