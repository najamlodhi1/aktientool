// ignore_for_file: file_names

import 'dart:convert';
import 'package:aktientool/charts/Scores/ScoreModel.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:http/http.dart' as http;

class ScoreService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<ScoreModel> getData() async {
    var response = await http.Client().get(Uri.parse(
        'https://financialmodelingprep.com/api/v4/score?symbol=$stock&apikey=${Env.fmpKey}'));

    if (response.statusCode == 200) {
      List<ScoreModel> temp = parseData(response.body);
      return temp[0];
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<ScoreModel> parseData(String res) {
    final parsed = jsonDecode(res).cast<Map<String, dynamic>>();
    return parsed.map<ScoreModel>((e) => ScoreModel.fromJson(e)).toList();
  }
}
