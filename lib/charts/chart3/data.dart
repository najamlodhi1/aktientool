import 'dart:math';
import 'package:flutter/material.dart';
import '../chart2/IncomeReportModel.dart';
import 'BalanceReportModel.dart';

class BalanceService {
  static final ValueNotifier<Map<String, bool>> isSelected =
      ValueNotifier<Map<String, bool>>({});
  static List<Color> colors = [Colors.green, Colors.red];
  Future<List<BalanceReportModel>> getData(dynamic data) async {
    var temp = parseData(data);
    isSelected.value = {};

    for (ReportItemModel element in temp[0].reports) {
      isSelected.value[element.title] =
          element.title == 'Total assets' ? true : false;
    }

    temp.sort((a, b) => a.date.year.compareTo(b.date.year));
    colors.addAll(generateRandomColors(count: temp[0].reports.length - 2));
    return temp;
  }

  List<BalanceReportModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<BalanceReportModel>((e) => BalanceReportModel.fromJson(e))
        .toList();
  }
}

List<Color> generateRandomColors({required int count}) {
  final Random random = Random();
  List<Color> colors = [];
  for (int i = 0; i < count; i++) {
    colors.add(Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    ));
  }
  return colors;
}
