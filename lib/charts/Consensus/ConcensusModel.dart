import 'package:intl/intl.dart';

class ConcensusModel {
  final int strongBuy;
  final int buy;
  final int hold;
  final int sell;
  final int strongSell;
  final String consensus;

  ConcensusModel(
      {required this.strongBuy,
      required this.buy,
      required this.hold,
      required this.sell,
      required this.strongSell,
      required this.consensus});

  factory ConcensusModel.fromJson(Map<String, dynamic> json) => ConcensusModel(
      strongBuy: json['strongBuy'],
      buy: json['buy'],
      hold: json['hold'],
      sell: json['sell'],
      strongSell: json['strongSell'],
      consensus: json['consensus']);
}
