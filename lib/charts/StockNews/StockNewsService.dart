import 'package:aktientool/charts/allCharts.dart';
import 'package:translator/translator.dart';
import '../../main.dart';
import 'StockNewsModel.dart';

class StockNewsService {
  var translator = GoogleTranslator();

  Future<List<StockNewsModel>> getData(dynamic data) async {
    List<StockNewsModel> temp = parseData(data);
    if (selectedLocale.languageCode == 'de' && newsData == null) {
      for (var i = 0; i < temp.length; i++) {
        temp[i].title = await translator
            .translate(temp[i].title, to: 'de')
            .then((value) => value.text);
        temp[i].text = await translator
            .translate(temp[i].text, to: 'de')
            .then((value) => value.text);
      }
    }
    if (newsData != null) {
      return newsData;
    }
    return temp;
  }

  List<StockNewsModel> parseData(dynamic res) {
    final parsed = res.cast<Map<String, dynamic>>();
    return parsed
        .map<StockNewsModel>((e) => StockNewsModel.fromJson(e))
        .toList();
  }
}
