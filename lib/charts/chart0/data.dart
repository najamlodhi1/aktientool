import 'package:aktientool/charts/chart0/post.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

var companyInfo = <CompanyInfo>[];

class RemoteService {
  Future<dynamic> getData(String url) async {
    var response = await http.Client().get(Uri.parse(url));
    if (response.statusCode == 200) {
      //print(response.body);
      var posts = postFromJson(response.body);

      companyInfo.add(CompanyInfo(
          posts[0].image,
          posts[0].companyName,
          posts[0].symbol,
          posts[0].mktCap.toString(),
          posts[0].exchangeShortName,
          posts[0].sector,
          posts[0].industry,
          posts[0].website,
          posts[0].description,
          posts[0].fullTimeEmployees,
          posts[0].ipoDate.toString(),
          posts[0].ceo));

      return companyInfo;
    } else {
      throw Exception('Failed to load data');
    }
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
      this.ceo);

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
          element.ceo))
      .toList();
}
