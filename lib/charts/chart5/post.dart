// https://app.quicktype.io/
// https://financialmodelingprep.com/api/v3/ratios/AAPL?limit=20&apikey=9ad9c8dfa54c11aff6c1489d109e87b6

// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post?>? postFromJson(String str) => json.decode(str) == null
    ? []
    : List<Post?>.from(json.decode(str)!.map((x) => Post.fromJson(x)));

String postToJson(List<Post?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class Post {
  Post({
    this.symbol,
    this.date,
    this.period,
    this.currentRatio,
    this.quickRatio,
    this.cashRatio,
    this.daysOfSalesOutstanding,
    this.daysOfInventoryOutstanding,
    this.operatingCycle,
    this.daysOfPayablesOutstanding,
    this.cashConversionCycle,
    this.grossProfitMargin,
    this.operatingProfitMargin,
    this.pretaxProfitMargin,
    this.netProfitMargin,
    this.effectiveTaxRate,
    this.returnOnAssets,
    this.returnOnEquity,
    this.returnOnCapitalEmployed,
    this.netIncomePerEbt,
    this.ebtPerEbit,
    this.ebitPerRevenue,
    this.debtRatio,
    this.debtEquityRatio,
    this.longTermDebtToCapitalization,
    this.totalDebtToCapitalization,
    this.interestCoverage,
    this.cashFlowToDebtRatio,
    this.companyEquityMultiplier,
    this.receivablesTurnover,
    this.payablesTurnover,
    this.inventoryTurnover,
    this.fixedAssetTurnover,
    this.assetTurnover,
    this.operatingCashFlowPerShare,
    this.freeCashFlowPerShare,
    this.cashPerShare,
    this.payoutRatio,
    this.operatingCashFlowSalesRatio,
    this.freeCashFlowOperatingCashFlowRatio,
    this.cashFlowCoverageRatios,
    this.shortTermCoverageRatios,
    this.capitalExpenditureCoverageRatio,
    this.dividendPaidAndCapexCoverageRatio,
    this.dividendPayoutRatio,
    this.priceBookValueRatio,
    this.priceToBookRatio,
    this.priceToSalesRatio,
    this.priceEarningsRatio,
    this.priceToFreeCashFlowsRatio,
    this.priceToOperatingCashFlowsRatio,
    this.priceCashFlowRatio,
    this.priceEarningsToGrowthRatio,
    this.priceSalesRatio,
    this.dividendYield,
    this.enterpriseValueMultiple,
    this.priceFairValue,
  });

  Symbol? symbol;
  DateTime? date;
  Period? period;
  double? currentRatio;
  double? quickRatio;
  double? cashRatio;
  double? daysOfSalesOutstanding;
  double? daysOfInventoryOutstanding;
  double? operatingCycle;
  double? daysOfPayablesOutstanding;
  double? cashConversionCycle;
  double? grossProfitMargin;
  double? operatingProfitMargin;
  double? pretaxProfitMargin;
  double? netProfitMargin;
  double? effectiveTaxRate;
  double? returnOnAssets;
  double? returnOnEquity;
  double? returnOnCapitalEmployed;
  double? netIncomePerEbt;
  double? ebtPerEbit;
  double? ebitPerRevenue;
  double? debtRatio;
  double? debtEquityRatio;
  double? longTermDebtToCapitalization;
  double? totalDebtToCapitalization;
  double? interestCoverage;
  double? cashFlowToDebtRatio;
  double? companyEquityMultiplier;
  double? receivablesTurnover;
  double? payablesTurnover;
  double? inventoryTurnover;
  double? fixedAssetTurnover;
  double? assetTurnover;
  double? operatingCashFlowPerShare;
  double? freeCashFlowPerShare;
  double? cashPerShare;
  double? payoutRatio;
  double? operatingCashFlowSalesRatio;
  double? freeCashFlowOperatingCashFlowRatio;
  double? cashFlowCoverageRatios;
  double? shortTermCoverageRatios;
  double? capitalExpenditureCoverageRatio;
  double? dividendPaidAndCapexCoverageRatio;
  double? dividendPayoutRatio;
  double? priceBookValueRatio;
  double? priceToBookRatio;
  double? priceToSalesRatio;
  double? priceEarningsRatio;
  double? priceToFreeCashFlowsRatio;
  double? priceToOperatingCashFlowsRatio;
  double? priceCashFlowRatio;
  double? priceEarningsToGrowthRatio;
  double? priceSalesRatio;
  double? dividendYield;
  double? enterpriseValueMultiple;
  double? priceFairValue;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        symbol: symbolValues.map[json["symbol"]],
        date: DateTime.parse(json["date"]),
        period: periodValues.map[json["period"]],
        currentRatio: json["currentRatio"].toDouble(),
        quickRatio: json["quickRatio"].toDouble(),
        cashRatio: json["cashRatio"].toDouble(),
        daysOfSalesOutstanding: json["daysOfSalesOutstanding"].toDouble(),
        daysOfInventoryOutstanding:
            json["daysOfInventoryOutstanding"].toDouble(),
        operatingCycle: json["operatingCycle"].toDouble(),
        daysOfPayablesOutstanding: json["daysOfPayablesOutstanding"].toDouble(),
        cashConversionCycle: json["cashConversionCycle"].toDouble(),
        grossProfitMargin: json["grossProfitMargin"].toDouble(),
        operatingProfitMargin: json["operatingProfitMargin"].toDouble(),
        pretaxProfitMargin: json["pretaxProfitMargin"].toDouble(),
        netProfitMargin: json["netProfitMargin"].toDouble(),
        effectiveTaxRate: json["effectiveTaxRate"].toDouble(),
        returnOnAssets: json["returnOnAssets"].toDouble(),
        returnOnEquity: json["returnOnEquity"].toDouble(),
        returnOnCapitalEmployed: json["returnOnCapitalEmployed"].toDouble(),
        netIncomePerEbt: json["netIncomePerEBT"].toDouble(),
        ebtPerEbit: json["ebtPerEbit"].toDouble(),
        ebitPerRevenue: json["ebitPerRevenue"].toDouble(),
        debtRatio: json["debtRatio"].toDouble(),
        debtEquityRatio: json["debtEquityRatio"].toDouble(),
        longTermDebtToCapitalization: json["longTermDebtToCapitalization"],
        totalDebtToCapitalization: json["totalDebtToCapitalization"],
        interestCoverage: json["interestCoverage"],
        cashFlowToDebtRatio: json["cashFlowToDebtRatio"],
        companyEquityMultiplier: json["companyEquityMultiplier"].toDouble(),
        receivablesTurnover: json["receivablesTurnover"].toDouble(),
        payablesTurnover: json["payablesTurnover"].toDouble(),
        inventoryTurnover: json["inventoryTurnover"].toDouble(),
        fixedAssetTurnover: json["fixedAssetTurnover"].toDouble(),
        assetTurnover: json["assetTurnover"].toDouble(),
        operatingCashFlowPerShare: json["operatingCashFlowPerShare"].toDouble(),
        freeCashFlowPerShare: json["freeCashFlowPerShare"].toDouble(),
        cashPerShare: json["cashPerShare"].toDouble(),
        payoutRatio: json["payoutRatio"].toDouble(),
        operatingCashFlowSalesRatio:
            json["operatingCashFlowSalesRatio"].toDouble(),
        freeCashFlowOperatingCashFlowRatio:
            json["freeCashFlowOperatingCashFlowRatio"].toDouble(),
        cashFlowCoverageRatios: json["cashFlowCoverageRatios"],
        shortTermCoverageRatios: json["shortTermCoverageRatios"],
        capitalExpenditureCoverageRatio:
            json["capitalExpenditureCoverageRatio"].toDouble(),
        dividendPaidAndCapexCoverageRatio:
            json["dividendPaidAndCapexCoverageRatio"],
        dividendPayoutRatio: json["dividendPayoutRatio"],
        priceBookValueRatio: json["priceBookValueRatio"].toDouble(),
        priceToBookRatio: json["priceToBookRatio"].toDouble(),
        priceToSalesRatio: json["priceToSalesRatio"].toDouble(),
        priceEarningsRatio: json["priceEarningsRatio"].toDouble(),
        priceToFreeCashFlowsRatio: json["priceToFreeCashFlowsRatio"].toDouble(),
        priceToOperatingCashFlowsRatio:
            json["priceToOperatingCashFlowsRatio"].toDouble(),
        priceCashFlowRatio: json["priceCashFlowRatio"].toDouble(),
        priceEarningsToGrowthRatio:
            json["priceEarningsToGrowthRatio"].toDouble(),
        priceSalesRatio: json["priceSalesRatio"].toDouble(),
        dividendYield: json["dividendYield"],
        enterpriseValueMultiple: json["enterpriseValueMultiple"].toDouble(),
        priceFairValue: json["priceFairValue"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbolValues.reverse![symbol],
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "period": periodValues.reverse![period],
        "currentRatio": currentRatio,
        "quickRatio": quickRatio,
        "cashRatio": cashRatio,
        "daysOfSalesOutstanding": daysOfSalesOutstanding,
        "daysOfInventoryOutstanding": daysOfInventoryOutstanding,
        "operatingCycle": operatingCycle,
        "daysOfPayablesOutstanding": daysOfPayablesOutstanding,
        "cashConversionCycle": cashConversionCycle,
        "grossProfitMargin": grossProfitMargin,
        "operatingProfitMargin": operatingProfitMargin,
        "pretaxProfitMargin": pretaxProfitMargin,
        "netProfitMargin": netProfitMargin,
        "effectiveTaxRate": effectiveTaxRate,
        "returnOnAssets": returnOnAssets,
        "returnOnEquity": returnOnEquity,
        "returnOnCapitalEmployed": returnOnCapitalEmployed,
        "netIncomePerEBT": netIncomePerEbt,
        "ebtPerEbit": ebtPerEbit,
        "ebitPerRevenue": ebitPerRevenue,
        "debtRatio": debtRatio,
        "debtEquityRatio": debtEquityRatio,
        "longTermDebtToCapitalization": longTermDebtToCapitalization,
        "totalDebtToCapitalization": totalDebtToCapitalization,
        "interestCoverage": interestCoverage,
        "cashFlowToDebtRatio": cashFlowToDebtRatio,
        "companyEquityMultiplier": companyEquityMultiplier,
        "receivablesTurnover": receivablesTurnover,
        "payablesTurnover": payablesTurnover,
        "inventoryTurnover": inventoryTurnover,
        "fixedAssetTurnover": fixedAssetTurnover,
        "assetTurnover": assetTurnover,
        "operatingCashFlowPerShare": operatingCashFlowPerShare,
        "freeCashFlowPerShare": freeCashFlowPerShare,
        "cashPerShare": cashPerShare,
        "payoutRatio": payoutRatio,
        "operatingCashFlowSalesRatio": operatingCashFlowSalesRatio,
        "freeCashFlowOperatingCashFlowRatio":
            freeCashFlowOperatingCashFlowRatio,
        "cashFlowCoverageRatios": cashFlowCoverageRatios,
        "shortTermCoverageRatios": shortTermCoverageRatios,
        "capitalExpenditureCoverageRatio": capitalExpenditureCoverageRatio,
        "dividendPaidAndCapexCoverageRatio": dividendPaidAndCapexCoverageRatio,
        "dividendPayoutRatio": dividendPayoutRatio,
        "priceBookValueRatio": priceBookValueRatio,
        "priceToBookRatio": priceToBookRatio,
        "priceToSalesRatio": priceToSalesRatio,
        "priceEarningsRatio": priceEarningsRatio,
        "priceToFreeCashFlowsRatio": priceToFreeCashFlowsRatio,
        "priceToOperatingCashFlowsRatio": priceToOperatingCashFlowsRatio,
        "priceCashFlowRatio": priceCashFlowRatio,
        "priceEarningsToGrowthRatio": priceEarningsToGrowthRatio,
        "priceSalesRatio": priceSalesRatio,
        "dividendYield": dividendYield,
        "enterpriseValueMultiple": enterpriseValueMultiple,
        "priceFairValue": priceFairValue,
      };
}

enum Period { FY }

final periodValues = EnumValues({"FY": Period.FY});

enum Symbol { AAPL }

final symbolValues = EnumValues({"AAPL": Symbol.AAPL});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
