// ignore_for_file: file_names

import 'dart:convert';
import 'package:aktientool/authentication/services/HttpHelper.dart';
import 'package:aktientool/charts/DCFLevered/DCFLeveredModel.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';

class DCFLeveredService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<List<DCFLeveredModel>> getData() async {
    var response = await httpgethelper(
        path:
            'api/v4/upgrades-downgrades-consensus/?apikey=FMPKEY&symbol=$stock');

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
