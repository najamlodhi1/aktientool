import 'package:aktientool/charts/chart1test/post.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

var data = <ChartData>[];
var data1 = <ChartData>[];
var data3 = <ChartData>[];
var data5 = <ChartData>[];
var data10 = <ChartData>[];
var dataMax = <ChartData>[];

class RemoteService {
  getData(String url) async {
    int count = 0;

    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    DateTime date_1year = DateTime(now.year - 1, now.month, now.day);
    DateTime date_3year = DateTime(now.year - 3, now.month, now.day);
    DateTime date_5year = DateTime(now.year - 5, now.month, now.day);
    DateTime date_10year = DateTime(now.year - 10, now.month, now.day);

    var response = await http.Client().get(Uri.parse(url));
    //print("date $currentDate");
    //print("newDate $newDate");

    if (response.statusCode == 200) {
      //print(response.body);
      final List l = response.body.split('date');
      int lengthJson = l.length - 2;
      //print("lengthJson: $lengthJson");

      dataMax = [];
      data10 = [];
      data1 = [];

      dynamic posts = postFromJson(response.body);
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

        dataMax.add(ChartData(
            DateTime(
                int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
            stockValue));

        if (int.parse(years) >= date_1year.year &&
            int.parse(yearsMonth) >= date_1year.month) {
          //print("$years-$yearsMonth-$yearsDay");
          data1.add(ChartData(
              DateTime(
                  int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
              stockValue));
        }

        if (int.parse(years) >= date_3year.year &&
            int.parse(yearsMonth) >= date_3year.month) {
          //print("$years-$yearsMonth-$yearsDay");
          data3.add(ChartData(
              DateTime(
                  int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
              stockValue));
        }
        if (int.parse(years) >= date_5year.year &&
            int.parse(yearsMonth) >= date_5year.month) {
          //print("$years-$yearsMonth-$yearsDay");
          data5.add(ChartData(
              DateTime(
                  int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
              stockValue));
        }
        if (int.parse(years) >= date_10year.year &&
            int.parse(yearsMonth) >= date_10year.month) {
          //print("$years-$yearsMonth-$yearsDay");
          data10.add(ChartData(
              DateTime(
                  int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
              stockValue));
        }

        count++;
        lengthJson--;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class ChartData1 {
  ChartData1(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData1 {
  return data1
      .mapIndexed(((index, element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartData3 {
  ChartData3(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData3 {
  return data3
      .mapIndexed(((index, element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartData5 {
  ChartData5(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData5 {
  return data5
      .mapIndexed(((index, element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartData10 {
  ChartData10(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData10 {
  return data10
      .mapIndexed(((index, element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartDataMax {
  ChartDataMax(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartDataMax {
  return dataMax
      .mapIndexed(((index, element) => ChartData(element.year, element.data)))
      .toList();
}

class ChartData {
  ChartData(this.year, this.data);
  final DateTime year;
  final double data;
}

List<ChartData> get chartData {
  return data
      .mapIndexed(((index, element) => ChartData(element.year, element.data)))
      .toList();
}
