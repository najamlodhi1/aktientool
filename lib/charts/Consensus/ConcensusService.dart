// ignore_for_file: file_names

import 'dart:convert';
import 'package:aktientool/authentication/services/HttpHelper.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'ConcensusModel.dart';

class ConcensusService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<ConcensusModel?> getData() async {
    var response = await httpgethelper(
        path:
            'api/v4/upgrades-downgrades-consensus/?apikey=FMPKEY&symbol=$stock');

    if (response.statusCode == 200) {
      List<ConcensusModel> temp = parseData(response.body);
      return temp.isNotEmpty ? temp[0] : null;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<ConcensusModel> parseData(String res) {
    final parsed = jsonDecode(res).cast<Map<String, dynamic>>();
    return parsed
        .map<ConcensusModel>((e) => ConcensusModel.fromJson(e))
        .toList();
  }
}
