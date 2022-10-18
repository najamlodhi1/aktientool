import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants.dart';

class LandundSektor extends StatefulWidget {
  const LandundSektor({super.key});

  @override
  State<LandundSektor> createState() => _LandundSektorState();
}

class _LandundSektorState extends State<LandundSektor> {
  String textHeader = "Land und Sektor auswählen";
  String textland = 'Land und Sektor';
  String tileImage = 'assets/images/false.gif';
  String textsektor = '';
  bool alleAuswaehlen = false;
  bool alle = true;
  int marktkapitalisierung = 50;
  List<String> _filtersSektor = <String>[];
  bool selectMarktkapitalisierung = false;
  bool visiblePage1 = true;
  bool visiblePage2 = true;
  List<Map> generatedCountrieFromList = [];
  List<Map> generatedSektorFromList = [];

  List country = [
    "Alle",
    "USA",
    "Deutschland",
    "Australien",
    "Belgien",
    "Bermuda",
    "China",
    "Dänemark",
    "Finnland",
    "Frankreich",
    "Großbritannien",
    "Hong Kong",
    "Irland",
    "Israel",
    "Italien",
    "Kanada",
    "Luxemburg",
    "Niederlande",
    "Norwegen",
    "Österreich",
    "Schweden",
    "Schweiz",
    "Singapur",
    "Spanien",
    "Japan",
    "Südkorea",
    "Griechenland",
    "Malta",
    "Polen",
    "Portugal",
    "Zypern",
    "Russland",
    "Taiwan",
    "Indien",
    "Neuseeland",
    "Brasilien",
    "Chile",
    "Südafrika",
    "Kaimaninseln"
  ];

  List<String> sektor = [
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

  @override
  void initState() {
    super.initState();

    generatedCountrieFromList = List.generate(
        country.length,
        (index) => {
              'id': index,
              'name': country[index].toString(),
              'isSelected': false
            });

    generatedSektorFromList = List.generate(
        sektor.length,
        (index) => {
              'id': index,
              'name': sektor[index].toString(),
              'isSelected': false
            });
  }

  Widget LandSektor() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: const Size.fromRadius(20),
            child: Image.asset(
              tileImage,
              fit: BoxFit.cover,
            ),
          ),
        ),

        onExpansionChanged: (bool expanded) {
          setState(() {
            if (expanded) {
              visiblePage1 = false;
              visiblePage2 = false;
              tileImage = 'assets/images/true.gif';
            } else {
              tileImage = 'assets/images/false.gif';
              visiblePage1 = true;
              visiblePage2 = true;
            }
          });
        },

        collapsedTextColor: Colors.black,
        collapsedBackgroundColor: Colors.white,
        collapsedIconColor: Colors.red,
        textColor: Colors.blue,
        backgroundColor: Colors.black, // kompletter Hintergrund
        //key: closeKey,
        title: Text(textland),
        subtitle: Text(textsektor),
        iconColor: Colors.grey,
        // Contents
        children: [
          Container(
              //width: 1000,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              child: Column(
                children: [
                  Text(
                    '1. Land auswählen',
                    style: kStyleDefault.copyWith(
                      color: Colors.blue,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AlleLaender(),
                ],
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
              //width: 1000,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              child: Column(
                children: [
                  Text(
                    '2. Sektor auswählen',
                    style: kStyleDefault.copyWith(
                      color: Colors.blue,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AlleSektoren(),
                ],
              )),
        ],
      ),
    );
  }

  Widget AlleLaender() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 220,
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: generatedCountrieFromList.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                  key: ValueKey(generatedCountrieFromList[index]['name']),
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),

                  // The color depends on this is selected or not
                  color: generatedCountrieFromList[index]['isSelected'] == true
                      ? Color.fromARGB(255, 7, 139, 255)
                      : Color.fromARGB(255, 0, 0, 0),
                  child: ListTile(
                    onTap: () {
                      // if this item isn't selected yet, "isSelected": false -> true
                      // If this item already is selected: "isSelected": true -> false
                      setState(() {
                        generatedCountrieFromList[index]['isSelected'] =
                            !generatedCountrieFromList[index]['isSelected'];
                      });
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(20),
                        child: Image.asset(
                          // imageList[index]
                          'assets/images/$index.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      generatedCountrieFromList[index]['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
            },
          )),
    );
  }

  Widget AlleSektoren() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 220,
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: generatedSektorFromList.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                  key: ValueKey(generatedSektorFromList[index]['name']),
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),

                  // The color depends on this is selected or not
                  color: generatedSektorFromList[index]['isSelected'] == true
                      ? Color.fromARGB(255, 7, 139, 255)
                      : Color.fromARGB(255, 0, 0, 0),
                  child: ListTile(
                    onTap: () {
                      // if this item isn't selected yet, "isSelected": false -> true
                      // If this item already is selected: "isSelected": true -> false
                      setState(() {
                        generatedSektorFromList[index]['isSelected'] =
                            !generatedSektorFromList[index]['isSelected'];
                      });
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(20),
                        child: Image.asset(
                          // imageList[index]
                          'assets/images/$index.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      generatedSektorFromList[index]['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
