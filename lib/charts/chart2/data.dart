import 'package:aktientool/charts/chart2/post.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

var data1 = <double>[10, 30];
var data2 = <double>[10, 30];
var data3 = <double>[10, 30];
var data4 = <double>[10, 30];
int lengthJson = 0;

class RemoteService {
  getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      final List l = json.split('date');
      lengthJson = l.length;
      print(lengthJson);

      return postFromJson(json);
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

List<ChartData> get chartData1 {
  return data1
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}

List<ChartData> get chartData2 {
  return data2
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}

List<ChartData> get chartData3 {
  return data3
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}

List<ChartData> get chartData4 {
  return data4
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}
