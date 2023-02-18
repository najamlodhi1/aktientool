import 'dart:convert';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:http/http.dart' as http;
import 'StockNewsModel.dart';

class StockNewsService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<List<StockNewsModel>> getData() async {
    var response = await http.Client().get(Uri.parse(
        'https://financialmodelingprep.com/api/v3/stock_news?tickers=$stock&limit=20&apikey=${Env.fmpKey}'));

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
