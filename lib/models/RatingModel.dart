class RatingModel {
  final String symbol;
  final String date;
  final String rating;
  final int ratingScore;
  final String ratingRecommendation;
  final int ratingDetailsDCFScore;
  final String ratingDetailsDCFRecommendation;
  final int ratingDetailsROEScore;
  final String ratingDetailsROERecommendation;
  final int ratingDetailsROAScore;
  final String ratingDetailsROARecommendation;
  final int ratingDetailsDEScore;
  final String ratingDetailsDERecommendation;
  final int ratingDetailsPEScore;
  final String ratingDetailsPERecommendation;
  final int ratingDetailsPBScore;
  final String ratingDetailsPBRecommendation;

  RatingModel(
      {required this.symbol,
      required this.date,
      required this.rating,
      required this.ratingScore,
      required this.ratingRecommendation,
      required this.ratingDetailsDCFScore,
      required this.ratingDetailsDCFRecommendation,
      required this.ratingDetailsROEScore,
      required this.ratingDetailsROERecommendation,
      required this.ratingDetailsROAScore,
      required this.ratingDetailsROARecommendation,
      required this.ratingDetailsDEScore,
      required this.ratingDetailsDERecommendation,
      required this.ratingDetailsPEScore,
      required this.ratingDetailsPERecommendation,
      required this.ratingDetailsPBScore,
      required this.ratingDetailsPBRecommendation});

  factory RatingModel.fromJson(Map json) => RatingModel(
      symbol: json["symbol"],
      date: json["date"],
      rating: json["rating"],
      ratingScore: json["ratingScore"],
      ratingRecommendation: json["ratingRecommendation"],
      ratingDetailsDCFScore: json["ratingDetailsDCFScore"],
      ratingDetailsDCFRecommendation: json["ratingDetailsDCFRecommendation"],
      ratingDetailsROEScore: json["ratingDetailsROEScore"],
      ratingDetailsROERecommendation: json["ratingDetailsROERecommendation"],
      ratingDetailsROAScore: json["ratingDetailsROAScore"],
      ratingDetailsROARecommendation: json["ratingDetailsROARecommendation"],
      ratingDetailsDEScore: json["ratingDetailsDEScore"],
      ratingDetailsDERecommendation: json["ratingDetailsDERecommendation"],
      ratingDetailsPEScore: json["ratingDetailsPEScore"],
      ratingDetailsPERecommendation: json["ratingDetailsPERecommendation"],
      ratingDetailsPBScore: json["ratingDetailsPBScore"],
      ratingDetailsPBRecommendation: json["ratingDetailsPBRecommendation"]);
}
