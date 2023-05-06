/*
      "symbol": "GOOG",
      "price": 105.635,
      "beta": 1.099653,
      "volAvg": 30984008,
      "mktCap": 1337835567704,
      "changes": -0.485,
      "companyName": "Alphabet Inc.",
      "currency": "USD",
      "exchangeShortName": "NASDAQ",
      "industry": "Internet Content & Information",
      "sector": "Communication Services",
      "country": "US",
      "fullTimeEmployees": "190711",
      "image": "https://financialmodelingprep.com/image-stock/GOOG.png",
      "isEtf": false,
      "isFund": false,
      "dividendYielTTM": 0,
      "dividendYielPercentageTTM": 0,
      "peRatioTTM": 23.044718708928603,
      "pegRatioTTM": -1.1920404495800336,
      "payoutRatioTTM": 0,
      "currentRatioTTM": 2.35258663258489,
      "quickRatioTTM": 2.1950503964911263,
      "cashRatioTTM": 0.3765068115142185,
      "daysOfSalesOutstandingTTM": 46.21428471041277,
      "daysOfInventoryOutstandingTTM": 6.642049742170796,
      "operatingCycleTTM": 18.03735282145066,
      "daysOfPayablesOutstandingTTM": 12.004464847189034,
      "cashConversionCycleTTM": 35.84758555307407,
      "grossProfitMarginTTM": 0.5530195494216688,
      "operatingProfitMarginTTM": 0.2535486908492966,
      "pretaxProfitMarginTTM": 0.24805349036583138,
      "netProfitMarginTTM": 0.20584866414627634,
      "effectiveTaxRateTTM": 0.17014405303191263,
      "returnOnAssetsTTM": 0.15856137226617156,
      "returnOnEquityTTM": 0.2283908806597517,
      "returnOnCapitalEmployedTTM": 0.24003366185798822,
      "netIncomePerEBTTTM": 0.8298559469680874,
      "ebtPerEbitTTM": 0.9783268433962002,
      "ebitPerRevenueTTM": 0.2535486908492966,
      "debtRatioTTM": 0.2939097298716342,
      "debtEquityRatioTTM": 0.10155848735501774,
      "longTermDebtToCapitalizationTTM": 0.09219527471380354,
      "totalDebtToCapitalizationTTM": 0.09219527471380354,
      "interestCoverageTTM": 203.8502824858757,
      "cashFlowToDebtRatioTTM": 3.392889492753623,
      "companyEquityMultiplierTTM": 1.4162495112957754,
      "receivablesTurnoverTTM": 7.897990897990898,
      "payablesTurnoverTTM": 30.405353728489484,
      "inventoryTurnoverTTM": 54.95291576673866,
      "fixedAssetTurnoverTTM": 2.1560371798465234,
      "assetTurnoverTTM": 0.7702812788403507,
      "operatingCashFlowPerShareTTM": 7.033721930991315,
      "freeCashFlowPerShareTTM": 4.843908927313982,
      "cashPerShareTTM": 9.005711603160941,
      "operatingCashFlowSalesRatioTTM": 0.3158615940297668,
      "freeCashFlowOperatingCashFlowRatioTTM": 0.6886693808538565,
      "cashFlowCoverageRatiosTTM": 3.392889492753623,
      "shortTermCoverageRatiosTTM": 0,
      "capitalExpenditureCoverageRatioTTM": 3.2120194369015294,
      "dividendPaidAndCapexCoverageRatioTTM": 3.2120194369015294,
      "priceBookValueRatioTTM": 5.1749788611466725,
      "priceToBookRatioTTM": 5.1749788611466725,
      "priceToSalesRatioTTM": 4.743724561859654,
      "priceEarningsRatioTTM": 23.044718708928603,
      "priceToFreeCashFlowsRatioTTM": 21.609361455403004,
      "priceToOperatingCashFlowsRatioTTM": 15.0183645353623,
      "priceCashFlowRatioTTM": 15.0183645353623,
      "priceEarningsToGrowthRatioTTM": -1.3776183491930956,
      "priceSalesRatioTTM": 4.743724561859654,
      "dividendYieldTTM": 0,
      "enterpriseValueMultipleTTM": 14.683263804203175,
      "priceFairValueTTM": 5.1749788611466725,
      "dividendPerShareTTM": 0,
      "ratingRecommendation": "Buy",
      "ratingDetailsDCFRecommendation": "Strong Buy",
      "ratingDetailsROERecommendation": "Neutral",
      "ratingDetailsROARecommendation": "Neutral",
      "ratingDetailsDERecommendation": "Neutral",
      "ratingDetailsPERecommendation": "Strong Buy",
      "ratingDetailsPBRecommendation": "Strong Buy",
      "eps": 4.59,
      "performance1y": -13.80787

*/

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
  double? mktCap;
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
    this.mktCap,
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
    mktCap = json['mktCap'] ?? "";
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
    data['mktCap'] = mktCap;
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
      'mktCap': mktCap ?? "",
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
  double? mktCap;
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
    this.mktCap,
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
    mktCap = json['mktCap'];
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
    data['mktCap'] = mktCap;
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
      'mktCap': mktCap,
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
