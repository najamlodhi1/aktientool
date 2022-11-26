import 'package:aktientool/searcharea/feinfilter.dart';
import 'package:aktientool/searcharea/marketcap.dart';
import 'package:aktientool/searcharea/searcharea.dart';
import 'package:aktientool/searcharea/showCompany.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'searcharea/country.dart';
import 'searcharea/industry.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

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
    List<dynamic> generatedIndustryFromList =
        ref.watch(sp_generatedIndustryFromList);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: SearchArea(),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [
              Marketcap(),
              const Country(),
              Industry(),
              Feinfilter(),
              const ShowCompany(),
            ],
          ),
        ),
      ),
    );
  }
}
