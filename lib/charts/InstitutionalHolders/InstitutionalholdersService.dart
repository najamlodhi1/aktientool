import 'InstitutionalholdersModel.dart';

class InstitutionalholdersService {
  Future<List<InstitutionalholdersModel>> getData(dynamic data) async {
    List<InstitutionalholdersModel> temp = parseData(data);
    return temp;
  }

  List<InstitutionalholdersModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<InstitutionalholdersModel>(
            (e) => InstitutionalholdersModel.fromJson(e))
        .toList();
  }

  double getShareFloat(dynamic data) {
    final parsed = data.cast<Map<String, dynamic>>();
    return parsed[0]["outstandingShares"];
  }
}
