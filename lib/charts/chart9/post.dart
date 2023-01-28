// https://app.quicktype.io/
// https://financialmodelingprep.com/api/v3/cash-flow-statement-growth/AAPL?limit=20&apikey=${FMPKEY}
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
    this.growthNetIncome,
    this.growthDepreciationAndAmortization,
    this.growthDeferredIncomeTax,
    this.growthStockBasedCompensation,
    this.growthChangeInWorkingCapital,
    this.growthAccountsReceivables,
    this.growthInventory,
    this.growthAccountsPayables,
    this.growthOtherWorkingCapital,
    this.growthOtherNonCashItems,
    this.growthNetCashProvidedByOperatingActivites,
    this.growthInvestmentsInPropertyPlantAndEquipment,
    this.growthAcquisitionsNet,
    this.growthPurchasesOfInvestments,
    this.growthSalesMaturitiesOfInvestments,
    this.growthOtherInvestingActivites,
    this.growthNetCashUsedForInvestingActivites,
    this.growthDebtRepayment,
    this.growthCommonStockIssued,
    this.growthCommonStockRepurchased,
    this.growthDividendsPaid,
    this.growthOtherFinancingActivites,
    this.growthNetCashUsedProvidedByFinancingActivities,
    this.growthEffectOfForexChangesOnCash,
    this.growthNetChangeInCash,
    this.growthCashAtEndOfPeriod,
    this.growthCashAtBeginningOfPeriod,
    this.growthOperatingCashFlow,
    this.growthCapitalExpenditure,
    this.growthFreeCashFlow,
  });

  DateTime? date;
  Symbol? symbol;
  Period? period;
  double? growthNetIncome;
  double? growthDepreciationAndAmortization;
  double? growthDeferredIncomeTax;
  double? growthStockBasedCompensation;
  double? growthChangeInWorkingCapital;
  double? growthAccountsReceivables;
  double? growthInventory;
  double? growthAccountsPayables;
  double? growthOtherWorkingCapital;
  double? growthOtherNonCashItems;
  double? growthNetCashProvidedByOperatingActivites;
  double? growthInvestmentsInPropertyPlantAndEquipment;
  double? growthAcquisitionsNet;
  double? growthPurchasesOfInvestments;
  double? growthSalesMaturitiesOfInvestments;
  double? growthOtherInvestingActivites;
  double? growthNetCashUsedForInvestingActivites;
  double? growthDebtRepayment;
  double? growthCommonStockIssued;
  double? growthCommonStockRepurchased;
  double? growthDividendsPaid;
  double? growthOtherFinancingActivites;
  double? growthNetCashUsedProvidedByFinancingActivities;
  int? growthEffectOfForexChangesOnCash;
  double? growthNetChangeInCash;
  double? growthCashAtEndOfPeriod;
  double? growthCashAtBeginningOfPeriod;
  double? growthOperatingCashFlow;
  double? growthCapitalExpenditure;
  double? growthFreeCashFlow;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        date: DateTime.parse(json["date"]),
        symbol: symbolValues.map[json["symbol"]],
        period: periodValues.map[json["period"]],
        growthNetIncome: json["growthNetIncome"].toDouble(),
        growthDepreciationAndAmortization:
            json["growthDepreciationAndAmortization"].toDouble(),
        growthDeferredIncomeTax: json["growthDeferredIncomeTax"].toDouble(),
        growthStockBasedCompensation:
            json["growthStockBasedCompensation"].toDouble(),
        growthChangeInWorkingCapital:
            json["growthChangeInWorkingCapital"].toDouble(),
        growthAccountsReceivables: json["growthAccountsReceivables"].toDouble(),
        growthInventory: json["growthInventory"].toDouble(),
        growthAccountsPayables: json["growthAccountsPayables"].toDouble(),
        growthOtherWorkingCapital: json["growthOtherWorkingCapital"].toDouble(),
        growthOtherNonCashItems: json["growthOtherNonCashItems"].toDouble(),
        growthNetCashProvidedByOperatingActivites:
            json["growthNetCashProvidedByOperatingActivites"].toDouble(),
        growthInvestmentsInPropertyPlantAndEquipment:
            json["growthInvestmentsInPropertyPlantAndEquipment"].toDouble(),
        growthAcquisitionsNet: json["growthAcquisitionsNet"].toDouble(),
        growthPurchasesOfInvestments:
            json["growthPurchasesOfInvestments"].toDouble(),
        growthSalesMaturitiesOfInvestments:
            json["growthSalesMaturitiesOfInvestments"].toDouble(),
        growthOtherInvestingActivites:
            json["growthOtherInvestingActivites"].toDouble(),
        growthNetCashUsedForInvestingActivites:
            json["growthNetCashUsedForInvestingActivites"].toDouble(),
        growthDebtRepayment: json["growthDebtRepayment"].toDouble(),
        growthCommonStockIssued: json["growthCommonStockIssued"].toDouble(),
        growthCommonStockRepurchased:
            json["growthCommonStockRepurchased"].toDouble(),
        growthDividendsPaid: json["growthDividendsPaid"].toDouble(),
        growthOtherFinancingActivites:
            json["growthOtherFinancingActivites"].toDouble(),
        growthNetCashUsedProvidedByFinancingActivities:
            json["growthNetCashUsedProvidedByFinancingActivities"].toDouble(),
        growthEffectOfForexChangesOnCash:
            json["growthEffectOfForexChangesOnCash"],
        growthNetChangeInCash: json["growthNetChangeInCash"].toDouble(),
        growthCashAtEndOfPeriod: json["growthCashAtEndOfPeriod"].toDouble(),
        growthCashAtBeginningOfPeriod:
            json["growthCashAtBeginningOfPeriod"].toDouble(),
        growthOperatingCashFlow: json["growthOperatingCashFlow"].toDouble(),
        growthCapitalExpenditure: json["growthCapitalExpenditure"].toDouble(),
        growthFreeCashFlow: json["growthFreeCashFlow"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "symbol": symbolValues.reverse![symbol],
        "period": periodValues.reverse![period],
        "growthNetIncome": growthNetIncome,
        "growthDepreciationAndAmortization": growthDepreciationAndAmortization,
        "growthDeferredIncomeTax": growthDeferredIncomeTax,
        "growthStockBasedCompensation": growthStockBasedCompensation,
        "growthChangeInWorkingCapital": growthChangeInWorkingCapital,
        "growthAccountsReceivables": growthAccountsReceivables,
        "growthInventory": growthInventory,
        "growthAccountsPayables": growthAccountsPayables,
        "growthOtherWorkingCapital": growthOtherWorkingCapital,
        "growthOtherNonCashItems": growthOtherNonCashItems,
        "growthNetCashProvidedByOperatingActivites":
            growthNetCashProvidedByOperatingActivites,
        "growthInvestmentsInPropertyPlantAndEquipment":
            growthInvestmentsInPropertyPlantAndEquipment,
        "growthAcquisitionsNet": growthAcquisitionsNet,
        "growthPurchasesOfInvestments": growthPurchasesOfInvestments,
        "growthSalesMaturitiesOfInvestments":
            growthSalesMaturitiesOfInvestments,
        "growthOtherInvestingActivites": growthOtherInvestingActivites,
        "growthNetCashUsedForInvestingActivites":
            growthNetCashUsedForInvestingActivites,
        "growthDebtRepayment": growthDebtRepayment,
        "growthCommonStockIssued": growthCommonStockIssued,
        "growthCommonStockRepurchased": growthCommonStockRepurchased,
        "growthDividendsPaid": growthDividendsPaid,
        "growthOtherFinancingActivites": growthOtherFinancingActivites,
        "growthNetCashUsedProvidedByFinancingActivities":
            growthNetCashUsedProvidedByFinancingActivities,
        "growthEffectOfForexChangesOnCash": growthEffectOfForexChangesOnCash,
        "growthNetChangeInCash": growthNetChangeInCash,
        "growthCashAtEndOfPeriod": growthCashAtEndOfPeriod,
        "growthCashAtBeginningOfPeriod": growthCashAtBeginningOfPeriod,
        "growthOperatingCashFlow": growthOperatingCashFlow,
        "growthCapitalExpenditure": growthCapitalExpenditure,
        "growthFreeCashFlow": growthFreeCashFlow,
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
