import 'package:flutter/material.dart';
import '../constants/responsive.dart';

class SektorSelect extends StatefulWidget {
  const SektorSelect({super.key});

  @override
  State<SektorSelect> createState() => _SektorSelectState();
}

class _SektorSelectState extends State<SektorSelect> {
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

  Widget sektors() {
    return GridView.builder(
      //shrinkWrap: true,
      itemCount: 39,
      itemBuilder: (ctx, index) {
        return Card(
            key: ValueKey(generatedCountrieFromList[index]['name']),
            margin: const EdgeInsets.all(11),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

            // The color depends on this is selected or not
            color: generatedCountrieFromList[index]['isSelected'] == true
                ? Colors.grey
                : Colors.black,
            child: ListTile(
              onTap: () {
                setState(() {
                  generatedCountrieFromList[index]['isSelected'] =
                      !generatedCountrieFromList[index]['isSelected'];
                });
              },
              leading: ClipRRect(
                //borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(20),
                  child: Image.asset(
                    // imageList[index]
                    "assets/images/" + (index + 39).toString() + ".png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                generatedCountrieFromList[index]['name'],
                style: const TextStyle(color: Colors.white),
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
    );
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Sektor auswählen'),
      ),
      body: sektors(),
    );
  }
}
