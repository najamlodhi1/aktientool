import 'package:intl/intl.dart';

class InstitutionalholdersModel {
  double ownership;
  final String holder;
  final int shares;
  final String dateReported;
  final int change;

  InstitutionalholdersModel(
      {required this.shares,
      required this.dateReported,
      required this.holder,
      required this.change,
      this.ownership = 0});

  factory InstitutionalholdersModel.fromJson(Map<String, dynamic> json) =>
      InstitutionalholdersModel(
          holder: json['holder'],
          shares: json['shares'],
          dateReported: json['dateReported'],
          change: json['change']);
}
