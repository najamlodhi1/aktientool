import 'package:aktientool/filter/showCompanies.dart';
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
    int marketcap = ref.watch(sp_marketcap);
    List<dynamic> generatedCountrieFromList =
        ref.watch(sp_generatedCountrieFromList);
    List<dynamic> generatedIndustryFromList =
        ref.watch(sp_generatedIndustryFromList);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: SearchArea(),
      body: SafeArea(child: ShowCompanies()),
    );
  }
}
