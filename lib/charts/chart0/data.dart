// ignore_for_file: depend_on_referenced_packages

import 'package:aktientool/charts/chart0/post.dart';
import 'package:collection/collection.dart';
import 'package:translator/translator.dart';

import '../../main.dart';

var companyInfo = <CompanyInfo>[];

class RemoteService {
  Future<CompanyInfo> getData({required dynamic data}) async {
    var translator = GoogleTranslator();

    var posts = postFromJson(data);

    String x = posts[0].description ?? "";

    String translatedDescription = x;

    if (x.isNotEmpty && selectedLocale.languageCode == 'de') {
      translatedDescription =
          await translator.translate(x, to: 'de').then((value) => value.text);
    }

    companyInfo.clear();
    companyInfo.add(CompanyInfo(
        posts[0].image,
        posts[0].companyName,
        posts[0].symbol,
        "${(posts[0].mktCap / 1000000000).toStringAsFixed(2)} Billion ",
        posts[0].exchangeShortName,
        posts[0].sector,
        posts[0].industry ?? "",
        posts[0].website ?? "",
        translatedDescription,
        posts[0].fullTimeEmployees ?? "",
        posts[0].ipoDate.toString().replaceAll("00:00:00.000", ""),
        posts[0].ceo,
        posts[0].city ?? "",
        posts[0].state ?? ""));

    return companyInfo[0];
  }
}

class CompanyInfo {
  CompanyInfo(
      this.image,
      this.companyName,
      this.symbol,
      this.mktCap,
      this.exchangeShortName,
      this.sector,
      this.industry,
      this.website,
      this.description,
      this.fullTimeEmployees,
      this.ipoDate,
      this.ceo,
      this.city,
      this.state);

  final String image;
  final String companyName;
  final String symbol;
  final String mktCap;
  final String exchangeShortName;
  final String sector;
  final String industry;
  final String website;
  final String description;
  final String fullTimeEmployees;
  final String ipoDate;
  final String ceo;
  final String city;
  final String state;
}

List get companyData {
  return companyInfo
      .mapIndexed((index, element) => CompanyInfo(
          element.image,
          element.companyName,
          element.symbol,
          element.mktCap,
          element.exchangeShortName,
          element.sector,
          element.industry,
          element.website,
          element.description,
          element.fullTimeEmployees,
          element.ipoDate,
          element.ceo,
          element.city,
          element.state))
      .toList();
}
