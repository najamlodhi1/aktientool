// ignore_for_file: file_names

class InsiderModel {
  final String filingDate;
  final String transactionDate;
  final String reportingCik;
  final String transactionType;
  final int securitiesOwned;
  final String companyCik;
  final String reportingName;
  final String typeOfOwner;
  final String acquistionOrDisposition;
  final String formType;
  final int securitiesTransacted;
  final double price;
  final String securityName;

  factory InsiderModel.fromJson(Map<String, dynamic> json) => InsiderModel(
      filingDate: json["filingDate"],
      transactionDate: json["transactionDate"],
      reportingCik: json["reportingCik"],
      transactionType: json["transactionType"],
      securitiesOwned: json["securitiesOwned"],
      companyCik: json["companyCik"],
      reportingName: json["reportingName"],
      typeOfOwner: json["typeOfOwner"],
      acquistionOrDisposition: json["acquistionOrDisposition"],
      formType: json["formType"],
      securitiesTransacted: json["securitiesTransacted"],
      price: json["price"],
      securityName: json["securityName"]);

  InsiderModel(
      {required this.filingDate,
      required this.transactionDate,
      required this.reportingCik,
      required this.transactionType,
      required this.securitiesOwned,
      required this.companyCik,
      required this.reportingName,
      required this.typeOfOwner,
      required this.acquistionOrDisposition,
      required this.formType,
      required this.securitiesTransacted,
      required this.price,
      required this.securityName});
}
