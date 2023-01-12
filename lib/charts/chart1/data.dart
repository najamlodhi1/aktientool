import 'package:aktientool/charts/chart2/post.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

var data = <ChartData>[];
var data2 = <SalesData>[];

class RemoteService {
  getData(String url) async {
    int count = 0;
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List l = response.body.split('open');
      int lengthJson = l.length - 2;
      print("lengthJson: $lengthJson");

      data = [];
      data2 = [];
      dynamic posts = postFromJson(response.body);
      while (lengthJson >= 0) {
        String years =
            posts.historical[lengthJson].date.toString().substring(0, 4);
        String yearsMonth =
            posts.historical[lengthJson].date.toString().substring(5, 7);
        //print("yearsMonth $yearsMonth");
        String yearsDay =
            posts.historical[lengthJson].date.toString().substring(8, 11);
        //print("yearsDay $yearsDay");

        double prices =
            double.parse(posts.historical[lengthJson].open.toStringAsFixed(2));

        //date.add(dates);

        data.add(ChartData(
          count,
          prices,
        ));

        // ChartData(DateTime(2015, 5, 1), 35),

        data2.add(SalesData(
            DateTime(
                int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
            prices));

        count++;
        lengthJson--;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class ChartData {
  ChartData(this.year, this.price);
  final int year;
  final double price;
}

List<ChartData> get chartData {
  return data
      .mapIndexed(((index, element) => ChartData(element.year, element.price)))
      .toList();
}

class SalesData {
  SalesData(this.year, this.price);
  final DateTime year;
  final double price;
}

List<SalesData> get chartData2 {
  //print("---Hier---");
  //print(data2[0].year);
  //print(data2[0].price);

  // ChartData(DateTime(2015, 5, 1), 35),

  return data2
      .mapIndexed(((index, element) => SalesData(element.year, element.price)))
      .toList();
}
