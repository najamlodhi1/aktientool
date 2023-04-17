import 'package:flutter/material.dart';
import '../../models/ESGScoreModel.dart';

class ESGScoreService {
  static List<Color> colors = [Colors.green, Colors.red];
  Future<List<ESGScoreModel>> getData(dynamic data) async {
    var temp = parseData(data);

    temp.sort((a, b) => b.date.compareTo(a.date));
    return temp;
  }

  List<ESGScoreModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed.map<ESGScoreModel>((e) => ESGScoreModel.fromJson(e)).toList();
  }
}
