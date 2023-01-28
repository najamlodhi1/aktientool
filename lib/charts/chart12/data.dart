// ignore_for_file: depend_on_referenced_packages

import 'package:aktientool/charts/chart12/post.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

var companyInfo = <CompanyInfo>[];

class RemoteService {
  getData(String url) async {
    //print("rein: $url");

    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      //print(response.body);
      var posts = postFromJson(response.body);

      companyInfo.clear();

      companyInfo.add(CompanyInfo(
        posts.historical[0].declarationDate,
        posts.historical[0].recordDate,
        posts.historical[0].paymentDate,
        posts.historical[0].dividend.toString(),
      ));

      return companyInfo;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class CompanyInfo {
  CompanyInfo(
      this.declarationDate, this.recordDate, this.paymentDate, this.dividend);

  final String declarationDate;
  final String recordDate;
  final String paymentDate;
  final String dividend;
}

List get companyData {
  return companyInfo
      .mapIndexed((index, element) => CompanyInfo(
            element.declarationDate,
            element.recordDate,
            element.paymentDate,
            element.dividend,
          ))
      .toList();
}
