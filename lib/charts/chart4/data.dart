import 'package:aktientool/charts/chart4/post.dart';
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
      final List l = response.body.split('date');
      int lengthJson = l.length - 2;
      //print("lengthJson: $lengthJson");

      data1 = [];
      data2 = [];
      data3 = [];
      data4 = [];

      dynamic posts = postFromJson(response.body);

      //print(posts[0].goodwill.toString());

      while (lengthJson >= 0) {
        String years = posts[lengthJson].date.toString().substring(0, 4);
        String yearsMonth = posts[lengthJson].date.toString().substring(5, 7);
        String yearsDay = posts[lengthJson].date.toString().substring(8, 11);

        double freeCashFlow =
            double.parse((posts[lengthJson]).freeCashFlow.toStringAsFixed(2));

        double dividendsPaid =
            double.parse((posts[lengthJson]).dividendsPaid.toStringAsFixed(2));

        double tilgungskraft = freeCashFlow + dividendsPaid;

        data1.add(Data1(
            DateTime(
                int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
            freeCashFlow / 1000000000));

        data2.add(Data2(
            DateTime(
                int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
            dividendsPaid / 1000000000));

        data3.add(Data3(
            DateTime(
                int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
            tilgungskraft / 1000000000));

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
  print("---data1---");
  //print(data1[0].information);
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
  print("---data2---");
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
  print("---data3---");
  print(data3[0].information);

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
  print("---data4---");
  print(data4[0].information);

  return data4
      .mapIndexed(
          ((index, element) => Data4(element.year, element.information)))
      .toList();
}
