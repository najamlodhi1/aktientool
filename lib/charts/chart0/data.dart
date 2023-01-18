import 'package:aktientool/charts/chart0/post.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

var data = <CompanyInfo>[];

class RemoteService {
  getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      dynamic posts = postFromJson(response.body);

      /*
      var posts = postFromJson(response.body)?.toList(growable: false);
      print("1");

      print(posts.toString());
      print("2");

      print(posts);
      return posts;
      */
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class CompanyInfo {
  CompanyInfo(this.year, this.price);
  final int year;
  final double price;
}

List<CompanyInfo> get chartData {
  return data
      .mapIndexed(
          ((index, element) => CompanyInfo(element.year, element.price)))
      .toList();
}
