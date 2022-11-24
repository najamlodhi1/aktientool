class Company {
  String? symbol;
  String? companyName;
  double? marketCap;
  String? sector;
  String? industry;
  double? beta;
  double? price;
  double? lastAnnualDividend;
  int? volume;
  String? exchange;
  String? exchangeShortName;
  String? country;
  bool? isEtf;
  bool? isActivelyTrading;

  Company({
    this.symbol,
    this.companyName,
    this.marketCap,
    this.sector,
    this.industry,
    this.beta,
    this.price,
    this.lastAnnualDividend,
    this.volume,
    this.exchange,
    this.exchangeShortName,
    this.country,
    this.isEtf,
    this.isActivelyTrading,
  });

  Company.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    companyName = json['companyName'];
    marketCap = json['marketCap'];
    sector = json['sector'];
    industry = json['industry'];
    beta = json['beta'];
    price = json['price'];
    lastAnnualDividend = json['lastAnnualDividend'];
    volume = json['volume'];
    exchange = json['exchange'];
    exchangeShortName = json['exchangeShortName'];
    country = json['country'];
    isEtf = json['isEtf'];
    isActivelyTrading = json['isActivelyTrading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['companyName'] = companyName;
    data['marketCap'] = marketCap;
    data['sector'] = sector;
    data['industry'] = industry;
    data['beta'] = beta;
    data['price'] = price;
    data['lastAnnualDividend'] = lastAnnualDividend;
    data['volume'] = volume;
    data['exchange'] = exchange;
    data['exchangeShortName'] = exchangeShortName;
    data['country'] = country;
    data['isEtf'] = isEtf;
    data['isActivelyTrading'] = isActivelyTrading;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'companyName': companyName,
      'marketCap': marketCap,
      'sector': sector,
      'industry': industry,
      'beta': beta,
      'price': price,
      'lastAnnualDividend': lastAnnualDividend,
      'volume': volume,
      'exchange': exchange,
      'exchangeShortName': exchangeShortName,
      'country': country,
      'isEtf': isEtf,
      'isActivelyTrading': isActivelyTrading,
    };
  }
}
