// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:aktientool/authentication/services/HttpHelper.dart';
import 'package:aktientool/charts/chart13/post.dart';
import '../../env/env.dart';

var companyInfo = <Post>[];

class RemoteService {
  Future getData({required String path}) async {
    var response = await httpgethelper(path: '$path/?apikey=FMPKEY');

    if (response.statusCode == 200) {
      //print(response.body);
      var posts = postFromJson(response.body);

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
