class Income {
  String? date;
  String? symbol;
  String? reportedCurrency;
  String? cik;
  String? fillingDate;
  String? acceptedDate;
  String? calendarYear;
  String? period;
  int? revenue;
  int? costOfRevenue;
  int? grossProfit;
  double? grossProfitRatio;
  int? researchAndDevelopmentExpenses;
  int? generalAndAdministrativeExpenses;
  int? sellingAndMarketingExpenses;
  int? sellingGeneralAndAdministrativeExpenses;
  int? otherExpenses;
  int? operatingExpenses;
  int? costAndExpenses;
  int? interestIncome;
  int? interestExpense;
  int? depreciationAndAmortization;
  int? ebitda;
  double? ebitdaratio;
  int? operatingIncome;
  double? operatingIncomeRatio;
  int? totalOtherIncomeExpensesNet;
  int? incomeBeforeTax;
  double? incomeBeforeTaxRatio;
  int? incomeTaxExpense;
  int? netIncome;
  double? netIncomeRatio;
  double? eps;
  double? epsdiluted;
  int? weightedAverageShsOut;
  int? weightedAverageShsOutDil;
  String? link;
  String? finalLink;

  Income({
    this.date,
    this.symbol,
    this.reportedCurrency,
    this.cik,
    this.fillingDate,
    this.acceptedDate,
    this.calendarYear,
    this.period,
    this.revenue,
    this.costOfRevenue,
    this.grossProfit,
    this.grossProfitRatio,
    this.researchAndDevelopmentExpenses,
    this.generalAndAdministrativeExpenses,
    this.sellingAndMarketingExpenses,
    this.sellingGeneralAndAdministrativeExpenses,
    this.otherExpenses,
    this.operatingExpenses,
    this.costAndExpenses,
    this.interestIncome,
    this.interestExpense,
    this.depreciationAndAmortization,
    this.ebitda,
    this.ebitdaratio,
    this.operatingIncome,
    this.operatingIncomeRatio,
    this.totalOtherIncomeExpensesNet,
    this.incomeBeforeTax,
    this.incomeBeforeTaxRatio,
    this.incomeTaxExpense,
    this.netIncome,
    this.netIncomeRatio,
    this.eps,
    this.epsdiluted,
    this.weightedAverageShsOut,
    this.weightedAverageShsOutDil,
    this.link,
    this.finalLink,
  });

  Income.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    symbol = json['symbol'];
    reportedCurrency = json['reportedCurrency'];
    cik = json['cik'];
    fillingDate = json['fillingDate'];
    acceptedDate = json['acceptedDate'];
    calendarYear = json['calendarYear'];
    period = json['period'];
    revenue = json['revenue'];
    costOfRevenue = json['costOfRevenue'];
    grossProfit = json['grossProfit'];
    grossProfitRatio = json['grossProfitRatio'];
    researchAndDevelopmentExpenses = json['researchAndDevelopmentExpenses'];
    generalAndAdministrativeExpenses = json['generalAndAdministrativeExpenses'];
    sellingAndMarketingExpenses = json['sellingAndMarketingExpenses'];
    sellingGeneralAndAdministrativeExpenses =
        json['sellingGeneralAndAdministrativeExpenses'];
    otherExpenses = json['otherExpenses'];
    operatingExpenses = json['operatingExpenses'];
    costAndExpenses = json['costAndExpenses'];
    interestIncome = json['interestIncome'];
    interestExpense = json['interestExpense'];
    depreciationAndAmortization = json['depreciationAndAmortization'];
    ebitda = json['ebitda'];
    ebitdaratio = json['ebitdaratio'];
    operatingIncome = json['operatingIncome'];
    operatingIncomeRatio = json['operatingIncomeRatio'];
    totalOtherIncomeExpensesNet = json['totalOtherIncomeExpensesNet'];
    incomeBeforeTax = json['incomeBeforeTax'];
    incomeBeforeTaxRatio = json['incomeBeforeTaxRatio'];
    incomeTaxExpense = json['incomeTaxExpense'];
    netIncome = json['netIncome'];
    netIncomeRatio = json['netIncomeRatio'];
    eps = json['eps'];
    epsdiluted = json['epsdiluted'];
    weightedAverageShsOut = json['weightedAverageShsOut'];
    weightedAverageShsOutDil = json['weightedAverageShsOutDil'];
    link = json['link'];
    finalLink = json['finalLink'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'symbol': symbol,
      'reportedCurrency': reportedCurrency,
      'cik': cik,
      'fillingDate': fillingDate,
      'acceptedDate': acceptedDate,
      'calendarYear': calendarYear,
      'period': period,
      'revenue': revenue,
      'costOfRevenue': costOfRevenue,
      'grossProfit': grossProfit,
      'grossProfitRatio': grossProfitRatio,
      'researchAndDevelopmentExpenses': researchAndDevelopmentExpenses,
      'generalAndAdministrativeExpenses': generalAndAdministrativeExpenses,
      'sellingAndMarketingExpenses': sellingAndMarketingExpenses,
      'sellingGeneralAndAdministrativeExpenses':
          sellingGeneralAndAdministrativeExpenses,
      'otherExpenses': otherExpenses,
      'operatingExpenses': operatingExpenses,
      'costAndExpenses': costAndExpenses,
      'interestIncome': interestIncome,
      'interestExpense': interestExpense,
      'depreciationAndAmortization': depreciationAndAmortization,
      'ebitda': ebitda,
      'ebitdaratio': ebitdaratio,
      'operatingIncome': operatingIncome,
      'operatingIncomeRatio': operatingIncomeRatio,
      'totalOtherIncomeExpensesNet': totalOtherIncomeExpensesNet,
      'incomeBeforeTax': incomeBeforeTax,
      'incomeBeforeTaxRatio': incomeBeforeTaxRatio,
      'incomeTaxExpense': incomeTaxExpense,
      'netIncome': netIncome,
      'netIncomeRatio': netIncomeRatio,
      'eps': eps,
      'epsdiluted': epsdiluted,
      'weightedAverageShsOut': weightedAverageShsOut,
      'weightedAverageShsOutDil': weightedAverageShsOutDil,
      'link': link,
      'finalLink': finalLink,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['symbol'] = symbol;
    data['reportedCurrency'] = reportedCurrency;
    data['cik'] = cik;
    data['fillingDate'] = fillingDate;
    data['acceptedDate'] = acceptedDate;
    data['calendarYear'] = calendarYear;
    data['period'] = period;
    data['revenue'] = revenue;
    data['costOfRevenue'] = costOfRevenue;
    data['grossProfit'] = grossProfit;
    data['grossProfitRatio'] = grossProfitRatio;
    data['researchAndDevelopmentExpenses'] = researchAndDevelopmentExpenses;
    data['generalAndAdministrativeExpenses'] = generalAndAdministrativeExpenses;
    data['sellingAndMarketingExpenses'] = sellingAndMarketingExpenses;
    data['sellingGeneralAndAdministrativeExpenses'] =
        sellingGeneralAndAdministrativeExpenses;
    data['otherExpenses'] = otherExpenses;
    data['operatingExpenses'] = operatingExpenses;
    data['costAndExpenses'] = costAndExpenses;
    data['interestIncome'] = interestIncome;
    data['interestExpense'] = interestExpense;
    data['depreciationAndAmortization'] = depreciationAndAmortization;
    data['ebitda'] = ebitda;
    data['ebitdaratio'] = ebitdaratio;
    data['operatingIncome'] = operatingIncome;
    data['operatingIncomeRatio'] = operatingIncomeRatio;
    data['totalOtherIncomeExpensesNet'] = totalOtherIncomeExpensesNet;
    data['incomeBeforeTax'] = incomeBeforeTax;
    data['incomeBeforeTaxRatio'] = incomeBeforeTaxRatio;
    data['incomeTaxExpense'] = incomeTaxExpense;
    data['netIncome'] = netIncome;
    data['netIncomeRatio'] = netIncomeRatio;
    data['eps'] = eps;
    data['epsdiluted'] = epsdiluted;
    data['weightedAverageShsOut'] = weightedAverageShsOut;
    data['weightedAverageShsOutDil'] = weightedAverageShsOutDil;
    data['link'] = link;
    data['finalLink'] = finalLink;
    return data;
  }
}
