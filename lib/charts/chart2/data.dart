import 'package:collection/collection.dart';

class ChartData {
  final double x;
  final double y;
  ChartData({required this.x, required this.y});
}

List<ChartData> get chartData1 {
  final data = <double>[10, 30, 23, 41, 581, 100];
  return data
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}

List<ChartData> get chartData2 {
  final data = <double>[];

  // get API aufrufen
  return data
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}

List<ChartData> get chartData3 {
  final data = <double>[10, 30, 23, 41, 581, 100];
  return data
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}

List<ChartData> get chartData4 {
  final data = <double>[5, 10, 13, 49, 51, 10];
  return data
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}
