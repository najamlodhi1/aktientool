// https://financialmodelingprep.com/api/v3/profile/PLTR?apikey=${FMPKEY}

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.symbol,
    required this.the1D,
    required this.the5D,
    required this.the1M,
    required this.the3M,
    required this.the6M,
    required this.ytd,
    required this.the1Y,
    required this.the3Y,
    required this.the5Y,
    required this.the10Y,
    required this.max,
  });

  String symbol;
  double the1D;
  double the5D;
  double the1M;
  double the3M;
  double the6M;
  double ytd;
  double the1Y;
  double the3Y;
  double the5Y;
  double the10Y;
  double max;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        symbol: json["symbol"],
        the1D: json["1D"]?.toDouble(),
        the5D: json["5D"]?.toDouble(),
        the1M: json["1M"]?.toDouble(),
        the3M: json["3M"]?.toDouble(),
        the6M: json["6M"]?.toDouble(),
        ytd: json["ytd"]?.toDouble(),
        the1Y: json["1Y"]?.toDouble(),
        the3Y: json["3Y"]?.toDouble(),
        the5Y: json["5Y"]?.toDouble(),
        the10Y: json["10Y"]?.toDouble(),
        max: json["max"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "1D": the1D,
        "5D": the5D,
        "1M": the1M,
        "3M": the3M,
        "6M": the6M,
        "ytd": ytd,
        "1Y": the1Y,
        "3Y": the3Y,
        "5Y": the5Y,
        "10Y": the10Y,
        "max": max,
      };
}
