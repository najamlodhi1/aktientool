// ignore_for_file: depend_on_referenced_packages

import 'package:aktientool/charts/chart11/post.dart';
import 'package:collection/collection.dart';

var companyInfo = <CompanyInfo>[];

class RemoteService {
  getData(dynamic data) async {
    var posts = postFromJson(data);

    companyInfo.clear();
    companyInfo.add(CompanyInfo(
      posts[0].the1D.toStringAsFixed(2),
      posts[0].the5D.toStringAsFixed(2),
      posts[0].the1M.toStringAsFixed(2),
      posts[0].the3M.toStringAsFixed(2),
      posts[0].the6M.toStringAsFixed(2),
      posts[0].the1Y.toStringAsFixed(2),
      posts[0].the3Y.toStringAsFixed(2),
      posts[0].the5Y.toStringAsFixed(2),
      posts[0].the10Y.toStringAsFixed(2),
      posts[0].max.toStringAsFixed(2),
    ));

    return companyInfo;
  }
}

class CompanyInfo {
  CompanyInfo(this.the1D, this.the5D, this.the1M, this.the3M, this.the6M,
      this.the1Y, this.the3Y, this.the5Y, this.the10Y, this.max);

  final String the1D;
  final String the5D;
  final String the1M;
  final String the3M;
  final String the6M;
  final String the1Y;
  final String the3Y;
  final String the5Y;
  final String the10Y;
  final String max;
}

List get companyData {
  return companyInfo
      .mapIndexed((index, element) => CompanyInfo(
            element.the1D,
            element.the5D,
            element.the1M,
            element.the3M,
            element.the6M,
            element.the1Y,
            element.the3Y,
            element.the5Y,
            element.the10Y,
            element.max,
          ))
      .toList();
}
