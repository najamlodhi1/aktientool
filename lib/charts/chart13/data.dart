import 'package:aktientool/charts/chart13/post.dart';

var companyInfo = <Post>[];

class RemoteService {
  Future getData(dynamic data) async {
    var posts = postFromJson(data);

    companyInfo.clear();
    companyInfo = posts;

    if (companyInfo.isEmpty) {
      return null;
    } else {
      return companyInfo;
    }
  }
}

List get companyData {
  return companyInfo;
}
