import 'package:aktientool/charts/chart2/post.dart';
import 'package:http/http.dart' as http;

var data = <Data>[];

class RemoteService {
  getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List l = response.body.split('date');
      int lengthJson = l.length - 2;
      var posts = postFromJson(response.body);

      while (lengthJson >= 0) {
        String years = posts[lengthJson].date.toString().substring(0, 4);
        String yearsMonth = posts[lengthJson].date.toString().substring(5, 7);
        String yearsDay = posts[lengthJson].date.toString().substring(8, 11);

        var curDate = DateTime(
            int.parse(years), int.parse(yearsMonth), int.parse(yearsDay));

        double revenue = double.parse(posts[lengthJson].revenue.toString());

        data.add(Data(revenue, curDate));
        lengthJson--;
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Data {
  Data(this.revenue, this.year);
  final double revenue;
  final DateTime year;
}
