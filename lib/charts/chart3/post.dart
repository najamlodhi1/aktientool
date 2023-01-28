// https://app.quicktype.io/
// https://financialmodelingprep.com/api/v3/balance-sheet-statement/AAPL?limit=20&apikey=${FMPKEY}
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
    this.reportedCurrency,
    this.cik,
    this.fillingDate,
    this.acceptedDate,
    this.calendarYear,
    this.period,
    this.cashAndCashEquivalents,
    this.shortTermInvestments,
    this.cashAndShortTermInvestments,
    this.netReceivables,
    this.inventory,
    this.otherCurrentAssets,
    this.totalCurrentAssets,
    this.propertyPlantEquipmentNet,
    this.goodwill,
    this.intangibleAssets,
    this.goodwillAndIntangibleAssets,
    this.longTermInvestments,
    this.taxAssets,
    this.otherNonCurrentAssets,
    this.totalNonCurrentAssets,
    this.otherAssets,
    this.totalAssets,
    this.accountPayables,
    this.shortTermDebt,
    this.taxPayables,
    this.deferredRevenue,
    this.otherCurrentLiabilities,
    this.totalCurrentLiabilities,
    this.longTermDebt,
    this.deferredRevenueNonCurrent,
    this.deferredTaxLiabilitiesNonCurrent,
    this.otherNonCurrentLiabilities,
    this.totalNonCurrentLiabilities,
    this.otherLiabilities,
    this.capitalLeaseObligations,
    this.totalLiabilities,
    this.preferredStock,
    this.commonStock,
    this.retainedEarnings,
    this.accumulatedOtherComprehensiveIncomeLoss,
    this.othertotalStockholdersEquity,
    this.totalStockholdersEquity,
    this.totalLiabilitiesAndStockholdersEquity,
    this.minorityInterest,
    this.totalEquity,
    this.totalLiabilitiesAndTotalEquity,
    this.totalInvestments,
    this.totalDebt,
    this.netDebt,
    this.link,
    this.finalLink,
  });

  DateTime? date;
  Symbol? symbol;
  ReportedCurrency? reportedCurrency;
  String? cik;
  DateTime? fillingDate;
  DateTime? acceptedDate;
  String? calendarYear;
  Period? period;
  int? cashAndCashEquivalents;
  int? shortTermInvestments;
  int? cashAndShortTermInvestments;
  int? netReceivables;
  int? inventory;
  int? otherCurrentAssets;
  int? totalCurrentAssets;
  int? propertyPlantEquipmentNet;
  int? goodwill;
  int? intangibleAssets;
  int? goodwillAndIntangibleAssets;
  int? longTermInvestments;
  int? taxAssets;
  int? otherNonCurrentAssets;
  int? totalNonCurrentAssets;
  int? otherAssets;
  int? totalAssets;
  int? accountPayables;
  int? shortTermDebt;
  int? taxPayables;
  int? deferredRevenue;
  int? otherCurrentLiabilities;
  int? totalCurrentLiabilities;
  int? longTermDebt;
  int? deferredRevenueNonCurrent;
  int? deferredTaxLiabilitiesNonCurrent;
  int? otherNonCurrentLiabilities;
  int? totalNonCurrentLiabilities;
  int? otherLiabilities;
  int? capitalLeaseObligations;
  int? totalLiabilities;
  int? preferredStock;
  int? commonStock;
  int? retainedEarnings;
  int? accumulatedOtherComprehensiveIncomeLoss;
  int? othertotalStockholdersEquity;
  int? totalStockholdersEquity;
  int? totalLiabilitiesAndStockholdersEquity;
  int? minorityInterest;
  int? totalEquity;
  int? totalLiabilitiesAndTotalEquity;
  int? totalInvestments;
  int? totalDebt;
  int? netDebt;
  String? link;
  String? finalLink;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        date: DateTime.parse(json["date"]),
        symbol: symbolValues.map[json["symbol"]],
        reportedCurrency: reportedCurrencyValues.map[json["reportedCurrency"]],
        cik: json["cik"],
        fillingDate: DateTime.parse(json["fillingDate"]),
        acceptedDate: DateTime.parse(json["acceptedDate"]),
        calendarYear: json["calendarYear"],
        period: periodValues.map[json["period"]],
        cashAndCashEquivalents: json["cashAndCashEquivalents"],
        shortTermInvestments: json["shortTermInvestments"],
        cashAndShortTermInvestments: json["cashAndShortTermInvestments"],
        netReceivables: json["netReceivables"],
        inventory: json["inventory"],
        otherCurrentAssets: json["otherCurrentAssets"],
        totalCurrentAssets: json["totalCurrentAssets"],
        propertyPlantEquipmentNet: json["propertyPlantEquipmentNet"],
        goodwill: json["goodwill"],
        intangibleAssets: json["intangibleAssets"],
        goodwillAndIntangibleAssets: json["goodwillAndIntangibleAssets"],
        longTermInvestments: json["longTermInvestments"],
        taxAssets: json["taxAssets"],
        otherNonCurrentAssets: json["otherNonCurrentAssets"],
        totalNonCurrentAssets: json["totalNonCurrentAssets"],
        otherAssets: json["otherAssets"],
        totalAssets: json["totalAssets"],
        accountPayables: json["accountPayables"],
        shortTermDebt: json["shortTermDebt"],
        taxPayables: json["taxPayables"],
        deferredRevenue: json["deferredRevenue"],
        otherCurrentLiabilities: json["otherCurrentLiabilities"],
        totalCurrentLiabilities: json["totalCurrentLiabilities"],
        longTermDebt: json["longTermDebt"],
        deferredRevenueNonCurrent: json["deferredRevenueNonCurrent"],
        deferredTaxLiabilitiesNonCurrent:
            json["deferredTaxLiabilitiesNonCurrent"],
        otherNonCurrentLiabilities: json["otherNonCurrentLiabilities"],
        totalNonCurrentLiabilities: json["totalNonCurrentLiabilities"],
        otherLiabilities: json["otherLiabilities"],
        capitalLeaseObligations: json["capitalLeaseObligations"],
        totalLiabilities: json["totalLiabilities"],
        preferredStock: json["preferredStock"],
        commonStock: json["commonStock"],
        retainedEarnings: json["retainedEarnings"],
        accumulatedOtherComprehensiveIncomeLoss:
            json["accumulatedOtherComprehensiveIncomeLoss"],
        othertotalStockholdersEquity: json["othertotalStockholdersEquity"],
        totalStockholdersEquity: json["totalStockholdersEquity"],
        totalLiabilitiesAndStockholdersEquity:
            json["totalLiabilitiesAndStockholdersEquity"],
        minorityInterest: json["minorityInterest"],
        totalEquity: json["totalEquity"],
        totalLiabilitiesAndTotalEquity: json["totalLiabilitiesAndTotalEquity"],
        totalInvestments: json["totalInvestments"],
        totalDebt: json["totalDebt"],
        netDebt: json["netDebt"],
        link: json["link"],
        finalLink: json["finalLink"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "symbol": symbolValues.reverse![symbol],
        "reportedCurrency": reportedCurrencyValues.reverse![reportedCurrency],
        "cik": cik,
        "fillingDate":
            "${fillingDate!.year.toString().padLeft(4, '0')}-${fillingDate!.month.toString().padLeft(2, '0')}-${fillingDate!.day.toString().padLeft(2, '0')}",
        "acceptedDate": acceptedDate?.toIso8601String(),
        "calendarYear": calendarYear,
        "period": periodValues.reverse![period],
        "cashAndCashEquivalents": cashAndCashEquivalents,
        "shortTermInvestments": shortTermInvestments,
        "cashAndShortTermInvestments": cashAndShortTermInvestments,
        "netReceivables": netReceivables,
        "inventory": inventory,
        "otherCurrentAssets": otherCurrentAssets,
        "totalCurrentAssets": totalCurrentAssets,
        "propertyPlantEquipmentNet": propertyPlantEquipmentNet,
        "goodwill": goodwill,
        "intangibleAssets": intangibleAssets,
        "goodwillAndIntangibleAssets": goodwillAndIntangibleAssets,
        "longTermInvestments": longTermInvestments,
        "taxAssets": taxAssets,
        "otherNonCurrentAssets": otherNonCurrentAssets,
        "totalNonCurrentAssets": totalNonCurrentAssets,
        "otherAssets": otherAssets,
        "totalAssets": totalAssets,
        "accountPayables": accountPayables,
        "shortTermDebt": shortTermDebt,
        "taxPayables": taxPayables,
        "deferredRevenue": deferredRevenue,
        "otherCurrentLiabilities": otherCurrentLiabilities,
        "totalCurrentLiabilities": totalCurrentLiabilities,
        "longTermDebt": longTermDebt,
        "deferredRevenueNonCurrent": deferredRevenueNonCurrent,
        "deferredTaxLiabilitiesNonCurrent": deferredTaxLiabilitiesNonCurrent,
        "otherNonCurrentLiabilities": otherNonCurrentLiabilities,
        "totalNonCurrentLiabilities": totalNonCurrentLiabilities,
        "otherLiabilities": otherLiabilities,
        "capitalLeaseObligations": capitalLeaseObligations,
        "totalLiabilities": totalLiabilities,
        "preferredStock": preferredStock,
        "commonStock": commonStock,
        "retainedEarnings": retainedEarnings,
        "accumulatedOtherComprehensiveIncomeLoss":
            accumulatedOtherComprehensiveIncomeLoss,
        "othertotalStockholdersEquity": othertotalStockholdersEquity,
        "totalStockholdersEquity": totalStockholdersEquity,
        "totalLiabilitiesAndStockholdersEquity":
            totalLiabilitiesAndStockholdersEquity,
        "minorityInterest": minorityInterest,
        "totalEquity": totalEquity,
        "totalLiabilitiesAndTotalEquity": totalLiabilitiesAndTotalEquity,
        "totalInvestments": totalInvestments,
        "totalDebt": totalDebt,
        "netDebt": netDebt,
        "link": link,
        "finalLink": finalLink,
      };
}

enum Period { FY }

final periodValues = EnumValues({"FY": Period.FY});

enum ReportedCurrency { USD }

final reportedCurrencyValues = EnumValues({"USD": ReportedCurrency.USD});

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
