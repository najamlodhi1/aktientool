import 'package:aktientool/charts/chart1test/post.dart';
import 'package:fl_chart/fl_chart.dart';

var data = <ChartData>[];
var data1 = <ChartData>[];
var data3 = <ChartData>[];
var data5 = <ChartData>[];
var data10 = <ChartData>[];
var dataMax = <ChartData>[];
List<FlSpot> points = [];

var fldata1 = <FlSpot>[];
var fldata3 = <FlSpot>[];
var fldata5 = <FlSpot>[];
var fldata10 = <FlSpot>[];
var fldataMax = <FlSpot>[];

class RemoteService {
  getData(dynamic results) async {
    DateTime now = DateTime.now();
    DateTime date_1year = DateTime(now.year - 1, now.month, now.day);
    DateTime date_3year = DateTime(now.year - 3, now.month, now.day);
    DateTime date_5year = DateTime(now.year - 5, now.month, now.day);
    DateTime date_10year = DateTime(now.year - 10, now.month, now.day);
    int lengthJson = results["historical"].length - 1;

    int count = 0;

    dataMax = [];
    data10 = [];
    data1 = [];
    data3 = [];
    data5 = [];
    points = [];

    fldataMax = [];
    fldata10 = [];
    fldata1 = [];
    fldata3 = [];
    fldata5 = [];

    Post posts = postFromJson(results);
    while (lengthJson >= 0) {
      //print(posts.historical[lengthJson].date.toString());

      String years =
          posts.historical[lengthJson].date.toString().substring(0, 4);
      //print("years $years");

      String yearsMonth =
          posts.historical[lengthJson].date.toString().substring(5, 7);
      //print("yearsMonth $yearsMonth");
      String yearsDay =
          posts.historical[lengthJson].date.toString().substring(8, 11);
      //print("yearsDay $yearsDay");

      double stockValue =
          double.parse(posts.historical[lengthJson].close.toStringAsFixed(2));

      DateTime dtStockDate = DateTime(
          int.parse(years), int.parse(yearsMonth), int.parse(yearsDay));

      dataMax.add(ChartData(dtStockDate, stockValue));

      flchartDataMax.add(FlSpot(count as double, stockValue));
      //points.add(FlSpot(count as double, stockValue));

      if (dtStockDate.compareTo(date_1year) >= 0) {
        //print("$years-$yearsMonth-$yearsDay");
        data1.add(ChartData(dtStockDate, stockValue));
        fldata1.add(FlSpot(count as double, stockValue));
        //points.add(FlSpot(count as double, stockValue));
        print("val1");
      }

      if (dtStockDate.compareTo(date_3year) >= 0) {
        //print("$years-$yearsMonth-$yearsDay");
        data3.add(ChartData(dtStockDate, stockValue));
        //points.add(FlSpot(count as double, stockValue));
        fldata3.add(FlSpot(count as double, stockValue));
        print("val3");
      }
      if (dtStockDate.compareTo(date_5year) >= 0) {
        //print("$years-$yearsMonth-$yearsDay");
        data5.add(ChartData(dtStockDate, stockValue));
        //points.add(FlSpot(count as double, stockValue));
        fldata5.add(FlSpot(count as double, stockValue));
      }
      if (dtStockDate.compareTo(date_10year) >= 0) {
        //print("$years-$yearsMonth-$yearsDay");
        data10.add(ChartData(dtStockDate, stockValue));
        //points.add(FlSpot(count as double, stockValue));
        fldata10.add(FlSpot(count as double, stockValue));
      }
      count++;
      lengthJson--;
    }
    return points;
  }
}

class FLChartData1 {
  FLChartData1(this.data, this.numb);
  final double numb;
  final double data;
}

List<FlSpot> get flchartData1 {
  return fldata1;
}

class FLChartData3 {
  FLChartData3(this.data, this.numb);
  final double numb;
  final double data;
}

List<FlSpot> get flchartData3 {
  return fldata3;
}

class FLChartData5 {
  FLChartData5(this.data, this.numb);
  final double numb;
  final double data;
}

List<FlSpot> get flchartData5 {
  return fldata5;
}

class FLChartData10 {
  FLChartData10(this.data, this.numb);
  final double numb;
  final double data;
}

List<FlSpot> get flchartData10 {
  return fldata10;
}

class FLChartDataMax {
  FLChartDataMax(this.data, this.numb);
  final double numb;
  final double data;
}

List<FlSpot> get flchartDataMax {
  return fldataMax;
}

class ChartData1 {
  ChartData1(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData1 {
  return data1
      .map(((element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartData3 {
  ChartData3(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData3 {
  return data3
      .map(((element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartData5 {
  ChartData5(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData5 {
  return data5
      .map(((element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartData10 {
  ChartData10(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData10 {
  return data10
      .map(((element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartDataMax {
  ChartDataMax(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartDataMax {
  return dataMax
      .map(((element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartData {
  ChartData(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData {
  return data
      .map(((element) => ChartData(element.year, element.data)))
      .toList();
}
