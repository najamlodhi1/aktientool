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
    this.date,
    this.symbol,
    this.period,
    this.growthCashAndCashEquivalents,
    this.growthShortTermInvestments,
    this.growthCashAndShortTermInvestments,
    this.growthNetReceivables,
    this.growthInventory,
    this.growthOtherCurrentAssets,
    this.growthTotalCurrentAssets,
    this.growthPropertyPlantEquipmentNet,
    this.growthGoodwill,
    this.growthIntangibleAssets,
    this.growthGoodwillAndIntangibleAssets,
    this.growthLongTermInvestments,
    this.growthTaxAssets,
    this.growthOtherNonCurrentAssets,
    this.growthTotalNonCurrentAssets,
    this.growthOtherAssets,
    this.growthTotalAssets,
    this.growthAccountPayables,
    this.growthShortTermDebt,
    this.growthTaxPayables,
    this.growthDeferredRevenue,
    this.growthOtherCurrentLiabilities,
    this.growthTotalCurrentLiabilities,
    this.growthLongTermDebt,
    this.growthDeferredRevenueNonCurrent,
    this.growthDeferrredTaxLiabilitiesNonCurrent,
    this.growthOtherNonCurrentLiabilities,
    this.growthTotalNonCurrentLiabilities,
    this.growthOtherLiabilities,
    this.growthTotalLiabilities,
    this.growthCommonStock,
    this.growthRetainedEarnings,
    this.growthAccumulatedOtherComprehensiveIncomeLoss,
    this.growthOthertotalStockholdersEquity,
    this.growthTotalStockholdersEquity,
    this.growthTotalLiabilitiesAndStockholdersEquity,
    this.growthTotalInvestments,
    this.growthTotalDebt,
    this.growthNetDebt,
  });

  DateTime? date;
  Symbol? symbol;
  Period? period;
  double? growthCashAndCashEquivalents;
  double? growthShortTermInvestments;
  double? growthCashAndShortTermInvestments;
  double? growthNetReceivables;
  double? growthInventory;
  double? growthOtherCurrentAssets;
  double? growthTotalCurrentAssets;
  double? growthPropertyPlantEquipmentNet;
  double? growthGoodwill;
  double? growthIntangibleAssets;
  double? growthGoodwillAndIntangibleAssets;
  double? growthLongTermInvestments;
  double? growthTaxAssets;
  double? growthOtherNonCurrentAssets;
  double? growthTotalNonCurrentAssets;
  int? growthOtherAssets;
  double? growthTotalAssets;
  double? growthAccountPayables;
  double? growthShortTermDebt;
  double? growthTaxPayables;
  double? growthDeferredRevenue;
  double? growthOtherCurrentLiabilities;
  double? growthTotalCurrentLiabilities;
  double? growthLongTermDebt;
  double? growthDeferredRevenueNonCurrent;
  double? growthDeferrredTaxLiabilitiesNonCurrent;
  double? growthOtherNonCurrentLiabilities;
  double? growthTotalNonCurrentLiabilities;
  int? growthOtherLiabilities;
  double? growthTotalLiabilities;
  double? growthCommonStock;
  double? growthRetainedEarnings;
  double? growthAccumulatedOtherComprehensiveIncomeLoss;
  double? growthOthertotalStockholdersEquity;
  double? growthTotalStockholdersEquity;
  double? growthTotalLiabilitiesAndStockholdersEquity;
  double? growthTotalInvestments;
  double? growthTotalDebt;
  double? growthNetDebt;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        date: DateTime.parse(json["date"]),
        symbol: symbolValues.map[json["symbol"]],
        period: periodValues.map[json["period"]],
        growthCashAndCashEquivalents:
            json["growthCashAndCashEquivalents"].toDouble(),
        growthShortTermInvestments:
            json["growthShortTermInvestments"].toDouble(),
        growthCashAndShortTermInvestments:
            json["growthCashAndShortTermInvestments"].toDouble(),
        growthNetReceivables: json["growthNetReceivables"].toDouble(),
        growthInventory: json["growthInventory"].toDouble(),
        growthOtherCurrentAssets: json["growthOtherCurrentAssets"].toDouble(),
        growthTotalCurrentAssets: json["growthTotalCurrentAssets"].toDouble(),
        growthPropertyPlantEquipmentNet:
            json["growthPropertyPlantEquipmentNet"].toDouble(),
        growthGoodwill: json["growthGoodwill"].toDouble(),
        growthIntangibleAssets: json["growthIntangibleAssets"].toDouble(),
        growthGoodwillAndIntangibleAssets:
            json["growthGoodwillAndIntangibleAssets"].toDouble(),
        growthLongTermInvestments: json["growthLongTermInvestments"].toDouble(),
        growthTaxAssets: json["growthTaxAssets"].toDouble(),
        growthOtherNonCurrentAssets:
            json["growthOtherNonCurrentAssets"].toDouble(),
        growthTotalNonCurrentAssets:
            json["growthTotalNonCurrentAssets"].toDouble(),
        growthOtherAssets: json["growthOtherAssets"],
        growthTotalAssets: json["growthTotalAssets"].toDouble(),
        growthAccountPayables: json["growthAccountPayables"].toDouble(),
        growthShortTermDebt: json["growthShortTermDebt"].toDouble(),
        growthTaxPayables: json["growthTaxPayables"].toDouble(),
        growthDeferredRevenue: json["growthDeferredRevenue"].toDouble(),
        growthOtherCurrentLiabilities:
            json["growthOtherCurrentLiabilities"].toDouble(),
        growthTotalCurrentLiabilities:
            json["growthTotalCurrentLiabilities"].toDouble(),
        growthLongTermDebt: json["growthLongTermDebt"].toDouble(),
        growthDeferredRevenueNonCurrent:
            json["growthDeferredRevenueNonCurrent"].toDouble(),
        growthDeferrredTaxLiabilitiesNonCurrent:
            json["growthDeferrredTaxLiabilitiesNonCurrent"].toDouble(),
        growthOtherNonCurrentLiabilities:
            json["growthOtherNonCurrentLiabilities"].toDouble(),
        growthTotalNonCurrentLiabilities:
            json["growthTotalNonCurrentLiabilities"].toDouble(),
        growthOtherLiabilities: json["growthOtherLiabilities"],
        growthTotalLiabilities: json["growthTotalLiabilities"].toDouble(),
        growthCommonStock: json["growthCommonStock"].toDouble(),
        growthRetainedEarnings: json["growthRetainedEarnings"].toDouble(),
        growthAccumulatedOtherComprehensiveIncomeLoss:
            json["growthAccumulatedOtherComprehensiveIncomeLoss"].toDouble(),
        growthOthertotalStockholdersEquity:
            json["growthOthertotalStockholdersEquity"].toDouble(),
        growthTotalStockholdersEquity:
            json["growthTotalStockholdersEquity"].toDouble(),
        growthTotalLiabilitiesAndStockholdersEquity:
            json["growthTotalLiabilitiesAndStockholdersEquity"].toDouble(),
        growthTotalInvestments: json["growthTotalInvestments"].toDouble(),
        growthTotalDebt: json["growthTotalDebt"].toDouble(),
        growthNetDebt: json["growthNetDebt"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "symbol": symbolValues.reverse![symbol],
        "period": periodValues.reverse![period],
        "growthCashAndCashEquivalents": growthCashAndCashEquivalents,
        "growthShortTermInvestments": growthShortTermInvestments,
        "growthCashAndShortTermInvestments": growthCashAndShortTermInvestments,
        "growthNetReceivables": growthNetReceivables,
        "growthInventory": growthInventory,
        "growthOtherCurrentAssets": growthOtherCurrentAssets,
        "growthTotalCurrentAssets": growthTotalCurrentAssets,
        "growthPropertyPlantEquipmentNet": growthPropertyPlantEquipmentNet,
        "growthGoodwill": growthGoodwill,
        "growthIntangibleAssets": growthIntangibleAssets,
        "growthGoodwillAndIntangibleAssets": growthGoodwillAndIntangibleAssets,
        "growthLongTermInvestments": growthLongTermInvestments,
        "growthTaxAssets": growthTaxAssets,
        "growthOtherNonCurrentAssets": growthOtherNonCurrentAssets,
        "growthTotalNonCurrentAssets": growthTotalNonCurrentAssets,
        "growthOtherAssets": growthOtherAssets,
        "growthTotalAssets": growthTotalAssets,
        "growthAccountPayables": growthAccountPayables,
        "growthShortTermDebt": growthShortTermDebt,
        "growthTaxPayables": growthTaxPayables,
        "growthDeferredRevenue": growthDeferredRevenue,
        "growthOtherCurrentLiabilities": growthOtherCurrentLiabilities,
        "growthTotalCurrentLiabilities": growthTotalCurrentLiabilities,
        "growthLongTermDebt": growthLongTermDebt,
        "growthDeferredRevenueNonCurrent": growthDeferredRevenueNonCurrent,
        "growthDeferrredTaxLiabilitiesNonCurrent":
            growthDeferrredTaxLiabilitiesNonCurrent,
        "growthOtherNonCurrentLiabilities": growthOtherNonCurrentLiabilities,
        "growthTotalNonCurrentLiabilities": growthTotalNonCurrentLiabilities,
        "growthOtherLiabilities": growthOtherLiabilities,
        "growthTotalLiabilities": growthTotalLiabilities,
        "growthCommonStock": growthCommonStock,
        "growthRetainedEarnings": growthRetainedEarnings,
        "growthAccumulatedOtherComprehensiveIncomeLoss":
            growthAccumulatedOtherComprehensiveIncomeLoss,
        "growthOthertotalStockholdersEquity":
            growthOthertotalStockholdersEquity,
        "growthTotalStockholdersEquity": growthTotalStockholdersEquity,
        "growthTotalLiabilitiesAndStockholdersEquity":
            growthTotalLiabilitiesAndStockholdersEquity,
        "growthTotalInvestments": growthTotalInvestments,
        "growthTotalDebt": growthTotalDebt,
        "growthNetDebt": growthNetDebt,
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
