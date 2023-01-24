// https://app.quicktype.io/
// https://financialmodelingprep.com/api/v4/advanced_discounted_cash_flow?symbol=AAPL&apikey=9ad9c8dfa54c11aff6c1489d109e87b6

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.year,
    required this.symbol,
    required this.revenue,
    required this.revenuePercentage,
    required this.ebitda,
    required this.ebitdaPercentage,
    required this.ebit,
    required this.ebitPercentage,
    required this.depreciation,
    required this.depreciationPercentage,
    required this.totalCash,
    required this.totalCashPercentage,
    required this.receivables,
    required this.receivablesPercentage,
    required this.inventories,
    required this.inventoriesPercentage,
    required this.payable,
    required this.payablePercentage,
    required this.capitalExpenditure,
    required this.capitalExpenditurePercentage,
    required this.price,
    required this.beta,
    required this.dilutedSharesOutstanding,
    required this.costofDebt,
    required this.taxRate,
    required this.afterTaxCostOfDebt,
    required this.riskFreeRate,
    required this.marketRiskPremium,
    required this.costOfEquity,
    required this.totalDebt,
    required this.totalEquity,
    required this.totalCapital,
    required this.debtWeighting,
    required this.equityWeighting,
    required this.wacc,
    required this.taxRateCash,
    required this.ebiat,
    required this.ufcf,
    required this.sumPvUfcf,
    required this.longTermGrowthRate,
    required this.terminalValue,
    required this.presentTerminalValue,
    required this.enterpriseValue,
    required this.netDebt,
    required this.equityValue,
    required this.equityValuePerShare,
    required this.freeCashFlowT1,
  });

  String year;
  Symbol symbol;
  int revenue;
  double revenuePercentage;
  int ebitda;
  double ebitdaPercentage;
  int ebit;
  double ebitPercentage;
  int depreciation;
  double depreciationPercentage;
  double totalCash;
  double totalCashPercentage;
  int receivables;
  double receivablesPercentage;
  int inventories;
  double inventoriesPercentage;
  int payable;
  double payablePercentage;
  double capitalExpenditure;
  double capitalExpenditurePercentage;
  double price;
  double beta;
  double dilutedSharesOutstanding;
  double costofDebt;
  double taxRate;
  double afterTaxCostOfDebt;
  double riskFreeRate;
  double marketRiskPremium;
  double costOfEquity;
  int totalDebt;
  int totalEquity;
  int totalCapital;
  double debtWeighting;
  double equityWeighting;
  double wacc;
  int taxRateCash;
  int ebiat;
  double ufcf;
  int sumPvUfcf;
  int longTermGrowthRate;
  int terminalValue;
  int presentTerminalValue;
  int enterpriseValue;
  int netDebt;
  int equityValue;
  double equityValuePerShare;
  int freeCashFlowT1;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        year: json["year"],
        symbol: symbolValues.map[json["symbol"]]!,
        revenue: json["revenue"],
        revenuePercentage: json["revenuePercentage"]?.toDouble(),
        ebitda: json["ebitda"],
        ebitdaPercentage: json["ebitdaPercentage"]?.toDouble(),
        ebit: json["ebit"],
        ebitPercentage: json["ebitPercentage"]?.toDouble(),
        depreciation: json["depreciation"],
        depreciationPercentage: json["depreciationPercentage"]?.toDouble(),
        totalCash: json["totalCash"]?.toDouble(),
        totalCashPercentage: json["totalCashPercentage"]?.toDouble(),
        receivables: json["receivables"],
        receivablesPercentage: json["receivablesPercentage"]?.toDouble(),
        inventories: json["inventories"],
        inventoriesPercentage: json["inventoriesPercentage"]?.toDouble(),
        payable: json["payable"],
        payablePercentage: json["payablePercentage"]?.toDouble(),
        capitalExpenditure: json["capitalExpenditure"]?.toDouble(),
        capitalExpenditurePercentage:
            json["capitalExpenditurePercentage"]?.toDouble(),
        price: json["price"]?.toDouble(),
        beta: json["beta"]?.toDouble(),
        dilutedSharesOutstanding: json["dilutedSharesOutstanding"]?.toDouble(),
        costofDebt: json["costofDebt"]?.toDouble(),
        taxRate: json["taxRate"]?.toDouble(),
        afterTaxCostOfDebt: json["afterTaxCostOfDebt"]?.toDouble(),
        riskFreeRate: json["riskFreeRate"]?.toDouble(),
        marketRiskPremium: json["marketRiskPremium"]?.toDouble(),
        costOfEquity: json["costOfEquity"]?.toDouble(),
        totalDebt: json["totalDebt"],
        totalEquity: json["totalEquity"],
        totalCapital: json["totalCapital"],
        debtWeighting: json["debtWeighting"]?.toDouble(),
        equityWeighting: json["equityWeighting"]?.toDouble(),
        wacc: json["wacc"]?.toDouble(),
        taxRateCash: json["taxRateCash"],
        ebiat: json["ebiat"],
        ufcf: json["ufcf"]?.toDouble(),
        sumPvUfcf: json["sumPvUfcf"],
        longTermGrowthRate: json["longTermGrowthRate"],
        terminalValue: json["terminalValue"],
        presentTerminalValue: json["presentTerminalValue"],
        enterpriseValue: json["enterpriseValue"],
        netDebt: json["netDebt"],
        equityValue: json["equityValue"],
        equityValuePerShare: json["equityValuePerShare"]?.toDouble(),
        freeCashFlowT1: json["freeCashFlowT1"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "symbol": symbolValues.reverse[symbol],
        "revenue": revenue,
        "revenuePercentage": revenuePercentage,
        "ebitda": ebitda,
        "ebitdaPercentage": ebitdaPercentage,
        "ebit": ebit,
        "ebitPercentage": ebitPercentage,
        "depreciation": depreciation,
        "depreciationPercentage": depreciationPercentage,
        "totalCash": totalCash,
        "totalCashPercentage": totalCashPercentage,
        "receivables": receivables,
        "receivablesPercentage": receivablesPercentage,
        "inventories": inventories,
        "inventoriesPercentage": inventoriesPercentage,
        "payable": payable,
        "payablePercentage": payablePercentage,
        "capitalExpenditure": capitalExpenditure,
        "capitalExpenditurePercentage": capitalExpenditurePercentage,
        "price": price,
        "beta": beta,
        "dilutedSharesOutstanding": dilutedSharesOutstanding,
        "costofDebt": costofDebt,
        "taxRate": taxRate,
        "afterTaxCostOfDebt": afterTaxCostOfDebt,
        "riskFreeRate": riskFreeRate,
        "marketRiskPremium": marketRiskPremium,
        "costOfEquity": costOfEquity,
        "totalDebt": totalDebt,
        "totalEquity": totalEquity,
        "totalCapital": totalCapital,
        "debtWeighting": debtWeighting,
        "equityWeighting": equityWeighting,
        "wacc": wacc,
        "taxRateCash": taxRateCash,
        "ebiat": ebiat,
        "ufcf": ufcf,
        "sumPvUfcf": sumPvUfcf,
        "longTermGrowthRate": longTermGrowthRate,
        "terminalValue": terminalValue,
        "presentTerminalValue": presentTerminalValue,
        "enterpriseValue": enterpriseValue,
        "netDebt": netDebt,
        "equityValue": equityValue,
        "equityValuePerShare": equityValuePerShare,
        "freeCashFlowT1": freeCashFlowT1,
      };
}

enum Symbol { AAPL }

final symbolValues = EnumValues({"AAPL": Symbol.AAPL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
