// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    this.revenue,
    this.costOfRevenue,
    this.grossProfit,
    this.grossProfitRatio,
    this.researchAndDevelopmentExpenses,
    this.generalAndAdministrativeExpenses,
    this.sellingAndMarketingExpenses,
    this.sellingGeneralAndAdministrativeExpenses,
    this.otherExpenses,
    this.operatingExpenses,
    this.costAndExpenses,
    this.interestIncome,
    this.interestExpense,
    this.depreciationAndAmortization,
    this.ebitda,
    this.ebitdaratio,
    this.operatingIncome,
    this.operatingIncomeRatio,
    this.totalOtherIncomeExpensesNet,
    this.incomeBeforeTax,
    this.incomeBeforeTaxRatio,
    this.incomeTaxExpense,
    this.netIncome,
    this.netIncomeRatio,
    this.eps,
    this.epsdiluted,
    this.weightedAverageShsOut,
    this.weightedAverageShsOutDil,
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
  int? revenue;
  int? costOfRevenue;
  int? grossProfit;
  double? grossProfitRatio;
  int? researchAndDevelopmentExpenses;
  int? generalAndAdministrativeExpenses;
  int? sellingAndMarketingExpenses;
  int? sellingGeneralAndAdministrativeExpenses;
  int? otherExpenses;
  int? operatingExpenses;
  int? costAndExpenses;
  int? interestIncome;
  int? interestExpense;
  int? depreciationAndAmortization;
  int? ebitda;
  double? ebitdaratio;
  int? operatingIncome;
  double? operatingIncomeRatio;
  int? totalOtherIncomeExpensesNet;
  int? incomeBeforeTax;
  double? incomeBeforeTaxRatio;
  int? incomeTaxExpense;
  int? netIncome;
  double? netIncomeRatio;
  double? eps;
  double? epsdiluted;
  int? weightedAverageShsOut;
  int? weightedAverageShsOutDil;
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
        revenue: json["revenue"],
        costOfRevenue: json["costOfRevenue"],
        grossProfit: json["grossProfit"],
        grossProfitRatio: json["grossProfitRatio"].toDouble(),
        researchAndDevelopmentExpenses: json["researchAndDevelopmentExpenses"],
        generalAndAdministrativeExpenses:
            json["generalAndAdministrativeExpenses"],
        sellingAndMarketingExpenses: json["sellingAndMarketingExpenses"],
        sellingGeneralAndAdministrativeExpenses:
            json["sellingGeneralAndAdministrativeExpenses"],
        otherExpenses: json["otherExpenses"],
        operatingExpenses: json["operatingExpenses"],
        costAndExpenses: json["costAndExpenses"],
        interestIncome: json["interestIncome"],
        interestExpense: json["interestExpense"],
        depreciationAndAmortization: json["depreciationAndAmortization"],
        ebitda: json["ebitda"],
        ebitdaratio: json["ebitdaratio"].toDouble(),
        operatingIncome: json["operatingIncome"],
        operatingIncomeRatio: json["operatingIncomeRatio"].toDouble(),
        totalOtherIncomeExpensesNet: json["totalOtherIncomeExpensesNet"],
        incomeBeforeTax: json["incomeBeforeTax"],
        incomeBeforeTaxRatio: json["incomeBeforeTaxRatio"].toDouble(),
        incomeTaxExpense: json["incomeTaxExpense"],
        netIncome: json["netIncome"],
        netIncomeRatio: json["netIncomeRatio"].toDouble(),
        eps: json["eps"].toDouble(),
        epsdiluted: json["epsdiluted"].toDouble(),
        weightedAverageShsOut: json["weightedAverageShsOut"],
        weightedAverageShsOutDil: json["weightedAverageShsOutDil"],
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
        "revenue": revenue,
        "costOfRevenue": costOfRevenue,
        "grossProfit": grossProfit,
        "grossProfitRatio": grossProfitRatio,
        "researchAndDevelopmentExpenses": researchAndDevelopmentExpenses,
        "generalAndAdministrativeExpenses": generalAndAdministrativeExpenses,
        "sellingAndMarketingExpenses": sellingAndMarketingExpenses,
        "sellingGeneralAndAdministrativeExpenses":
            sellingGeneralAndAdministrativeExpenses,
        "otherExpenses": otherExpenses,
        "operatingExpenses": operatingExpenses,
        "costAndExpenses": costAndExpenses,
        "interestIncome": interestIncome,
        "interestExpense": interestExpense,
        "depreciationAndAmortization": depreciationAndAmortization,
        "ebitda": ebitda,
        "ebitdaratio": ebitdaratio,
        "operatingIncome": operatingIncome,
        "operatingIncomeRatio": operatingIncomeRatio,
        "totalOtherIncomeExpensesNet": totalOtherIncomeExpensesNet,
        "incomeBeforeTax": incomeBeforeTax,
        "incomeBeforeTaxRatio": incomeBeforeTaxRatio,
        "incomeTaxExpense": incomeTaxExpense,
        "netIncome": netIncome,
        "netIncomeRatio": netIncomeRatio,
        "eps": eps,
        "epsdiluted": epsdiluted,
        "weightedAverageShsOut": weightedAverageShsOut,
        "weightedAverageShsOutDil": weightedAverageShsOutDil,
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
