import 'package:aktientool/searcharea/feinfilter.dart';
import 'package:aktientool/searcharea/marketcap.dart';
import 'package:aktientool/searcharea/searcharea.dart';
import 'package:aktientool/searcharea/showCompany.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'searcharea/country.dart';
import 'searcharea/sektor.dart';

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
                  onPressed: () {
                    daily();
                  },
                  child: const Text("Update Daily")),
              ElevatedButton(
                  onPressed: () {
                    monthly();
                  },
                  child: const Text("Update Monthly")),
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
