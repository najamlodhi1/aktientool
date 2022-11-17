import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/responsive.dart';

// ignore: non_constant_identifier_names
var sp_generatedSektorFromFeinFilter = StateProvider((ref) {
  return [];
});

// ignore: must_be_immutable
class Feinfilter extends ConsumerWidget {
  List<Map> generatedSektorFromList = [];

  Feinfilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SektorSelect()),
        );
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
                  image: AssetImage("assets/images/feinfilter.gif"),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SektorSelect extends ConsumerWidget {
  List sektor = [
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

  SektorSelect({Key? key}) : super(key: key);

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
    var generatedSektorFromList = ref.watch(sp_generatedSektorFromFeinFilter);

    if (generatedSektorFromList.toString() == "[]") {
      generatedSektorFromList = List.generate(
          sektor.length,
          (index) => {
                'id': index,
                'name': sektor[index].toString(),
                'isSelected': false,
                Color: Colors.black,
              });
    }

    //print(generatedCountrieFromList.toString());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Sektor auswählen'),
      ),
      body: GridView.builder(
        itemCount: 39,
        itemBuilder: (ctx, index) {
          return Card(
              key: ValueKey(generatedSektorFromList[index]['name']),
              margin: const EdgeInsets.all(11),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: generatedSektorFromList[index][Color],
              child: ListTile(
                onTap: () {
                  generatedSektorFromList[index]['isSelected'] =
                      !generatedSektorFromList[index]['isSelected'];

                  if (generatedSektorFromList[index]['isSelected'] == true) {
                    generatedSektorFromList[index][Color] = Colors.grey;
                  }
                  if (generatedSektorFromList[index]['isSelected'] == false) {
                    generatedSektorFromList[index][Color] = Colors.black;
                  }

                  ref.refresh(sp_generatedSektorFromFeinFilter.state).state =
                      generatedSektorFromList;
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
                  generatedSektorFromList[index]['name'],
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
