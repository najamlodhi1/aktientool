// https://app.quicktype.io/
// https://financialmodelingprep.com/api/v4/score?symbol=AAPL&apikey=${APIKEY1}

import 'dart:convert';

List<Post?>? postFromJson(String str) => json.decode(str) == null
    ? []
    : List<Post?>.from(json.decode(str)!.map((x) => Post.fromJson(x)));

String postToJson(List<Post?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class Post {
  Post({
    this.symbol,
    this.altmanZScore,
    this.piotroskiScore,
    this.workingCapital,
    this.totalAssets,
    this.retainedEarnings,
    this.ebit,
    this.marketCap,
    this.totalLiabilities,
    this.revenue,
  });

  String? symbol;
  double? altmanZScore;
  int? piotroskiScore;
  String? workingCapital;
  String? totalAssets;
  String? retainedEarnings;
  String? ebit;
  String? marketCap;
  String? totalLiabilities;
  String? revenue;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        symbol: json["symbol"],
        altmanZScore: json["altmanZScore"].toDouble(),
        piotroskiScore: json["piotroskiScore"],
        workingCapital: json["workingCapital"],
        totalAssets: json["totalAssets"],
        retainedEarnings: json["retainedEarnings"],
        ebit: json["ebit"],
        marketCap: json["marketCap"],
        totalLiabilities: json["totalLiabilities"],
        revenue: json["revenue"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "altmanZScore": altmanZScore,
        "piotroskiScore": piotroskiScore,
        "workingCapital": workingCapital,
        "totalAssets": totalAssets,
        "retainedEarnings": retainedEarnings,
        "ebit": ebit,
        "marketCap": marketCap,
        "totalLiabilities": totalLiabilities,
        "revenue": revenue,
      };
}
