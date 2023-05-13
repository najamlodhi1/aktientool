import 'dart:math';
import 'package:flutter/material.dart';
import 'IncomeReportModel.dart';

class IncomeService {
  static final ValueNotifier<Map<String, bool>> isSelected =
      ValueNotifier<Map<String, bool>>({});
  static List<Color> colors = [Colors.green, Colors.red];
  Future<List<IncomeReportModel>> getData(dynamic data) async {
    var temp = parseData(data);
    isSelected.value = {};

    for (ReportItemModel element in temp[0].reports) {
      isSelected.value[element.title] = element.title == 'Revenue' ||
              element.title == 'Operating Income' ||
              element.title == 'Net Income'
          ? true
          : false;
    }

    temp.sort((a, b) => a.date.year.compareTo(b.date.year));
    colors.addAll(generateRandomColors(count: temp[0].reports.length - 2));
    return temp;
  }

  List<IncomeReportModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<IncomeReportModel>((e) => IncomeReportModel.fromJson(e))
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
