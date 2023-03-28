// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<Post> postFromJson(var str) =>
    List<Post>.from((str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.date,
    required this.company,
    required this.symbol,
    required this.exchange,
    required this.actions,
    this.shares,
    this.priceRange,
    this.marketCap,
  });

  DateTime date;
  String company;
  String symbol;
  String exchange;
  Actions actions;
  int? shares;
  String? priceRange;
  double? marketCap;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        date: DateTime.parse(json["date"]),
        company: json["company"],
        symbol: json["symbol"],
        exchange: json["exchange"],
        actions: actionsValues.map[json["actions"]]!,
        shares: json["shares"],
        priceRange: json["priceRange"],
        marketCap: json["marketCap"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "company": company,
        "symbol": symbol,
        "exchange": exchange,
        "actions": actionsValues.reverse[actions],
        "shares": shares,
        "priceRange": priceRange,
        "marketCap": marketCap,
      };
}

enum Actions { EXPECTED, PRICED, FILED, AMENDED, ACTIONS_PRICED }

final actionsValues = EnumValues({
  "Priced": Actions.ACTIONS_PRICED,
  "Amended": Actions.AMENDED,
  "Expected": Actions.EXPECTED,
  "Filed": Actions.FILED,
  "priced": Actions.PRICED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
