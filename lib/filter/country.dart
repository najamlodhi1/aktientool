import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/responsive.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
StateProvider<List<dynamic>> sp_generatedCountrieFromList =
    StateProvider((ref) {
  return [];
});

// ignore: non_constant_identifier_names
var sp_country_url = StateProvider((ref) {
  return "";
});

// ignore: must_be_immutable
class CountrySelect extends ConsumerWidget {
  List country = [
    "AR",
    "CH",
    "CN",
    "IE",
    "NL",
    "CR",
    "GR",
    "PE",
    "IM",
    "BS",
    "CL",
    "FI",
    "HK",
    "MC",
    "ID",
    "SE",
    "LU",
    "CO",
    "ZA",
    "AE",
    "KZ",
    "MU",
    "ES",
    "TW",
    "UY",
    "KY",
    "NO",
    "PA",
    "MY",
    "JO",
    "JP",
    "FR",
    "SG",
    "DK",
    "BM",
    "DE",
    "MX",
    "PR",
    "JE",
    "CY",
    "US",
    "IT",
    "IL",
    "RU",
    "CK",
    "BR",
    "GB",
    "IN",
    "AU",
    "NZ",
    "TR",
    "TH",
    "KR",
    "VG",
    "CA",
    "BE",
    "IS",
    "PH",
    "GI",
    "GG",
  ];

  CountrySelect({super.key});

  checkDevice(context) {
    if (Responsive.isDesktop(context) == true) {
      return 7;
    }
    if (Responsive.isTablet(context) == true) {
      return 4;
    }
    if (Responsive.isMobile(context) == true) {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var generatedCountrieFromList = ref.watch(sp_generatedCountrieFromList);

    if (generatedCountrieFromList.toString() == "[]") {
      generatedCountrieFromList = List.generate(
        country.length,
        (index) => {
          'id': index,
          'name': country[index].toString(),
          'isSelected': false,
          Color: Colors.black,
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Land auswählen'),
      ),
      body: GridView.builder(
        itemCount: 60,
        itemBuilder: (ctx, index) {
          return Card(
            key: ValueKey(generatedCountrieFromList[index]['name']),
            margin: const EdgeInsets.all(11),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: generatedCountrieFromList[index][Color],
            child: ListTile(
              onTap: () {
                generatedCountrieFromList[index]['isSelected'] =
                    !generatedCountrieFromList[index]['isSelected'];

                if (generatedCountrieFromList[index]['isSelected'] == true) {
                  generatedCountrieFromList[index][Color] = Colors.grey;
                  // ignore: deprecated_member_use
                  ref.watch(sp_country_url.state).state +=
                      // ignore: prefer_interpolation_to_compose_strings
                      ":" + generatedCountrieFromList[index]['name'];
                }
                if (generatedCountrieFromList[index]['isSelected'] == false) {
                  generatedCountrieFromList[index][Color] = Colors.black;
                  // ignore: deprecated_member_use
                  ref.watch(sp_country_url.state).state = ref
                      // ignore: deprecated_member_use
                      .watch(sp_country_url.state)
                      .state
                      .replaceAll(
                          // ignore: prefer_interpolation_to_compose_strings
                          ":" + generatedCountrieFromList[index]['name'],
                          '');
                }

                // ignore: deprecated_member_use
                ref.refresh(sp_generatedCountrieFromList.state).state =
                    generatedCountrieFromList;
              },
              leading: ClipRRect(
                //borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(20),
                  child: SvgPicture.asset(
                    "images/${(country[index]).toLowerCase()}.svg",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: Text(
                generatedCountrieFromList[index]['name'],
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: checkDevice(context),
          childAspectRatio: 1.0,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 5,
          mainAxisExtent: 70,
        ),
      ),
    );
  }
}
