import 'package:flutter/material.dart';
import 'IncomeReportModel.dart';

class IncomeService {
  static final ValueNotifier<String> selectedTitle =
      ValueNotifier<String>('Revenue');

  Future<List<IncomeReportModel>> getData(dynamic data) async {
    var temp = parseData(data);
    temp.sort((a, b) => a.date.year.compareTo(b.date.year));
    return temp;
  }

  List<IncomeReportModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<IncomeReportModel>((e) => IncomeReportModel.fromJson(e))
        .toList();
  }
}
