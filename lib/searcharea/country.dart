import '../searcharea/country_select.dart';
import 'package:flutter/material.dart';
import '../constants/responsive.dart';

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

  Widget cardView() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CountrySelect()),
        );
      },
      child: SizedBox(
        width: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.green,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.abc, size: 25),
                title: Text("Land",
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
                              'assets/images/0.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox.fromSize(
                            size: const Size.fromRadius(15),
                            child: Image.asset(
                              // imageList[index]
                              'assets/images/1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox.fromSize(
                            size: const Size.fromRadius(15),
                            child: Image.asset(
                              // imageList[index]
                              'assets/images/2.png',
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
