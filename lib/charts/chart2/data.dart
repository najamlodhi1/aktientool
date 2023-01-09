import 'package:aktientool/charts/chart2/post.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

var data = <double>[10, 30];
var date = <String>["", ""];

class RemoteService {
  getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List l = response.body.split('open');
      int lengthJson = l.length - 2;
      data = [];
      dynamic posts = postFromJson(response.body);
      while (lengthJson >= 0) {
        data.add(posts.historical[lengthJson].open.toDouble());
        date.add(posts.historical[lengthJson].date.toString());

        lengthJson--;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class ChartData {
  final double x;
  final double y;
  ChartData({required this.x, required this.y});
}

List<ChartData> get chartData {
  return data
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}
