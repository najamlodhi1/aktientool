class ScoreModel {
  final double altmanZScore;
  final double piotroskiScore;

  ScoreModel({required this.altmanZScore, required this.piotroskiScore});

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
      altmanZScore: json['altmanZScore'],
      piotroskiScore: json['piotroskiScore']);
}
