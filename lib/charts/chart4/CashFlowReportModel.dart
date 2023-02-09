import 'package:intl/intl.dart';
import '../chart2/IncomeReportModel.dart';

class CashFlowReportModel {
  final DateTime date;
  List<ReportItemModel> reports;

  CashFlowReportModel({required this.date, required this.reports});

  factory CashFlowReportModel.fromJson(Map<String, dynamic> json) =>
      CashFlowReportModel(
          date: DateFormat('yyyy-MM-dd').parse(json['date']),
          reports: [
            ReportItemModel(
                title: 'Operating Cash Flow', value: json['operatingCashFlow']),
            ReportItemModel(title: 'Net Income', value: json['netIncome']),
            ReportItemModel(
                title: 'Depreciation & Amortization',
                value: json['depreciationAndAmortization']),
            ReportItemModel(
                title: 'Deferred income taxes',
                value: json['deferredIncomeTax']),
            ReportItemModel(
                title: 'Stock-based compensation',
                value: json['stockBasedCompensation']),
            ReportItemModel(
                title: 'Change in working capital',
                value: json['changeInWorkingCapital']),
            ReportItemModel(
                title: 'Other non-cash items',
                value: json['otherNonCashItems']),
            ReportItemModel(
                title: 'Investing Cash Flow',
                value: json['netCashUsedForInvestingActivites']),
            ReportItemModel(
                title: 'Investments in PPE',
                value: json['investmentsInPropertyPlantAndEquipment']),
            ReportItemModel(
                title: 'Acquisitions', value: json['acquisitionsNet']),
            ReportItemModel(
                title: 'Investment purchases',
                value: json['purchasesOfInvestments']),
            ReportItemModel(
                title: 'Sales/Maturities of investments',
                value: json['salesMaturitiesOfInvestments']),
            ReportItemModel(
                title: 'Other Investing Activites',
                value: json['otherInvestingActivites']),
            ReportItemModel(
                title: 'Financing Cash Flow',
                value: json['netCashUsedProvidedByFinancingActivities']),
            ReportItemModel(
                title: 'Debt repayment', value: json['debtRepayment']),
            ReportItemModel(
                title: 'Dividends payments', value: json['dividendsPaid']),
            ReportItemModel(
                title: 'Common Stock Repurchased',
                value: json['commonStockRepurchased']),
            ReportItemModel(
                title: 'Common Stock Issuance',
                value: json['commonStockIssued']),
            ReportItemModel(
                title: 'Other Financing Activites',
                value: json['otherFinancingActivites']),
            ReportItemModel(
                title: 'Accounts receivables',
                value: json['accountsReceivables']),
            ReportItemModel(
                title: 'Accounts payables', value: json['accountsPayables']),
            ReportItemModel(title: 'Inventory', value: json['inventory']),
            ReportItemModel(
                title: 'Other working capital',
                value: json['otherWorkingCapital']),
            ReportItemModel(
                title: 'Cash at beginning of period',
                value: json['cashAtBeginningOfPeriod']),
            ReportItemModel(
                title: 'Cash at end of period',
                value: json['cashAtEndOfPeriod']),
            ReportItemModel(
                title: 'Capital Expenditure',
                value: json['capitalExpenditure']),
            ReportItemModel(
                title: 'Net cash flow / Change in cash',
                value: json['netChangeInCash']),
            ReportItemModel(
                title: 'Free Cash Flow', value: json['freeCashFlow']),
          ]);
}
