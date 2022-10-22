import 'package:flutter/material.dart';

class Sektor extends StatefulWidget {
  const Sektor({super.key});

  @override
  State<Sektor> createState() => _SektorState();
}

class _SektorState extends State<Sektor> {
  List<Map> generatedSektorFromList = [];

  List<String> sektor = [
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

  @override
  void initState() {
    super.initState();

    generatedSektorFromList = List.generate(
        sektor.length,
        (index) => {
              'id': index,
              'name': sektor[index].toString(),
              'isSelected': false
            });
  }

  Widget Sektors() {
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
                          'assets/images/${index + 39}.png',
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
    return Padding(padding: const EdgeInsets.only(top: 0), child: Sektors());
  }
}
