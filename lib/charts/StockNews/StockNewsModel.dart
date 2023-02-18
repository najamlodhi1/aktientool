class StockNewsModel {
  final String title;
  final String image;
  final String site;
  final String text;
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
