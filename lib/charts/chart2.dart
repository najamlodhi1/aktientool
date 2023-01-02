import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart2 extends StatefulWidget {
  final List<StockData> data;

  const Chart2({super.key, required this.data});

  @override
  _Chart2State createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
  final double _zoomFactor = 1.0;
  final double _panFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: <LineSeries<StockData, String>>[
          LineSeries<StockData, String>(
            dataSource: widget.data,
            xValueMapper: (StockData data, _) => data.year,
            yValueMapper: (StockData data, _) => data.price,
          ),
        ],
      ),
    );
  }
}

class StockData {
  final String year;
  final double price;

  const StockData(this.year, this.price);
}
