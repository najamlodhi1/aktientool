class ESGScoreModel {
  final String cik;
  final String companyName;
  final String formType;
  final String acceptedDate;
  final String date;
  final String year;
  final double environmentalScore;
  final double socialScore;
  final double governanceScore;
  final double ESGScore;

  ESGScoreModel(
      {required this.cik,
      required this.companyName,
      required this.formType,
      required this.acceptedDate,
      required this.date,
      required this.environmentalScore,
      required this.socialScore,
      required this.governanceScore,
      required this.ESGScore,
      required this.year});

  factory ESGScoreModel.fromJson(Map<String, dynamic> json) => ESGScoreModel(
      cik: json["cik"],
      companyName: json["companyName"],
      formType: json["formType"],
      acceptedDate: json["acceptedDate"],
      date: json["date"],
      environmentalScore: json["environmentalScore"],
      socialScore: json["socialScore"],
      governanceScore: json["governanceScore"],
      ESGScore: json["ESGScore"],
      year: json["date"].toString().split('-').first);
}
