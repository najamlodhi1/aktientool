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
    required this.holder,
    required this.shares,
    required this.dateReported,
    required this.change,
  });

  String holder;
  int shares;
  DateTime dateReported;
  int change;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        holder: json["holder"],
        shares: json["shares"],
        dateReported: DateTime.parse(json["dateReported"]),
        change: json["change"],
      );

  Map<String, dynamic> toJson() => {
        "holder": holder,
        "shares": shares,
        "dateReported":
            "${dateReported.year.toString().padLeft(4, '0')}-${dateReported.month.toString().padLeft(2, '0')}-${dateReported.day.toString().padLeft(2, '0')}",
        "change": change,
      };
}
