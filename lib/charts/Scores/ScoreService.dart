// ignore_for_file: file_names

import 'dart:convert';
import 'package:aktientool/charts/Scores/ScoreModel.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import '../../authentication/services/HttpHelper.dart';

class ScoreService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<ScoreModel> getData() async {
    var response =
        await httpgethelper(path: 'api/v4/score/?apikey=FMPKEY&symbol=$stock');

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
