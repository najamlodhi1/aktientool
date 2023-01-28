// https://app.quicktype.io/
// https://financialmodelingprep.com/api/v3/income-statement-growth/AAPL?limit=20&apikey=${APIKEY1}

import 'dart:convert';

List<Post?>? postFromJson(String str) => json.decode(str) == null
    ? []
    : List<Post?>.from(json.decode(str)!.map((x) => Post.fromJson(x)));

String postToJson(List<Post?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class Post {
  Post({
    this.date,
    this.symbol,
    this.period,
    this.growthRevenue,
    this.growthCostOfRevenue,
    this.growthGrossProfit,
    this.growthGrossProfitRatio,
    this.growthResearchAndDevelopmentExpenses,
    this.growthGeneralAndAdministrativeExpenses,
    this.growthSellingAndMarketingExpenses,
    this.growthOtherExpenses,
    this.growthOperatingExpenses,
    this.growthCostAndExpenses,
    this.growthInterestExpense,
    this.growthDepreciationAndAmortization,
    this.growthEbitda,
    this.growthEbitdaRatio,
    this.growthOperatingIncome,
    this.growthOperatingIncomeRatio,
    this.growthTotalOtherIncomeExpensesNet,
    this.growthIncomeBeforeTax,
    this.growthIncomeBeforeTaxRatio,
    this.growthIncomeTaxExpense,
    this.growthNetIncome,
    this.growthNetIncomeRatio,
    this.growthEps,
    this.growthEpsDiluted,
    this.growthWeightedAverageShsOut,
    this.growthWeightedAverageShsOutDil,
  });

  DateTime? date;
  Symbol? symbol;
  Period? period;
  double? growthRevenue;
  double? growthCostOfRevenue;
  double? growthGrossProfit;
  double? growthGrossProfitRatio;
  double? growthResearchAndDevelopmentExpenses;
  int? growthGeneralAndAdministrativeExpenses;
  int? growthSellingAndMarketingExpenses;
  int? growthOtherExpenses;
  double? growthOperatingExpenses;
  double? growthCostAndExpenses;
  double? growthInterestExpense;
  double? growthDepreciationAndAmortization;
  double? growthEbitda;
  double? growthEbitdaRatio;
  double? growthOperatingIncome;
  double? growthOperatingIncomeRatio;
  double? growthTotalOtherIncomeExpensesNet;
  double? growthIncomeBeforeTax;
  double? growthIncomeBeforeTaxRatio;
  double? growthIncomeTaxExpense;
  double? growthNetIncome;
  double? growthNetIncomeRatio;
  double? growthEps;
  double? growthEpsDiluted;
  double? growthWeightedAverageShsOut;
  double? growthWeightedAverageShsOutDil;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        date: DateTime.parse(json["date"]),
        symbol: symbolValues.map[json["symbol"]],
        period: periodValues.map[json["period"]],
        growthRevenue: json["growthRevenue"].toDouble(),
        growthCostOfRevenue: json["growthCostOfRevenue"].toDouble(),
        growthGrossProfit: json["growthGrossProfit"].toDouble(),
        growthGrossProfitRatio: json["growthGrossProfitRatio"].toDouble(),
        growthResearchAndDevelopmentExpenses:
            json["growthResearchAndDevelopmentExpenses"].toDouble(),
        growthGeneralAndAdministrativeExpenses:
            json["growthGeneralAndAdministrativeExpenses"],
        growthSellingAndMarketingExpenses:
            json["growthSellingAndMarketingExpenses"],
        growthOtherExpenses: json["growthOtherExpenses"],
        growthOperatingExpenses: json["growthOperatingExpenses"].toDouble(),
        growthCostAndExpenses: json["growthCostAndExpenses"].toDouble(),
        growthInterestExpense: json["growthInterestExpense"].toDouble(),
        growthDepreciationAndAmortization:
            json["growthDepreciationAndAmortization"].toDouble(),
        growthEbitda: json["growthEBITDA"].toDouble(),
        growthEbitdaRatio: json["growthEBITDARatio"].toDouble(),
        growthOperatingIncome: json["growthOperatingIncome"].toDouble(),
        growthOperatingIncomeRatio:
            json["growthOperatingIncomeRatio"].toDouble(),
        growthTotalOtherIncomeExpensesNet:
            json["growthTotalOtherIncomeExpensesNet"].toDouble(),
        growthIncomeBeforeTax: json["growthIncomeBeforeTax"].toDouble(),
        growthIncomeBeforeTaxRatio:
            json["growthIncomeBeforeTaxRatio"].toDouble(),
        growthIncomeTaxExpense: json["growthIncomeTaxExpense"].toDouble(),
        growthNetIncome: json["growthNetIncome"].toDouble(),
        growthNetIncomeRatio: json["growthNetIncomeRatio"].toDouble(),
        growthEps: json["growthEPS"].toDouble(),
        growthEpsDiluted: json["growthEPSDiluted"].toDouble(),
        growthWeightedAverageShsOut:
            json["growthWeightedAverageShsOut"].toDouble(),
        growthWeightedAverageShsOutDil:
            json["growthWeightedAverageShsOutDil"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "symbol": symbolValues.reverse![symbol],
        "period": periodValues.reverse![period],
        "growthRevenue": growthRevenue,
        "growthCostOfRevenue": growthCostOfRevenue,
        "growthGrossProfit": growthGrossProfit,
        "growthGrossProfitRatio": growthGrossProfitRatio,
        "growthResearchAndDevelopmentExpenses":
            growthResearchAndDevelopmentExpenses,
        "growthGeneralAndAdministrativeExpenses":
            growthGeneralAndAdministrativeExpenses,
        "growthSellingAndMarketingExpenses": growthSellingAndMarketingExpenses,
        "growthOtherExpenses": growthOtherExpenses,
        "growthOperatingExpenses": growthOperatingExpenses,
        "growthCostAndExpenses": growthCostAndExpenses,
        "growthInterestExpense": growthInterestExpense,
        "growthDepreciationAndAmortization": growthDepreciationAndAmortization,
        "growthEBITDA": growthEbitda,
        "growthEBITDARatio": growthEbitdaRatio,
        "growthOperatingIncome": growthOperatingIncome,
        "growthOperatingIncomeRatio": growthOperatingIncomeRatio,
        "growthTotalOtherIncomeExpensesNet": growthTotalOtherIncomeExpensesNet,
        "growthIncomeBeforeTax": growthIncomeBeforeTax,
        "growthIncomeBeforeTaxRatio": growthIncomeBeforeTaxRatio,
        "growthIncomeTaxExpense": growthIncomeTaxExpense,
        "growthNetIncome": growthNetIncome,
        "growthNetIncomeRatio": growthNetIncomeRatio,
        "growthEPS": growthEps,
        "growthEPSDiluted": growthEpsDiluted,
        "growthWeightedAverageShsOut": growthWeightedAverageShsOut,
        "growthWeightedAverageShsOutDil": growthWeightedAverageShsOutDil,
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
