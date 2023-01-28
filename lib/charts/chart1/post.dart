// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post? postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post? data) => json.encode(data!.toJson());

class Post {
  Post({
    this.symbol,
    this.historical,
  });

  String? symbol;
  List<Historical?>? historical;

  factory Post.fromJson(json) => Post(
        symbol: json["symbol"],
        historical: json["historical"] == null
            ? []
            : List<Historical?>.from(
                json["historical"]!.map((x) => Historical.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "historical": historical == null
            ? []
            : List<dynamic>.from(historical!.map((x) => x!.toJson())),
      };
}

class Historical {
  Historical({
    this.date,
    this.open,
    this.high,
    this.low,
    this.close,
    this.adjClose,
    this.volume,
    this.unadjustedVolume,
    this.change,
    this.changePercent,
    this.vwap,
    this.label,
    this.changeOverTime,
  });

  DateTime? date;
  double? open;
  double? high;
  double? low;
  double? close;
  double? adjClose;
  double? volume;
  double? unadjustedVolume;
  double? change;
  double? changePercent;
  double? vwap;
  String? label;
  double? changeOverTime;

  factory Historical.fromJson(Map<String, dynamic> json) => Historical(
        date: DateTime.parse(json["date"]),
        open: json["open"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        close: json["close"].toDouble(),
        adjClose: json["adjClose"].toDouble(),
        volume: json["volume"].toDouble(),
        unadjustedVolume: json["unadjustedVolume"].toDouble(),
        change: json["change"].toDouble(),
        changePercent: json["changePercent"].toDouble(),
        vwap: json["vwap"].toDouble(),
        label: json["label"],
        changeOverTime: json["changeOverTime"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "adjClose": adjClose,
        "volume": volume,
        "unadjustedVolume": unadjustedVolume,
        "change": change,
        "changePercent": changePercent,
        "vwap": vwap,
        "label": label,
        "changeOverTime": changeOverTime,
      };
}
