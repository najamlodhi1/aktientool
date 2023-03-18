// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(dynamic str) => Post.fromJson(str);

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
    required this.close,
  });

  DateTime date;
  double close;

  factory Historical.fromJson(Map<String, dynamic> json) => Historical(
        date: DateTime.parse(json["date"]),
        close: json["close"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "close": close,
      };
}
