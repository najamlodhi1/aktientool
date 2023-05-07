import 'package:flutter/material.dart';
import 'CashFlowReportModel.dart';

class CashFlowService {
  static final ValueNotifier<String> selectedTitle =
      ValueNotifier<String>('Operating Cash Flow');

  Future<List<CashFlowReportModel>> getData(dynamic data) async {
    var temp = parseData(data);
    temp.sort((a, b) => a.date.year.compareTo(b.date.year));
    return temp;
  }

  List<CashFlowReportModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<CashFlowReportModel>((e) => CashFlowReportModel.fromJson(e))
        .toList();
  }
}
