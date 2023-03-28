import 'dart:convert';

import 'package:aktientool/authentication/services/http_service.dart';
import 'package:aktientool/charts/chart13/post.dart';
import 'package:http/http.dart' as http;

var companyInfo = <Post>[];

class RemoteService {
  Future<List<Post>> getData(dynamic data) async {
    var temp = data;
    if (data == null) {
      var res = await http.get(
          Uri(scheme: scheme, host: baseurl, path: 'Interceptor/ipo_calendar'),
          headers: {'Content-Type': 'application/json', 'Accept': '*/*'});
      temp = jsonDecode(res.body);
    }

    var posts = postFromJson(temp);

    companyInfo.clear();
    companyInfo = posts;

    if (companyInfo.isEmpty) {
      return [];
    } else {
      return Future.value(companyInfo);
    }
  }
}

List get companyData {
  return companyInfo;
}
