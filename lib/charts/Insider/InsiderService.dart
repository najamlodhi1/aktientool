import 'InsiderModel.dart';

class InsiderService {
  Future<List<InsiderModel>> getData(dynamic data) async {
    return parseData(data);
  }

  List<InsiderModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed.map<InsiderModel>((e) => InsiderModel.fromJson(e)).toList();
  }
}
