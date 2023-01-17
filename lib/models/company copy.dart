// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

List<CompanyModel?>? companyModelFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<CompanyModel?>.from(
            json.decode(str)!.map((x) => CompanyModel.fromJson(x)));

String companyModelToJson(List<CompanyModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class CompanyModel {
  CompanyModel({
    this.symbol,
    this.companyName,
    this.marketCap,
    this.sector,
    this.industry,
    this.beta,
    this.price,
    this.lastAnnualDividend,
    this.volume,
    this.exchange,
    this.exchangeShortName,
    this.country,
    this.isEtf,
    this.isActivelyTrading,
  });

  String? symbol;
  String? companyName;
  int? marketCap;
  Sector? sector;
  String? industry;
  double? beta;
  double? price;
  double? lastAnnualDividend;
  int? volume;
  Exchange? exchange;
  ExchangeShortName? exchangeShortName;
  Country? country;
  bool? isEtf;
  bool? isActivelyTrading;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        symbol: json["symbol"],
        companyName: json["companyName"],
        marketCap: json["marketCap"],
        sector: sectorValues.map[json["sector"]],
        industry: json["industry"],
        beta: json["beta"].toDouble(),
        price: json["price"].toDouble(),
        lastAnnualDividend: json["lastAnnualDividend"].toDouble(),
        volume: json["volume"],
        exchange: exchangeValues.map[json["exchange"]],
        exchangeShortName:
            exchangeShortNameValues.map[json["exchangeShortName"]],
        country: countryValues.map[json["country"]],
        isEtf: json["isEtf"],
        isActivelyTrading: json["isActivelyTrading"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "companyName": companyName,
        "marketCap": marketCap,
        "sector": sectorValues.reverse![sector],
        "industry": industry,
        "beta": beta,
        "price": price,
        "lastAnnualDividend": lastAnnualDividend,
        "volume": volume,
        "exchange": exchangeValues.reverse![exchange],
        "exchangeShortName":
            exchangeShortNameValues.reverse![exchangeShortName],
        "country": countryValues.reverse![country],
        "isEtf": isEtf,
        "isActivelyTrading": isActivelyTrading,
      };
}

enum Country {
  CA,
  US,
  KY,
  FR,
  HK,
  NL,
  BR,
  IL,
  GB,
  MY,
  SG,
  IS,
  CN,
  IE,
  MX,
  BM,
  AE,
  MT,
  DE,
  BE,
  KZ,
  IN,
  SE,
  CY,
  CH,
  LU,
  GR,
  TH,
  RU,
  AU,
  MC,
  GI
}

final countryValues = EnumValues({
  "AE": Country.AE,
  "AU": Country.AU,
  "BE": Country.BE,
  "BM": Country.BM,
  "BR": Country.BR,
  "CA": Country.CA,
  "CH": Country.CH,
  "CN": Country.CN,
  "CY": Country.CY,
  "DE": Country.DE,
  "FR": Country.FR,
  "GB": Country.GB,
  "GI": Country.GI,
  "GR": Country.GR,
  "HK": Country.HK,
  "IE": Country.IE,
  "IL": Country.IL,
  "IN": Country.IN,
  "IS": Country.IS,
  "KY": Country.KY,
  "KZ": Country.KZ,
  "LU": Country.LU,
  "MC": Country.MC,
  "MT": Country.MT,
  "MX": Country.MX,
  "MY": Country.MY,
  "NL": Country.NL,
  "RU": Country.RU,
  "SE": Country.SE,
  "SG": Country.SG,
  "TH": Country.TH,
  "US": Country.US
});

enum Exchange {
  TORONTO_STOCK_EXCHANGE,
  NEW_YORK_STOCK_EXCHANGE_ARCA,
  NASDAQ_CAPITAL_MARKET,
  NASDAQ_GLOBAL_SELECT,
  NASDAQ_GLOBAL_MARKET,
  NEW_YORK_STOCK_EXCHANGE,
  NASDAQ,
  PARIS,
  CANADIAN_SEC,
  EXCHANGE_NASDAQ_CAPITAL_MARKET,
  EXCHANGE_NASDAQ_GLOBAL_SELECT,
  AMERICAN_STOCK_EXCHANGE,
  NASDAQ_GS,
  SO_PAULO,
  NCM,
  SES,
  BRUSSELS,
  EXCHANGE_NASDAQ,
  FRANKFURT
}

final exchangeValues = EnumValues({
  "American Stock Exchange": Exchange.AMERICAN_STOCK_EXCHANGE,
  "Brussels": Exchange.BRUSSELS,
  "Canadian Sec": Exchange.CANADIAN_SEC,
  "NASDAQ": Exchange.EXCHANGE_NASDAQ,
  "Nasdaq Capital Market": Exchange.EXCHANGE_NASDAQ_CAPITAL_MARKET,
  "NASDAQ Global Select": Exchange.EXCHANGE_NASDAQ_GLOBAL_SELECT,
  "Frankfurt": Exchange.FRANKFURT,
  "Nasdaq": Exchange.NASDAQ,
  "NASDAQ Capital Market": Exchange.NASDAQ_CAPITAL_MARKET,
  "NASDAQ Global Market": Exchange.NASDAQ_GLOBAL_MARKET,
  "Nasdaq Global Select": Exchange.NASDAQ_GLOBAL_SELECT,
  "NasdaqGS": Exchange.NASDAQ_GS,
  "NCM": Exchange.NCM,
  "New York Stock Exchange": Exchange.NEW_YORK_STOCK_EXCHANGE,
  "New York Stock Exchange Arca": Exchange.NEW_YORK_STOCK_EXCHANGE_ARCA,
  "Paris": Exchange.PARIS,
  "SES": Exchange.SES,
  "São Paulo": Exchange.SO_PAULO,
  "Toronto Stock Exchange": Exchange.TORONTO_STOCK_EXCHANGE
});

enum ExchangeShortName { TSX, AMEX, NASDAQ, NYSE, EURONEXT }

final exchangeShortNameValues = EnumValues({
  "AMEX": ExchangeShortName.AMEX,
  "EURONEXT": ExchangeShortName.EURONEXT,
  "NASDAQ": ExchangeShortName.NASDAQ,
  "NYSE": ExchangeShortName.NYSE,
  "TSX": ExchangeShortName.TSX
});

enum Sector {
  EMPTY,
  FINANCIAL_SERVICES,
  TECHNOLOGY,
  BASIC_MATERIALS,
  COMMUNICATION_SERVICES,
  UTILITIES,
  HEALTHCARE,
  REAL_ESTATE,
  INDUSTRIALS,
  ENERGY,
  CONSUMER_CYCLICAL,
  N_A,
  SERVICES,
  CONSUMER_DEFENSIVE,
  FINANCIAL
}

final sectorValues = EnumValues({
  "Basic Materials": Sector.BASIC_MATERIALS,
  "Communication Services": Sector.COMMUNICATION_SERVICES,
  "Consumer Cyclical": Sector.CONSUMER_CYCLICAL,
  "Consumer Defensive": Sector.CONSUMER_DEFENSIVE,
  "": Sector.EMPTY,
  "Energy": Sector.ENERGY,
  "Financial": Sector.FINANCIAL,
  "Financial Services": Sector.FINANCIAL_SERVICES,
  "Healthcare": Sector.HEALTHCARE,
  "Industrials": Sector.INDUSTRIALS,
  "N/A": Sector.N_A,
  "Real Estate": Sector.REAL_ESTATE,
  "Services": Sector.SERVICES,
  "Technology": Sector.TECHNOLOGY,
  "Utilities": Sector.UTILITIES
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
