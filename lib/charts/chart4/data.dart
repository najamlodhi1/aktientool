import 'package:aktientool/charts/chart4/post.dart';
import 'package:http/http.dart' as http;

var data, netIncome = <Data>[];

class RemoteService {
  getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List l = response.body.split('date');
      int lengthJson = l.length - 2;
      //print("lengthJson: $lengthJson");

      data = [];
      netIncome = [];

      dynamic posts = postFromJson(response.body);

      while (lengthJson >= 0) {
        String years = posts[lengthJson].date.toString().substring(0, 4);
        String yearsMonth = posts[lengthJson].date.toString().substring(5, 7);
        String yearsDay = posts[lengthJson].date.toString().substring(8, 11);

        double operatingCashFlow = double.parse(
            (posts[lengthJson]).operatingCashFlow.toStringAsFixed(2));

        double netIncome =
            double.parse((posts[lengthJson]).netIncome.toStringAsFixed(2));

        data.add(Data(
          DateTime(
              int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
          operatingCashFlow,
          netIncome,
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
  Data(this.year, this.operatingCashFlow, this.netIncome);
  final DateTime year;
  final double operatingCashFlow;
  final double netIncome;
}

List get allData {
  return data
      .mapIndexed(((index, element) =>
          Data(element.year, element.operatingCashFlow, element.netIncome)))
      .toList();
}
