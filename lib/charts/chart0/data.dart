// ignore_for_file: depend_on_referenced_packages

import 'package:aktientool/charts/chart0/post.dart';
import 'package:collection/collection.dart';
import 'package:translator/translator.dart';

import '../../main.dart';

var companyInfo = <CompanyInfo>[];
var currencNow;

class RemoteService {
  Future<CompanyInfo> getData({required dynamic data}) async {
    var translator = GoogleTranslator();

    var posts = postFromJson(data);

    currencNow = posts[0].currency;

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
        posts[0].isin ?? "",
        posts[0].beta.toString(),
        posts[0].price.toString(),
        "${(posts[0].lastDiv / posts[0].price * 100).toStringAsFixed(2)} % ",
        //posts[0].lastDiv.toString(),
        posts[0].currency.toString(),
        posts[0].changes.toString(),
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
      this.isin,
      this.beta,
      this.price,
      this.lastDiv,
      this.currency,
      this.changes,
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
  final String isin;
  final String beta;
  final String price;
  final String lastDiv;
  final String currency;
  final String changes;
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
          element.isin,
          element.beta,
          element.price,
          element.lastDiv,
          element.currency,
          element.changes,
          element.state))
      .toList();
}
