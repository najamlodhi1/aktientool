class CompanyModel {
  double? beta;
  String? isetf;
  double? price;
  String? sector;
  String? symbol;
  int? volume;
  String? country;
  String? exchange;
  String? industry;
  double? marketcap;
  String? companyname;
  String? exchangeshortname;
  String? isactivelytrading;
  double? lastannualdividend;

  //String? apexSyncStepStaticId;
  //String? apexRowSyncTimestamp;

  CompanyModel({
    this.beta,
    this.isetf,
    this.price,
    this.sector,
    this.symbol,
    this.volume,
    this.country,
    this.exchange,
    this.industry,
    this.marketcap,
    this.companyname,
    this.exchangeshortname,
    this.isactivelytrading,
    this.lastannualdividend,
    //this.apexSyncStepStaticId,
    //this.apexRowSyncTimestamp,
  });

  CompanyModel.fromJson(Map<String, dynamic> json) {
    beta = json['beta'] ?? "";
    isetf = json['isetf'] ?? "";
    price = json['price'] ?? "";
    sector = json['sector'] ?? "";
    symbol = json['symbol'] ?? "";
    volume = json['volume'] ?? "";
    country = json['country'] ?? "";
    exchange = json['exchange'] ?? "";
    industry = json['industry'] ?? "";
    marketcap = json['marketcap'] ?? "";
    companyname = json['companyname'] ?? "";
    exchangeshortname = json['exchangeshortname'] ?? "";
    isactivelytrading = json['isactivelytrading'] ?? "";
    lastannualdividend = json['lastannualdividend'] ?? "";
    //apexSyncStepStaticId = json['apex\$sync_step_static_id'] ?? "";
    //apexRowSyncTimestamp = json['apex\$row_sync_timestamp'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['beta'] = beta;
    data['isetf'] = isetf;
    data['price'] = price;
    data['sector'] = sector;
    data['symbol'] = symbol;
    data['volume'] = volume;
    data['country'] = country;
    data['exchange'] = exchange;
    data['industry'] = industry;
    data['marketcap'] = marketcap;
    data['companyname'] = companyname;
    data['exchangeshortname'] = exchangeshortname;
    data['isactivelytrading'] = isactivelytrading;
    data['lastannualdividend'] = lastannualdividend;
    //data['apex\$sync_step_static_id'] = apexSyncStepStaticId ?? "";
    //data['apex\$row_sync_timestamp'] = apexRowSyncTimestamp ?? "";
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol ?? "",
      'companyName': companyname ?? "",
      'marketCap': marketcap ?? "",
      'sector': sector ?? "",
      'industry': industry ?? "",
      'beta': beta ?? "",
      'price': price ?? "",
      'lastAnnualDividend': lastannualdividend ?? "",
      'volume': volume ?? "",
      'exchange': exchange ?? "",
      'exchangeShortName': exchangeshortname ?? "",
      'country': country ?? "",
      'isEtf': isetf ?? "",
      'isActivelyTrading': isactivelytrading ?? "",
      //'apex\$sync_step_static_id': apexRowSyncTimestamp ?? "",
      // 'apex\$row_sync_timestamp': apexRowSyncTimestamp ?? "",
    };
  }
}

class Company {
  String? symbol;
  String? companyName;
  double? marketCap;
  String? sector;
  String? industry;

  //double? beta;
  double? price;
  double? lastAnnualDividend;

  //int? volume;
  //String? exchange;
  String? exchangeShortName;
  String? country;
  bool? isEtf;

  //bool? isActivelyTrading;

  Company({
    this.symbol,
    this.companyName,
    this.marketCap,
    this.sector,
    this.industry,
    //this.beta,
    this.price,
    this.lastAnnualDividend,
    //this.volume,
    //this.exchange,
    this.exchangeShortName,
    this.country,
    this.isEtf,
    //this.isActivelyTrading,
  });

  Company.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    companyName = json['companyName'];
    marketCap = json['marketCap'];
    sector = json['sector'];
    industry = json['industry'];
    //beta = json['beta'];
    price = json['price'];
    lastAnnualDividend = json['lastAnnualDividend'];
    //volume = json['volume'];
    //exchange = json['exchange'];
    exchangeShortName = json['exchangeShortName'];
    country = json['country'];
    isEtf = json['isEtf'];
    //isActivelyTrading = json['isActivelyTrading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['companyName'] = companyName;
    data['marketCap'] = marketCap;
    data['sector'] = sector;
    data['industry'] = industry;
    //data['beta'] = beta;
    data['price'] = price;
    data['lastAnnualDividend'] = lastAnnualDividend;
    //data['volume'] = volume;
    //data['exchange'] = exchange;
    data['exchangeShortName'] = exchangeShortName;
    data['country'] = country;
    data['isEtf'] = isEtf;
    //data['isActivelyTrading'] = isActivelyTrading;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'companyName': companyName,
      'marketCap': marketCap,
      'sector': sector,
      'industry': industry,
      //'beta': beta,
      'price': price,
      'lastAnnualDividend': lastAnnualDividend,
      //'volume': volume,
      //'exchange': exchange,
      'exchangeShortName': exchangeShortName,
      'country': country,
      'isEtf': isEtf,
      //'isActivelyTrading': isActivelyTrading,
    };
  }
}
