// ignore_for_file: unused_local_variable

import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../filter/country.dart';
import '../filter/industry.dart';
import '../filter/marketcap.dart';
import '../filter/searcharea.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int marketcap_start = ref.watch(sp_marketcap_start);
    int marketcap_end = ref.watch(sp_marketcap_end);

    List<dynamic> generatedCountrieFromList =
        ref.watch(sp_generatedCountrieFromList);
    List<dynamic> generatedIndustryFromList =
        ref.watch(sp_generatedIndustryFromList);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: SearchArea(),
      body: SafeArea(child: ShowCompanies()),
    );
  }
}
