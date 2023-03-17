// ignore_for_file: file_names

import 'dart:convert';
import 'package:aktientool/authentication/services/HttpHelper.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'CompanyModel.dart';

class CompanyService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<List<DividendModel>> getData() async {
    var response = await httpgethelper(
        path:
            'api/v3/historical-price-full/stock_dividend/$stock/?apikey=FMPKEY');

    if (response.statusCode == 200) {
      List<DividendModel> temp = parseData(response.body);
      temp.removeWhere((element) =>
          element.recordDate == "" ||
          element.declarationDate == "" ||
          element.paymentDate == "");
      return temp;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<DividendModel> parseData(String res) {
    final parsed = jsonDecode(res)["historical"].cast<Map<String, dynamic>>();
    return parsed.map<DividendModel>((e) => DividendModel.fromJson(e)).toList();
  }
}
