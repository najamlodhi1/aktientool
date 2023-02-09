import 'package:intl/intl.dart';

class IncomeReportModel {
  final DateTime date;
  List<ReportItemModel> reports;

  IncomeReportModel({required this.date, required this.reports});

  factory IncomeReportModel.fromJson(Map<String, dynamic> json) =>
      IncomeReportModel(
          date: DateFormat('yyyy-MM-dd').parse(json['date']),
          reports: [
            ReportItemModel(title: 'Revenue', value: json['revenue']),
            ReportItemModel(
                title: 'Cost of Revenue', value: json['costOfRevenue']),
            ReportItemModel(title: 'Gross Profit', value: json['grossProfit']),
            ReportItemModel(
                title: 'Operating Expenses', value: json['operatingExpenses']),
            ReportItemModel(
                title: 'Selling, General and Administrative Expenses',
                value: json['sellingGeneralAndAdministrativeExpenses']),
            ReportItemModel(
                title: 'Research and Development Expenses',
                value: json['researchAndDevelopmentExpenses']),
            ReportItemModel(
                title: 'Cost and Expenses', value: json['costAndExpenses']),
            ReportItemModel(
                title: 'Operating Income', value: json['operatingIncome']),
            ReportItemModel(
                title: 'Interest Expense', value: json['interestExpense']),
            ReportItemModel(
                title: 'Income Tax Expense', value: json['incomeTaxExpense']),
            ReportItemModel(
                title: 'Earnings before Tax', value: json['incomeBeforeTax']),
            ReportItemModel(title: 'Net Income', value: json['netIncome']),
            ReportItemModel(
                title: 'Earnings Per Share Basic', value: json['eps']),
            ReportItemModel(
                title: 'Earnings Per Share Diluted', value: json['epsdiluted']),
            ReportItemModel(
                title: 'Weighted Average Shares Outstanding	',
                value: json['weightedAverageShsOut']),
            ReportItemModel(
                title: 'Weighted Average Shares Outstanding (Diluted)	',
                value: json['weightedAverageShsOutDil']),
            ReportItemModel(
                title: 'Gross Margin', value: json['grossProfitRatio']),
            ReportItemModel(title: 'EBIT Margin', value: json['ebitdaratio']),
            ReportItemModel(
                title: 'Profit Margin', value: json['netIncomeRatio']),
            ReportItemModel(title: 'EBITDA', value: json['ebitda']),
            ReportItemModel(
                title: 'Earnings Before Tax Margin',
                value: json['operatingIncomeRatio'])
          ]);
}

class ReportItemModel {
  final String title;
  final double value;

  ReportItemModel({required this.title, required this.value});
}
