import '../../models/RatingModel.dart';

class RatingService {
  Future<RatingModel?> getData(dynamic data) async {
    List<RatingModel> temp = parseData(data);
    return temp.isNotEmpty ? temp[0] : null;
  }

  List<RatingModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed.map<RatingModel>((e) => RatingModel.fromJson(e)).toList();
  }
}
