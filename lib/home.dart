import 'package:aktientool/LandundSektor/land_und_sektor.dart';
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

  LandundSektor landSektorobj = new LandundSektor();

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
            landSektorobj.
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
