import 'dart:convert';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:http/http.dart' as http;

import 'ConcensusModel.dart';

class ConcensusService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<ConcensusModel?> getData() async {
    var response = await http.Client().get(Uri.parse(
        'https://financialmodelingprep.com/api/v4/upgrades-downgrades-consensus?symbol=$stock&apikey=${Env.fmpKey}'));

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
