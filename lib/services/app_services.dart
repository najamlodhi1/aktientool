import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/company.dart';

class AppServices {
  Future<void> fetchIncome(String company) async {
    List<String> dates = [];
    List<String> symbols = [];
    List<String> reportedCurrencies = [];
    List<String> ciks = [];
    List<String> fillingDates = [];
    List<String> acceptedDates = [];
    List<String> calendarYears = [];
    List<String> periods = [];
    List<int> revenues = [];
    List<int> costOfRevenues = [];
    List<int> grossProfits = [];
    List<double> grossProfitRatios = [];
    List<int?> researchAndDevelopmentExpenses = [];
    List<int?> generalAndAdministrativeExpenses = [];
    List<int?> sellingAndMarketingExpenses = [];
    List<int?> sellingGeneralAndAdministrativeExpenses = [];
    List<int?> otherExpenses = [];
    List<int?> operatingExpenses = [];
    List<int?> costAndExpenses = [];
    List<int?> interestIncome = [];
    List<int?> interestExpense = [];
    List<int?> depreciationAndAmortization = [];
    List<int?> ebitda = [];
    List<double?> ebitdaratio = [];
    List<int?> operatingIncome = [];
    List<double?> operatingIncomeRatio = [];
    List<int?> totalOtherIncomeExpensesNet = [];
    List<int?> incomeBeforeTax = [];
    List<double?> incomeBeforeTaxRatio = [];
    List<int?> incomeTaxExpense = [];
    List<int?> netIncome = [];
    List<double?> netIncomeRatio = [];
    List<double?> eps = [];
    List<double?> epsdiluted = [];
    List<int?> weightedAverageShsOut = [];
    List<int?> weightedAverageShsOutDil = [];
    List<String?> link = [];
    List<String?> finalLink = [];

    final response = await http.get(
      Uri.parse(
          'https://financialmodelingprep.com/api/v3/income-statement/$company?period=quarter&limit=400&apikey=9ad9c8dfa54c11aff6c1489d109e87b6'),
    );

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      extractedData.forEach(
        (data) async {
          dates.add(data["date"]);
          symbols.add(data["symbol"]);
          reportedCurrencies.add(data["reportedCurrency"]);
          ciks.add(data["cik"]);
          fillingDates.add(data["fillingDate"]);
          acceptedDates.add(data["acceptedDate"]);
          calendarYears.add(data["calendarYear"]);
          periods.add(data["period"]);
          revenues.add(data["revenue"]);
          costOfRevenues.add(data["costOfRevenue"]);
          grossProfits.add(data["grossProfit"]);
          grossProfitRatios.add(data["grossProfitRatio"]);
          researchAndDevelopmentExpenses
              .add(data["researchAndDevelopmentExpenses"]);
          generalAndAdministrativeExpenses
              .add(data["generalAndAdministrativeExpenses"]);
          sellingAndMarketingExpenses.add(data["sellingAndMarketingExpenses"]);
          sellingGeneralAndAdministrativeExpenses
              .add(data["sellingGeneralAndAdministrativeExpenses"]);
          otherExpenses.add(data["otherExpenses"]);
          operatingExpenses.add(data["operatingExpenses"]);
          costAndExpenses.add(data["costAndExpenses"]);
          interestIncome.add(data["interestIncome"]);
          interestExpense.add(data["interestExpense"]);
          depreciationAndAmortization.add(data["depreciationAndAmortization"]);
          ebitda.add(data["ebitda"]);
          ebitdaratio.add(data["ebitdaratio"]);
          operatingIncome.add(data["operatingIncome"]);
          operatingIncomeRatio.add(data["operatingIncomeRatio"]);
          totalOtherIncomeExpensesNet.add(data["totalOtherIncomeExpensesNet"]);
          incomeBeforeTax.add(data["incomeBeforeTax"]);
          incomeBeforeTaxRatio.add(data["incomeBeforeTaxRatio"]);
          incomeTaxExpense.add(data["incomeTaxExpense"]);
          netIncome.add(data["netIncome"]);
          netIncomeRatio.add(data["netIncomeRatio"]);
          eps.add(data["eps"]);
          epsdiluted.add(data["epsdiluted"]);
          weightedAverageShsOut.add(data["weightedAverageShsOut"]);
          weightedAverageShsOutDil.add(data["weightedAverageShsOutDil"]);
          link.add(data["link"]);
          finalLink.add(data["finalLink"]);

          await FirebaseFirestore.instance
              .collection('income')
              .doc(company)
              .set(
            {
              "date": dates,
              "symbol": symbols,
              "reportedCurrency": reportedCurrencies,
              "cik": ciks,
              "fillingDate": fillingDates,
              "acceptedDate": acceptedDates,
              "calendarYear": calendarYears,
              "period": periods, //FieldValue.arrayUnion(periods),
              "revenue": revenues,
              "costOfRevenue": costOfRevenues,
              "grossProfit": grossProfits,
              "grossProfitRatio": grossProfitRatios,
              "researchAndDevelopmentExpenses": researchAndDevelopmentExpenses,
              "generalAndAdministrativeExpenses":
                  generalAndAdministrativeExpenses,
              "sellingAndMarketingExpenses": sellingAndMarketingExpenses,
              "sellingGeneralAndAdministrativeExpenses":
                  sellingGeneralAndAdministrativeExpenses,
              "otherExpenses": otherExpenses,
              "operatingExpenses": operatingExpenses,
              "costAndExpenses": costAndExpenses,
              "interestIncome": interestIncome,
              "interestExpense": interestExpense,
              "depreciationAndAmortization": depreciationAndAmortization,
              "ebitda": ebitda,
              "ebitdaratio": ebitdaratio,
              "operatingIncome": operatingIncome,
              "operatingIncomeRatio": operatingIncomeRatio,
              "totalOtherIncomeExpensesNet": totalOtherIncomeExpensesNet,
              "incomeBeforeTax": incomeBeforeTax,
              "incomeBeforeTaxRatio": incomeBeforeTaxRatio,
              "incomeTaxExpense": incomeTaxExpense,
              "netIncome": netIncome,
              "netIncomeRatio": netIncomeRatio,
              "eps": eps,
              "epsdiluted": epsdiluted,
              "weightedAverageShsOut": weightedAverageShsOut,
              "weightedAverageShsOutDil": weightedAverageShsOutDil,
              "link": link,
              "finalLink": finalLink,
            },
            SetOptions(
              merge: true,
            ),
          );
        },
      );
    } else {
      throw Exception('Failed to load company');
    }
  }

  Future<void> fetchCompanies() async {
    final response = await http.get(
      Uri.parse(
        'https://financialmodelingprep.com/api/v3/stock-screener?marketCapMoreThan=100000000000&volumeMoreThan=10000&apikey=9ad9c8dfa54c11aff6c1489d109e87b6',
      ),
    );

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      extractedData.forEach(
        (data) async {
          //await Future.delayed(const Duration(seconds: 1));

          await FirebaseFirestore.instance
              .collection('company')
              .doc(data['symbol'])
              .set(
                Company(
                  symbol: data['symbol'],
                  companyName: data['companyName'],
                  marketCap: data['marketCap'],
                  sector: data['sector'],
                  industry: data['industry'],
                  //beta: data['beta'],
                  price: data['price'],
                  lastAnnualDividend: data['lastAnnualDividend'],
                  //volume: data['volume'],
                  //exchange: data['exchange'],
                  exchangeShortName: data['exchangeShortName'],
                  country: data['country'],
                  isEtf: data['isEtf'],
                  //isActivelyTrading: data['isActivelyTrading'],
                ).toMap(),
                SetOptions(
                  merge: true,
                ),
              );
        },
      );
      if (kDebugMode) {
        print(response.body.length);
      }
    } else {
      throw Exception('Failed to load company');
    }
  }
}
