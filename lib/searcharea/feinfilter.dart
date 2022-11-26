import 'package:aktientool/authentication/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/responsive.dart';

// ignore: non_constant_identifier_names
var sp_generatedIndustryFromFeinFilter = StateProvider((ref) {
  return [];
});

// ignore: must_be_immutable
class Feinfilter extends ConsumerWidget {
  List<Map> generatedIndustryFromList = [];

  Feinfilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndustrySelect(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
      },
      child: SizedBox(
        width: 180,
        height: 120,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.black,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  image: AssetImage("assets/images/feinfilter.png"),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class IndustrySelect extends ConsumerWidget {
  List industry = [
    "Alle",
    "Anlagenbau Zulieferer",
    "Autos/Ersatzteile",
    "Banken",
    "Bau",
    "Baumarkt-Produkte",
    "Biotechnologie",
    "Chemie",
    "Container/Verpackung",
    "Digitales Geld",
    "Einzelhandel gemischt",
    "Einzelhandel spezialisiert",
    "Elektrizität",
    "Elektro-Teile",
    "Energie Dienstleister",
    "Erdöl/Gas",
    "Fonds",
    "Fracht und Logistik",
    "Fracht und Passagiere",
    "Freizeitprodukte",
    "Gas",
    "Gesundheitspflege",
    "Gesundheitspflege Geräte",
    "Getränke",
    "Halbleiter und Zubehör",
    "Handel Nahrung/Medizin",
    "Handelsgesellschaft",
    "Haushalts-/Pflegeprodukte",
    "Haushaltswaren",
    "Holding",
    "Hotels/Unterhaltung",
    "Immobilien",
    "Industriekonglomerate",
    "Industrielle Dienste",
    "Industrielle Lieferanten",
    "Investment Services",
    "Investment Trusts",
    "Kommunikation",
    "Kommunikation Ausrüster",
    "Lebensmittel & Tabak",
    "Maschinen",
    "Maschinen/Zubehör",
    "Medien",
    "Metall/Abbau",
    "Pharmazie",
    "REIT",
    "Raumfahrt/Verteidigung",
    "Smart Contracts",
    "Software/IT Dienste",
    "Technische Konsumgüter",
    "Textil - Kleidung",
    "Transport Infrastruktur",
    "Versicherungen",
    "Versorger",
    "Wasser",
  ];

  IndustrySelect({Key? key}) : super(key: key);

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
    var generatedIndustryFromList = ref.watch(sp_generatedIndustryFromFeinFilter);

    if (generatedIndustryFromList.toString() == "[]") {
      generatedIndustryFromList = List.generate(
          industry.length,
          (index) => {
                'id': index,
                'name': industry[index].toString(),
                'isSelected': false,
                Color: Colors.black,
              });
    }

    //print(generatedCountrieFromList.toString());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Select Industry'),
      ),
      body: GridView.builder(
        itemCount: 39,
        itemBuilder: (ctx, index) {
          return Card(
              key: ValueKey(generatedIndustryFromList[index]['name']),
              margin: const EdgeInsets.all(11),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: generatedIndustryFromList[index][Color],
              child: ListTile(
                onTap: () {
                  generatedIndustryFromList[index]['isSelected'] =
                      !generatedIndustryFromList[index]['isSelected'];

                  if (generatedIndustryFromList[index]['isSelected'] == true) {
                    generatedIndustryFromList[index][Color] = Colors.grey;
                  }
                  if (generatedIndustryFromList[index]['isSelected'] == false) {
                    generatedIndustryFromList[index][Color] = Colors.black;
                  }

                  ref.refresh(sp_generatedIndustryFromFeinFilter.state).state =
                      generatedIndustryFromList;
                },
                leading: ClipRRect(
                  //borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(20),
                    child: Image.asset(
                      // imageList[index]
                      "assets/images/${index + 39}.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  generatedIndustryFromList[index]['name'],
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ));
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
