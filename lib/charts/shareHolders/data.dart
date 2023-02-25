// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:aktientool/charts/shareHolders/post.dart';
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
