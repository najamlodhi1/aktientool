// ignore_for_file: file_names

import 'dart:convert';
import 'package:aktientool/authentication/services/HttpHelper.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'StockNewsModel.dart';

class StockNewsService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<List<StockNewsModel>> getData() async {
    var response = await httpgethelper(
        path: 'api/v3/stock_news/?apikey=FMPKEY&limit=20&tickers=$stock');

    if (response.statusCode == 200) {
      List<StockNewsModel> temp = parseData(response.body);
      return temp;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<StockNewsModel> parseData(String res) {
    final parsed = jsonDecode(res).cast<Map<String, dynamic>>();
    return parsed
        .map<StockNewsModel>((e) => StockNewsModel.fromJson(e))
        .toList();
  }
}
