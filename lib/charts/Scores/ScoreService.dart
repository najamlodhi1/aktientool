import 'package:aktientool/charts/Scores/ScoreModel.dart';

class ScoreService {
  Future<ScoreModel> getData(dynamic data) async {
    List<ScoreModel> temp = parseData(data);
    return temp[0];
  }

  List<ScoreModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed.map<ScoreModel>((e) => ScoreModel.fromJson(e)).toList();
  }
}
