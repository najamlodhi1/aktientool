import 'ConcensusModel.dart';

class ConcensusService {
  Future<ConcensusModel?> getData(dynamic data) async {
    List<ConcensusModel> temp = parseData(data);
    return temp.isNotEmpty ? temp[0] : null;
  }

  List<ConcensusModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<ConcensusModel>((e) => ConcensusModel.fromJson(e))
        .toList();
  }
}
