import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FundamentalWidget {
  const FundamentalWidget(this.name);
  final String name;
}

class SektorWidget {
  const SektorWidget(this.name);
  final String name;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textHeader = "Land und Sektor auswählen";
  String textland = 'Land und Sektor';
  String tileImage = 'assets/images/false.gif';
  String textsektor = '';
  bool alleAuswaehlen = false;
  bool alle = true;
  int marktkapitalisierung = 50;
  late List<SektorWidget> _sektor;
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

  getData() async {
    var collection = FirebaseFirestore.instance.collection('company');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var name = data['name'];
      print(name);
    }
  }

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

    _sektor = <SektorWidget>[
      SektorWidget("Alle"),
      SektorWidget("Anlagenbau Zulieferer"),
      SektorWidget("Autos/Ersatzteile"),
      SektorWidget("Banken"),
      SektorWidget("Bau"),
      SektorWidget("Baumarkt-Produkte"),
      SektorWidget("Biotechnologie"),
      SektorWidget("Chemie"),
      SektorWidget("Container/Verpackung"),
      SektorWidget("Digitales Geld"),
      SektorWidget("Einzelhandel gemischt"),
      SektorWidget("Einzelhandel spezialisiert"),
      SektorWidget("Elektrizität"),
      SektorWidget("Elektro-Teile"),
      SektorWidget("Energie Dienstleister"),
      SektorWidget("Erdöl/Gas"),
      SektorWidget("Fonds"),
      SektorWidget("Fracht und Logistik"),
      SektorWidget("Fracht und Passagiere"),
      SektorWidget("Freizeitprodukte"),
      SektorWidget("Gas"),
      SektorWidget("Gesundheitspflege"),
      SektorWidget("Gesundheitspflege Geräte"),
      SektorWidget("Getränke"),
      SektorWidget("Halbleiter und Zubehör"),
      SektorWidget("Handel Nahrung/Medizin"),
      SektorWidget("Handelsgesellschaft"),
      SektorWidget("Haushalts-/Pflegeprodukte"),
      SektorWidget("Haushaltswaren"),
      SektorWidget("Holding"),
      SektorWidget("Hotels/Unterhaltung"),
      SektorWidget("Immobilien"),
      SektorWidget("Industriekonglomerate"),
      SektorWidget("Industrielle Dienste"),
      SektorWidget("Industrielle Lieferanten"),
      SektorWidget("Investment Services"),
      SektorWidget("Investment Trusts"),
      SektorWidget("Kommunikation"),
      SektorWidget("Kommunikation Ausrüster"),
      SektorWidget("Lebensmittel & Tabak"),
      SektorWidget("Maschinen"),
      SektorWidget("Maschinen/Zubehör"),
      SektorWidget("Medien"),
      SektorWidget("Metall/Abbau"),
      SektorWidget("Pharmazie"),
      SektorWidget("REIT"),
      SektorWidget("Raumfahrt/Verteidigung"),
      SektorWidget("Smart Contracts"),
      SektorWidget("Software/IT Dienste"),
      SektorWidget("Technische Konsumgüter"),
      SektorWidget("Textil - Kleidung"),
      SektorWidget("Transport Infrastruktur"),
      SektorWidget("Versicherungen"),
      SektorWidget("Versorger"),
      SektorWidget("Wasser"),
    ];
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

  Widget LandundSektoren() {
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
              width: 1000,
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
                  Wrap(children: SektorFilter.toList()),
                ],
              )),
        ],
      ),
    );
  }

  Widget custumizedButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: LiteRollingSwitch(
        value: true,
        width: 155,
        textOn: 'Alle auswählen',
        textOff: 'Alle abwählen',
        colorOn: Color.fromARGB(255, 34, 255, 133),
        colorOff: Color.fromARGB(255, 248, 19, 19),
        iconOn: Icons.done,
        iconOff: Icons.clear,
        animationDuration: const Duration(milliseconds: 300),
        onChanged: (bool state) {
          setState(() {
            alleAuswaehlen = !state;
          });
        },
        onDoubleTap: () {},
        onSwipe: () {},
        onTap: () {},
      ),
    );
  }

  Iterable<Widget> get SektorFilter sync* {
    for (SektorWidget sektor in _sektor) {
      yield FilterChip(
        label: Text(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          sektor.name,
        ),
        selected: _filtersSektor.contains(sektor.name),
        selectedColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.black,
        //showCheckmark: false,
        //avatar: CircleAvatar(backgroundColor: Colors.amber),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              if (sektor.name == "Alle") {
                _filtersSektor.clear();

                if (alle == true) {
                  _filtersSektor.add("Anlagenbau Zulieferer");
                  _filtersSektor.add("Autos/Ersatzteile");
                  _filtersSektor.add("Banken");
                  _filtersSektor.add("Bau");
                  _filtersSektor.add("Baumarkt-Produkte");
                  _filtersSektor.add("Biotechnologie");
                  _filtersSektor.add("Chemie");
                  _filtersSektor.add("Container/Verpackung");
                  _filtersSektor.add("Digitales Geld");
                  _filtersSektor.add("Einzelhandel gemischt");
                  _filtersSektor.add("Einzelhandel spezialisiert");
                  _filtersSektor.add("Elektrizität");
                  _filtersSektor.add("Elektro-Teile");
                  _filtersSektor.add("Energie Dienstleister");
                  _filtersSektor.add("Erdöl/Gas");
                  _filtersSektor.add("Fonds");
                  _filtersSektor.add("Fracht und Logistik");
                  _filtersSektor.add("Fracht und Passagiere");
                  _filtersSektor.add("Freizeitprodukte");
                  _filtersSektor.add("Gas");
                  _filtersSektor.add("Gesundheitspflege");
                  _filtersSektor.add("Gesundheitspflege Geräte");
                  _filtersSektor.add("Getränke");
                  _filtersSektor.add("Halbleiter und Zubehör");
                  _filtersSektor.add("Handel Nahrung/Medizin");
                  _filtersSektor.add("Handelsgesellschaft");
                  _filtersSektor.add("Haushalts-/Pflegeprodukte");
                  _filtersSektor.add("Haushaltswaren");
                  _filtersSektor.add("Holding");
                  _filtersSektor.add("Hotels/Unterhaltung");
                  _filtersSektor.add("Immobilien");
                  _filtersSektor.add("Industriekonglomerate");
                  _filtersSektor.add("Industrielle Dienste");
                  _filtersSektor.add("Industrielle Lieferanten");
                  _filtersSektor.add("Investment Services");
                  _filtersSektor.add("Investment Trusts");
                  _filtersSektor.add("Kommunikation");
                  _filtersSektor.add("Kommunikation Ausrüster");
                  _filtersSektor.add("Lebensmittel & Tabak");
                  _filtersSektor.add("Maschinen");
                  _filtersSektor.add("Maschinen/Zubehör");
                  _filtersSektor.add("Medien");
                  _filtersSektor.add("Metall/Abbau");
                  _filtersSektor.add("Pharmazie");
                  _filtersSektor.add("REIT");
                  _filtersSektor.add("Raumfahrt/Verteidigung");
                  _filtersSektor.add("Smart Contracts");
                  _filtersSektor.add("Software/IT Dienste");
                  _filtersSektor.add("Technische Konsumgüter");
                  _filtersSektor.add("Textil - Kleidung");
                  _filtersSektor.add("Transport Infrastruktur");
                  _filtersSektor.add("Versicherungen");
                  _filtersSektor.add("Versorger");
                  _filtersSektor.add("Wasser");
                }
              }
              _filtersSektor.add(sektor.name);

              if (_filtersSektor.toList().length == 54) {
                _filtersSektor.add("Alle");
              }
            } else {
              _filtersSektor.remove("Alle");

              if (sektor.name == "Alle") {
                _filtersSektor.clear();
              } else if (sektor.name != "Alle") {
                _filtersSektor.remove(sektor.name);
              } else {
                _filtersSektor.remove(sektor.name);
              }
            }
            print(_filtersSektor.toList());
            textsektor = "";

            textsektor = "Sektor: ${_filtersSektor.toList()}";
            if (_filtersSektor.toList().contains("Alle")) {
              textsektor = "Sektor: [Alle]";
            }
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Aktientool',
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            LandSektor(),
            LandundSektoren(),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
