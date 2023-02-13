// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:aktientool/charts/chart13/post.dart';
import 'package:http/http.dart' as http;

var companyInfo = <Post>[];

class RemoteService {
  getData(String url) async {
    log('get data is calleed');
    //print("rein: $url");

    var response = await http.Client().get(Uri.parse(url));
    log('api reponse is : ${response.body}');
    if (response.statusCode == 200) {
      //print(response.body);
      var posts = postFromJson(response.body);
      log('api reponse is : ${response.body}');

      companyInfo.clear();
      companyInfo = posts;

      if (companyInfo.isEmpty) {
        return null;
      } else {
        return companyInfo;
      }
    } else {
      log('exceeption :');
      throw Exception('Failed to load data');
    }
  }
}

List get companyData {
  return companyInfo;
}
