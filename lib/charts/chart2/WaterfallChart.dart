import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WaterfallChart extends StatelessWidget {
  final List<WaterfallData> data = [
    WaterfallData(label: 'Starting', value: 400),
    WaterfallData(label: 'Product Sales', value: 150),
    WaterfallData(label: 'Returns', value: -20),
    WaterfallData(label: 'Net Sales', value: 130),
    WaterfallData(label: 'Expenses', value: -50),
    WaterfallData(label: 'Profit', value: 80),
  ];

  WaterfallChart({super.key});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<WaterfallData, String>> seriesList = [
      charts.Series<WaterfallData, String>(
        id: 'Waterfall',
        data: data,
        domainFn: (WaterfallData data, _) => data.label,
        measureFn: (WaterfallData data, _) => data.value,
        colorFn: (WaterfallData data, _) => data.value < 0
            ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.green.shadeDefault,
      )
    ];

    return charts.BarChart(
      seriesList,
      animate: true,
      barRendererDecorator: charts.BarLabelDecorator<String>(
        labelPosition: charts.BarLabelPosition.outside,
        labelAnchor: charts.BarLabelAnchor.end,
      ),
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 60,
          labelAnchor: charts.TickLabelAnchor.centered,
          labelJustification: charts.TickLabelJustification.outside,
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredTickCount: 5,
        ),
      ),
    );
  }
}

class WaterfallData {
  final String label;
  final double value;

  WaterfallData({required this.label, required this.value});
}
