import 'StockNewsModel.dart';

class StockNewsService {
  Future<List<StockNewsModel>> getData(dynamic data) async {
    List<StockNewsModel> temp = parseData(data);
    return temp;
  }

  List<StockNewsModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<StockNewsModel>((e) => StockNewsModel.fromJson(e))
        .toList();
  }
}
