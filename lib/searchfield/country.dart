import 'package:flutter/material.dart';

class Country extends StatefulWidget {
  const Country({super.key});

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  List<Map> generatedCountrieFromList = [];

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
  }

  Widget Countries() {
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

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 0), child: Countries());
  }
}
