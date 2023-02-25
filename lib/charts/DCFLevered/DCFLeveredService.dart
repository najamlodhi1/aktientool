// ignore_for_file: file_names

import 'dart:convert';
import 'package:aktientool/charts/DCFLevered/DCFLeveredModel.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:http/http.dart' as http;

class DCFLeveredService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<List<DCFLeveredModel>> getData() async {
    var response = await http.Client().get(Uri.parse(
        'https://financialmodelingprep.com/api/v4/advanced_levered_discounted_cash_flow?symbol=$stock&apikey=${Env.fmpKey}'));

    if (response.statusCode == 200) {
      List<DCFLeveredModel> temp = parseData(response.body);

      temp.sort((a, b) => a.year.compareTo(b.year));
      temp.removeAt(0);
      return temp;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<DCFLeveredModel> parseData(String res) {
    final parsed = jsonDecode(res).cast<Map<String, dynamic>>();
    return parsed
        .map<DCFLeveredModel>((e) => DCFLeveredModel.fromJson(e))
        .toList();
  }
}
