// https://financialmodelingprep.com/api/v3/profile/PLTR?apikey=9ad9c8dfa54c11aff6c1489d109e87b6

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.symbol,
    required this.historical,
  });

  String symbol;
  List<Historical> historical;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        symbol: json["symbol"],
        historical: List<Historical>.from(
            json["historical"].map((x) => Historical.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "historical": List<dynamic>.from(historical.map((x) => x.toJson())),
      };
}

class Historical {
  Historical({
    required this.date,
    required this.label,
    required this.adjDividend,
    required this.dividend,
    required this.recordDate,
    required this.paymentDate,
    required this.declarationDate,
  });

  DateTime date;
  String label;
  double adjDividend;
  double dividend;
  String recordDate;
  String paymentDate;
  String declarationDate;

  factory Historical.fromJson(Map<String, dynamic> json) => Historical(
        date: DateTime.parse(json["date"]),
        label: json["label"],
        adjDividend: json["adjDividend"]?.toDouble(),
        dividend: json["dividend"]?.toDouble(),
        recordDate: json["recordDate"],
        paymentDate: json["paymentDate"],
        declarationDate: json["declarationDate"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "label": label,
        "adjDividend": adjDividend,
        "dividend": dividend,
        "recordDate": recordDate,
        "paymentDate": paymentDate,
        "declarationDate": declarationDate,
      };
}
