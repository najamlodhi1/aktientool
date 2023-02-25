// ignore_for_file: file_names

import 'package:intl/intl.dart';
import '../chart2/IncomeReportModel.dart';

class BalanceReportModel {
  final DateTime date;
  List<ReportItemModel> reports;

  BalanceReportModel({required this.date, required this.reports});

  factory BalanceReportModel.fromJson(Map<String, dynamic> json) =>
      BalanceReportModel(
          date: DateFormat('yyyy-MM-dd').parse(json['date']),
          reports: [
            ReportItemModel(title: 'Total assets', value: json['totalAssets']),
            ReportItemModel(
                title: 'Total Current Assets',
                value: json['totalCurrentAssets']),
            ReportItemModel(
                title: 'Cash and Short Term Investments',
                value: json['cashAndShortTermInvestments']),
            ReportItemModel(
                title: 'Cash and cash equivalents',
                value: json['cashAndCashEquivalents']),
            ReportItemModel(
                title: 'Short Term Investments',
                value: json['shortTermInvestments']),
            ReportItemModel(
                title: 'Receivables', value: json['netReceivables']),
            ReportItemModel(title: 'Inventory', value: json['inventory']),
            ReportItemModel(
                title: 'Other Current Assets',
                value: json['otherCurrentAssets']),
            ReportItemModel(
                title: 'Total non-current Assets',
                value: json['totalNonCurrentAssets']),
            ReportItemModel(
                title: 'Property, Plant & Equipment Net',
                value: json['propertyPlantEquipmentNet']),
            ReportItemModel(
                title: 'Long Term Investments',
                value: json['longTermInvestments']),
            ReportItemModel(
                title: 'Other non-current Assets',
                value: json['otherNonCurrentAssets']),
            ReportItemModel(
                title: 'Total liabilities', value: json['totalLiabilities']),
            ReportItemModel(
                title: 'Total current liabilities',
                value: json['totalCurrentLiabilities']),
            ReportItemModel(title: 'Payables', value: json['accountPayables']),
            ReportItemModel(
                title: 'Short Term debt', value: json['shortTermDebt']),
            ReportItemModel(
                title: 'Deferred revenue', value: json['deferredRevenue']),
            ReportItemModel(
                title: 'Other Current Liabilities',
                value: json['otherCurrentLiabilities']),
            ReportItemModel(
                title: 'Total non-current liabilities',
                value: json['totalNonCurrentLiabilities']),
            ReportItemModel(
                title: 'Long Term debt', value: json['longTermDebt']),
            ReportItemModel(
                title: 'Other non-current Liabilities',
                value: json['otherNonCurrentLiabilities']),
            ReportItemModel(
                title: 'Total shareholders equity',
                value: json['totalStockholdersEquity']),
            ReportItemModel(title: 'Common Stock', value: json['commonStock']),
            ReportItemModel(
                title: 'Retained earnings', value: json['retainedEarnings']),
            ReportItemModel(
                title: 'Accumulated Other Comprehensive Income Loss',
                value: json['accumulatedOtherComprehensiveIncomeLoss']),
            ReportItemModel(title: 'Total debt', value: json['totalDebt']),
            ReportItemModel(
                title: 'Total Investments', value: json['totalInvestments']),
            ReportItemModel(title: 'Net Debt', value: json['netDebt'])
          ]);
}
