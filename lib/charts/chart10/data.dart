import 'package:aktientool/charts/chart10/post.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

var data1 = <Data1>[];
var data2 = <Data2>[];
var data3 = <Data3>[];
var data4 = <Data4>[];

class RemoteService {
  getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List l = response.body.split('year');
      int lengthJson = l.length - 2;
      data1 = [];
      data2 = [];
      data3 = [];
      data4 = [];

      dynamic posts = postFromJson(response.body);

      //print(posts[0].revenue.toString());

      while (lengthJson > 0) {
        String years = posts[lengthJson].year.toString();

        double revenue =
            double.parse((posts[lengthJson]).revenue.toStringAsFixed(2));

        data1.add(Data1(DateTime(int.parse(years)), revenue));

        lengthJson--;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Data1 {
  Data1(this.year, this.information);
  final DateTime year;
  final double information;
}

List<Data1> get chartData1 {
  return data1
      .mapIndexed(
          ((index, element) => Data1(element.year, element.information)))
      .toList();
}

class Data2 {
  Data2(this.year, this.information);
  final DateTime year;
  final double information;
}

List<Data2> get chartData2 {
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
  return data4
      .mapIndexed(
          ((index, element) => Data4(element.year, element.information)))
      .toList();
}
