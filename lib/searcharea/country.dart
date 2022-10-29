import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/responsive.dart';
import 'package:flutter/material.dart';

var sp_generatedCountrieFromList = StateProvider((ref) {
  return [];
});

class Country extends ConsumerWidget {
  const Country({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CountrySelect()),
        );
      },
      child: SizedBox(
        width: 180,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.green,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Text("Land",
                    style: TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69), fontSize: 20)),
              ),
              ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        children: <Widget>[
                          SizedBox.fromSize(
                            size: const Size.fromRadius(24),
                            child: Image.asset(
                              'assets/images/0.png',
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
}

class CountrySelect extends ConsumerWidget {
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

  CountrySelect({Key key}) : super(key: key);

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
    var generatedCountrieFromList = ref.watch(sp_generatedCountrieFromList);

    if (generatedCountrieFromList.toString() == "[]") {
      generatedCountrieFromList = List.generate(
          country.length,
          (index) => {
                'id': index,
                'name': country[index].toString(),
                'isSelected': false,
                Color: Colors.black,
              });
    }

    //print(generatedCountrieFromList.toString());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Land auswählen'),
      ),
      body: GridView.builder(
        itemCount: 39,
        itemBuilder: (ctx, index) {
          return Card(
              key: ValueKey(generatedCountrieFromList[index]['name']),
              margin: const EdgeInsets.all(11),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: generatedCountrieFromList[index][Color],
              child: ListTile(
                onTap: () {
                  generatedCountrieFromList[index]['isSelected'] =
                      !generatedCountrieFromList[index]['isSelected'];

                  if (generatedCountrieFromList[index]['isSelected'] == true) {
                    generatedCountrieFromList[index][Color] = Colors.grey;
                  }
                  if (generatedCountrieFromList[index]['isSelected'] == false) {
                    generatedCountrieFromList[index][Color] = Colors.black;
                  }

                  ref.refresh(sp_generatedCountrieFromList.state).state =
                      generatedCountrieFromList;

                  print("--generatedCountrieFromList");
                  print(generatedCountrieFromList[index].toString());
                  print("--generatedCountrieFromList");
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
