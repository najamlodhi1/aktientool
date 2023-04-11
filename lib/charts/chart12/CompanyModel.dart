// ignore_for_file: file_names

class DividendModel {
  //final String declarationDate;
  final String recordDate;
  final String paymentDate;
  final String dividend;

  DividendModel(
      {
      //required this.declarationDate,
      required this.recordDate,
      required this.paymentDate,
      required this.dividend});

  factory DividendModel.fromJson(Map<String, dynamic> json) => DividendModel(
      //declarationDate: json['declarationDate'],
      recordDate: json['recordDate'],
      paymentDate: json['paymentDate'],
      dividend: json['dividend'].toString());
}
