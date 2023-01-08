import 'dart:convert';

import 'package:aktientool/charts/chart1/models/assets/assets.dart';
import 'package:flutter/services.dart';

class NetworkManager {
  static final NetworkManager _singleton = NetworkManager._();

  static NetworkManager get instance => _singleton;

  NetworkManager._();

  Future<Assets> getAssets() async {
    final data = await rootBundle.loadString('data/assets.json');

    final assets = Assets.fromJson(json.decode(data));

    return assets;
  }
}
