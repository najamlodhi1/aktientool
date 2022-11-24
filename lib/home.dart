import 'dart:convert';

import 'package:aktientool/searcharea/feinfilter.dart';
import 'package:aktientool/searcharea/marketcap.dart';
import 'package:aktientool/searcharea/searcharea.dart';
import 'package:aktientool/searcharea/showCompany.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/company.dart';
import 'searcharea/country.dart';
import 'searcharea/sektor.dart';
import 'package:http/http.dart' as http;

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  Future<void> fetchCompanies() async {
    final response = await http.get(
      Uri.parse(
        'https://financialmodelingprep.com/api/v3/stock-screener?marketCapMoreThan=100000000&volumeMoreThan=10000&apikey=9ad9c8dfa54c11aff6c1489d109e87b6',
      ),
    );

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      extractedData.forEach(
        (data) async {
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
        //print(response.body.length);
      }
    } else {
      throw Exception('Failed to load company');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //getData();
    //AsyncValue<List<Photo>> photos = ref.watch(photoStateFuture);
    //AsyncValue companies = ref.watch(companyStateFuture);

    // höre auf
    //var watchMarketCap = ref.watch(sp_marketcap);
    // ignore: unused_local_variable
    int marketcap = ref.watch(sp_marketcap);
    // ignore: unused_local_variable
    List<dynamic> generatedCountrieFromList =
        ref.watch(sp_generatedCountrieFromList);
    // ignore: unused_local_variable
    List<dynamic> generatedSektorFromList =
        ref.watch(sp_generatedSektorFromList);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: SearchArea(),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await fetchCompanies();
                },
                child: const Text(
                  "Update Daily",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  monthly();
                },
                child: const Text(
                  "Update Monthly",
                ),
              ),
              Marketcap(),
              const Country(),
              Sektor(),
              Feinfilter(),
              const ShowCompany(),
            ],
          ),
        ),
      ),
    );
  }

  daily() {
    // rest service  get stockdata and write into our Firebase Database
    //if its exist then update if not then add
  }

  monthly() {
    // rest service  get stockdata and write into our Firebase Database
    //if its exist then update if not then add
  }
}
