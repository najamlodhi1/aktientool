import 'package:aktientool/startseite/footer.dart';
import 'package:aktientool/startseite/geld.dart';
import 'package:aktientool/startseite/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aktientool/datenschutz/cookie.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'models/company.dart';
import 'package:http/http.dart' as http;

final cookieProvider = StateProvider((ref) => false);

class Start extends ConsumerWidget {
  const Start({super.key});

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
    Future.delayed(Duration.zero, () {
      if (ref.watch(cookieProvider.state).state == false) {
        checkCookies2(context, ref);
        //FireStoreDataBase fire = FireStoreDataBase();
        //fire.besuchercount();
      }
    });

    return Scaffold(
      appBar: headerNav(context),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            const Geld(),
            const Footer(),
            TextButton(
              onPressed: () async {
                await fetchCompanies();
              },
              child: const Text(
                "Company",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () async {
                //await fetchIncome();
              },
              child: const Text(
                "Income",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
