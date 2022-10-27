import 'package:flutter/material.dart';
import '../constants/responsive.dart';

class CountrySelect extends StatefulWidget {
  const CountrySelect({super.key});

  @override
  State<CountrySelect> createState() => _CountrySelectState();
}

class _CountrySelectState extends State<CountrySelect> {
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

  Widget countries() {
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
                    'assets/images/$index.png',
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
        title: const Text('Land auswählen'),
      ),
      body: countries(),
    );
  }
}
