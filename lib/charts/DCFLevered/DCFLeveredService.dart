import 'package:aktientool/charts/DCFLevered/DCFLeveredModel.dart';

class DCFLeveredService {
  Future<List<DCFLeveredModel>> getData(dynamic data) async {
    List<DCFLeveredModel> temp = parseData(data);
    temp.sort((a, b) => a.year.compareTo(b.year));
    return temp;
  }

  List<DCFLeveredModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<DCFLeveredModel>((e) => DCFLeveredModel.fromJson(e))
        .toList();
  }
}
