import 'package:aktientool/charts/chart2/post.dart';
import 'package:http/http.dart' as http;

var data, costOfRevenue = <Data>[];

class RemoteService {
  getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List l = response.body.split('date');
      int lengthJson = l.length - 2;

      data = [];
      costOfRevenue = [];

      dynamic posts = postFromJson(response.body);

      while (lengthJson >= 0) {
        String years = posts[lengthJson].date.toString().substring(0, 4);
        String yearsMonth = posts[lengthJson].date.toString().substring(5, 7);
        String yearsDay = posts[lengthJson].date.toString().substring(8, 11);

        double revenueData =
            double.parse((posts[lengthJson]).revenue.toStringAsFixed(2)) / 1000;

        double costOfRevenueData =
            double.parse((posts[lengthJson]).costOfRevenue.toStringAsFixed(2)) /
                1000;

        data.add(Data(
          DateTime(
              int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
          revenueData,
          costOfRevenueData,
        ));

        lengthJson--;
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Data {
  Data(this.year, this.revenue, this.costOfRevenueData);
  final DateTime year;
  final double revenue;
  final double costOfRevenueData;
}

List get allData {
  return data
      .mapIndexed(((index, element) =>
          Data(element.year, element.revenue, element.costOfRevenueData)))
      .toList();
}



/*
class Data2 {
  Data2(this.year, this.information);
  final DateTime year;
  final double information;
}

List<Data2> get chartData2 {
  //print("---data2---");
  //print(data2[0].information);
  return data2
      .mapIndexed(
          ((index, element) => Data2(element.year, element.information)))
      .toList();
}

class Data3 {
  Data3(this.year, this.information);
  final DateTime year;
  final double information;
}

List<Data3> get chartData3 {
  //print("---data3---");
  //print(data3[0].information);

  return data3
      .mapIndexed(
          ((index, element) => Data3(element.year, element.information)))
      .toList();
}

class Data4 {
  Data4(this.year, this.information);
  final DateTime year;
  final double information;
}

List<Data4> get chartData4 {
  //print("---data4---");
  //print(data4[0].information);

  return data4
      .mapIndexed(
          ((index, element) => Data4(element.year, element.information)))
      .toList();
}
*/