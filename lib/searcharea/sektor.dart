import '../searcharea/country_select.dart';
import 'package:flutter/material.dart';
import '../constants/responsive.dart';
import 'sektor_select.dart';

class Sektor extends StatefulWidget {
  const Sektor({super.key});

  @override
  State<Sektor> createState() => _SektorState();
}

class _SektorState extends State<Sektor> {
  List<Map> generatedCountrieFromList = [];

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

    generatedCountrieFromList = List.generate(
        sektor.length,
        (index) => {
              'id': index,
              'name': sektor[index].toString(),
              'isSelected': false
            });
  }

  Widget cardView() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SektorSelect()),
        );
      },
      child: SizedBox(
        width: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.deepPurpleAccent,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.abc, size: 25),
                title: Text("Sektor",
                    style: TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69), fontSize: 18)),
                subtitle: Text("eingeben",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
              ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        children: <Widget>[
                          SizedBox.fromSize(
                            size: const Size.fromRadius(15),
                            child: Image.asset(
                              'assets/images/40.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox.fromSize(
                            size: const Size.fromRadius(15),
                            child: Image.asset(
                              // imageList[index]
                              'assets/images/41.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox.fromSize(
                            size: const Size.fromRadius(15),
                            child: Image.asset(
                              // imageList[index]
                              'assets/images/42.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget countries() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 39,
      itemBuilder: (ctx, index) {
        return Card(
            key: ValueKey(generatedCountrieFromList[index]['name']),
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

            // The color depends on this is selected or not
            color: generatedCountrieFromList[index]['isSelected'] == true
                ? const Color.fromARGB(255, 7, 139, 255)
                : Color.fromARGB(255, 255, 255, 255),
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
                style: const TextStyle(color: Colors.black),
              ),
            ));
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: checkDevice(context),
      ),
    );
  }

  checkDevice(context) {
    if (Responsive.isDesktop(context) == true) {
      return 6;
    }
    if (Responsive.isTablet(context) == true) {
      return 4;
    }
    if (Responsive.isMobile(context) == true) {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return cardView();
  }
}
