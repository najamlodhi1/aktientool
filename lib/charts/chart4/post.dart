// https://app.quicktype.io/
// https://financialmodelingprep.com/api/v3/cash-flow-statement/AAPL?limit=20&apikey=${FMPKEY}

// ignore_for_file: constant_identifier_names

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
    this.netIncome,
    this.depreciationAndAmortization,
    this.deferredIncomeTax,
    this.stockBasedCompensation,
    this.changeInWorkingCapital,
    this.accountsReceivables,
    this.inventory,
    this.accountsPayables,
    this.otherWorkingCapital,
    this.otherNonCashItems,
    this.netCashProvidedByOperatingActivities,
    this.investmentsInPropertyPlantAndEquipment,
    this.acquisitionsNet,
    this.purchasesOfInvestments,
    this.salesMaturitiesOfInvestments,
    this.otherInvestingActivites,
    this.netCashUsedForInvestingActivites,
    this.debtRepayment,
    this.commonStockIssued,
    this.commonStockRepurchased,
    this.dividendsPaid,
    this.otherFinancingActivites,
    this.netCashUsedProvidedByFinancingActivities,
    this.effectOfForexChangesOnCash,
    this.netChangeInCash,
    this.cashAtEndOfPeriod,
    this.cashAtBeginningOfPeriod,
    this.operatingCashFlow,
    this.capitalExpenditure,
    this.freeCashFlow,
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
  int? netIncome;
  int? depreciationAndAmortization;
  int? deferredIncomeTax;
  int? stockBasedCompensation;
  int? changeInWorkingCapital;
  int? accountsReceivables;
  int? inventory;
  int? accountsPayables;
  int? otherWorkingCapital;
  int? otherNonCashItems;
  int? netCashProvidedByOperatingActivities;
  int? investmentsInPropertyPlantAndEquipment;
  int? acquisitionsNet;
  int? purchasesOfInvestments;
  int? salesMaturitiesOfInvestments;
  int? otherInvestingActivites;
  int? netCashUsedForInvestingActivites;
  int? debtRepayment;
  int? commonStockIssued;
  int? commonStockRepurchased;
  int? dividendsPaid;
  int? otherFinancingActivites;
  int? netCashUsedProvidedByFinancingActivities;
  int? effectOfForexChangesOnCash;
  int? netChangeInCash;
  int? cashAtEndOfPeriod;
  int? cashAtBeginningOfPeriod;
  int? operatingCashFlow;
  int? capitalExpenditure;
  int? freeCashFlow;
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
        netIncome: json["netIncome"],
        depreciationAndAmortization: json["depreciationAndAmortization"],
        deferredIncomeTax: json["deferredIncomeTax"],
        stockBasedCompensation: json["stockBasedCompensation"],
        changeInWorkingCapital: json["changeInWorkingCapital"],
        accountsReceivables: json["accountsReceivables"],
        inventory: json["inventory"],
        accountsPayables: json["accountsPayables"],
        otherWorkingCapital: json["otherWorkingCapital"],
        otherNonCashItems: json["otherNonCashItems"],
        netCashProvidedByOperatingActivities:
            json["netCashProvidedByOperatingActivities"],
        investmentsInPropertyPlantAndEquipment:
            json["investmentsInPropertyPlantAndEquipment"],
        acquisitionsNet: json["acquisitionsNet"],
        purchasesOfInvestments: json["purchasesOfInvestments"],
        salesMaturitiesOfInvestments: json["salesMaturitiesOfInvestments"],
        otherInvestingActivites: json["otherInvestingActivites"],
        netCashUsedForInvestingActivites:
            json["netCashUsedForInvestingActivites"],
        debtRepayment: json["debtRepayment"],
        commonStockIssued: json["commonStockIssued"],
        commonStockRepurchased: json["commonStockRepurchased"],
        dividendsPaid: json["dividendsPaid"],
        otherFinancingActivites: json["otherFinancingActivites"],
        netCashUsedProvidedByFinancingActivities:
            json["netCashUsedProvidedByFinancingActivities"],
        effectOfForexChangesOnCash: json["effectOfForexChangesOnCash"],
        netChangeInCash: json["netChangeInCash"],
        cashAtEndOfPeriod: json["cashAtEndOfPeriod"],
        cashAtBeginningOfPeriod: json["cashAtBeginningOfPeriod"],
        operatingCashFlow: json["operatingCashFlow"],
        capitalExpenditure: json["capitalExpenditure"],
        freeCashFlow: json["freeCashFlow"],
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
        "netIncome": netIncome,
        "depreciationAndAmortization": depreciationAndAmortization,
        "deferredIncomeTax": deferredIncomeTax,
        "stockBasedCompensation": stockBasedCompensation,
        "changeInWorkingCapital": changeInWorkingCapital,
        "accountsReceivables": accountsReceivables,
        "inventory": inventory,
        "accountsPayables": accountsPayables,
        "otherWorkingCapital": otherWorkingCapital,
        "otherNonCashItems": otherNonCashItems,
        "netCashProvidedByOperatingActivities":
            netCashProvidedByOperatingActivities,
        "investmentsInPropertyPlantAndEquipment":
            investmentsInPropertyPlantAndEquipment,
        "acquisitionsNet": acquisitionsNet,
        "purchasesOfInvestments": purchasesOfInvestments,
        "salesMaturitiesOfInvestments": salesMaturitiesOfInvestments,
        "otherInvestingActivites": otherInvestingActivites,
        "netCashUsedForInvestingActivites": netCashUsedForInvestingActivites,
        "debtRepayment": debtRepayment,
        "commonStockIssued": commonStockIssued,
        "commonStockRepurchased": commonStockRepurchased,
        "dividendsPaid": dividendsPaid,
        "otherFinancingActivites": otherFinancingActivites,
        "netCashUsedProvidedByFinancingActivities":
            netCashUsedProvidedByFinancingActivities,
        "effectOfForexChangesOnCash": effectOfForexChangesOnCash,
        "netChangeInCash": netChangeInCash,
        "cashAtEndOfPeriod": cashAtEndOfPeriod,
        "cashAtBeginningOfPeriod": cashAtBeginningOfPeriod,
        "operatingCashFlow": operatingCashFlow,
        "capitalExpenditure": capitalExpenditure,
        "freeCashFlow": freeCashFlow,
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
