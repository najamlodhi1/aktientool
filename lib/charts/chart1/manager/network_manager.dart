import 'dart:convert';

import 'package:aktientool/charts/chart1/models/assets/assets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  static final NetworkManager _singleton = NetworkManager._();

  static NetworkManager get instance => _singleton;

  NetworkManager._();

  Future<Assets> getAssets() async {
    final data = await rootBundle.loadString('data/assets.json');

    final assets = Assets.fromJson(json.decode(data));

    return assets;
  }

  Future<Map<String, dynamic>> getData(String symbol) async {
    final response = await http.get(Uri.parse(
        "https://financialmodelingprep.com/api/v3/historical-price-full/$symbol?from=2022-12-28&apikey=9ad9c8dfa54c11aff6c1489d109e87b6"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to retrieve data");
    }
  }
}
