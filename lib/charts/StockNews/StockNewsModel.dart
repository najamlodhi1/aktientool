// ignore_for_file: file_names

class StockNewsModel {
  String title;
  final String image;
  final String site;
  String text;
  final String url;
  final String publishedDate;

  StockNewsModel(
      {required this.site,
      required this.text,
      required this.image,
      required this.url,
      required this.title,
      required this.publishedDate});

  factory StockNewsModel.fromJson(Map<String, dynamic> json) => StockNewsModel(
      title: json['title'],
      image: json['image'],
      site: json['site'],
      text: json['text'],
      publishedDate: json['publishedDate'],
      url: json['url']);
}
