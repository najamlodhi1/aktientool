import 'CompanyModel.dart';

class CompanyService {
  Future<List<DividendModel>> getData(dynamic data) async {
    List<DividendModel> temp = parseData(data);
    temp.removeWhere((element) =>
        element.recordDate == "" ||
        //element.declarationDate == "" ||
        element.paymentDate == "");
    return temp;
  }

  List<DividendModel> parseData(dynamic res) {
    final parsed = res["historical"].cast<Map<String, dynamic>>();
    return parsed.map<DividendModel>((e) => DividendModel.fromJson(e)).toList();
  }
}
