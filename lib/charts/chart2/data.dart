import 'dart:convert';
import 'package:flutter/material.dart';
import '../../authentication/services/HttpHelper.dart';
import '../../env/env.dart';
import '../chart3/data.dart';
import 'IncomeReportModel.dart';

class IncomeService {
  static final ValueNotifier<Map<String, bool>> isSelected =
      ValueNotifier<Map<String, bool>>({});
  static List<Color> colors = [Colors.green, Colors.red];
  Future<List<IncomeReportModel>> getData(String path) async {
    var response = await httpgethelper(path: '$path/?apikey=FMPKEY&limit=20');

    if (response.statusCode == 200) {
      var temp = parseData(response.body);
      isSelected.value = {};

      for (ReportItemModel element in temp[0].reports) {
        isSelected.value[element.title] =
            element.title == 'Revenue' ? true : false;
      }

      temp.sort((a, b) => a.date.year.compareTo(b.date.year));
      colors.addAll(generateRandomColors(count: temp[0].reports.length - 2));
      return temp;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<IncomeReportModel> parseData(String res) {
    final parsed = jsonDecode(res).cast<Map<String, dynamic>>();
    return parsed
        .map<IncomeReportModel>((e) => IncomeReportModel.fromJson(e))
        .toList();
  }
}
