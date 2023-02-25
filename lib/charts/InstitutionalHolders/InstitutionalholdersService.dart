// ignore_for_file: file_names

import 'dart:convert';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:http/http.dart' as http;

import 'InstitutionalholdersModel.dart';

class InstitutionalholdersService {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<List<InstitutionalholdersModel>> getData() async {
    var response = await http.Client().get(Uri.parse(
        'https://financialmodelingprep.com/api/v3/institutional-holder/$stock?apikey=${Env.fmpKey}'));

    if (response.statusCode == 200) {
      List<InstitutionalholdersModel> temp = parseData(response.body);
      return temp;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<InstitutionalholdersModel> parseData(String res) {
    final parsed = jsonDecode(res).cast<Map<String, dynamic>>();
    return parsed
        .map<InstitutionalholdersModel>(
            (e) => InstitutionalholdersModel.fromJson(e))
        .toList();
  }
}
