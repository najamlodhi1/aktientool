import 'package:flutter/material.dart';
import 'BalanceReportModel.dart';

class BalanceService {
  static final ValueNotifier<String> selectedTitle =
      ValueNotifier<String>('Total assets');

  Future<List<BalanceReportModel>> getData(dynamic data) async {
    var temp = parseData(data);
    temp.sort((a, b) => a.date.year.compareTo(b.date.year));
    return temp;
  }

  List<BalanceReportModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<BalanceReportModel>((e) => BalanceReportModel.fromJson(e))
        .toList();
  }
}
