import 'package:aktientool/charts/chart3/post.dart';
import 'package:http/http.dart' as http;

var data, cashAndShortTermInvestments = <Data>[];

class RemoteService {
  getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List l = response.body.split('date');
      int lengthJson = l.length - 2;
      //print("lengthJson: $lengthJson");

      data = [];
      cashAndShortTermInvestments = [];

      dynamic posts = postFromJson(response.body);

      while (lengthJson >= 0) {
        String years = posts[lengthJson].date.toString().substring(0, 4);
        String yearsMonth = posts[lengthJson].date.toString().substring(5, 7);
        String yearsDay = posts[lengthJson].date.toString().substring(8, 11);

        double goodwill =
            double.parse((posts[lengthJson]).goodwill.toStringAsFixed(2));

        double cashAndShortTermInvestments = double.parse(
            (posts[lengthJson]).cashAndShortTermInvestments.toStringAsFixed(2));

        data.add(Data(
          DateTime(
              int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
          goodwill,
          cashAndShortTermInvestments,
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
  Data(this.year, this.goodwill, this.cashAndShortTermInvestments);
  final DateTime year;
  final double goodwill;
  final double cashAndShortTermInvestments;
}

List get allData {
  return data
      .mapIndexed(((index, element) => Data(
          element.year, element.goodwill, element.cashAndShortTermInvestments)))
      .toList();
}
