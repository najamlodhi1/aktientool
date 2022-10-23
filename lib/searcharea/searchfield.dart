import 'package:flutter/material.dart';

import '../constants.dart';
import 'country.dart';
import 'sektor.dart';

class Searchfield extends StatefulWidget {
  const Searchfield({super.key});

  @override
  State<Searchfield> createState() => _SearchfieldState();
}

class _SearchfieldState extends State<Searchfield> {
  String textland = 'Land und Sektor';
  String tileImage = 'assets/images/false.gif';
  String textsektor = 'auswählen';
  bool visiblePage1 = true;
  bool visiblePage2 = true;

  @override
  void initState() {
    super.initState();
  }

  Widget landSektor() {
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

        collapsedTextColor: Colors.white,
        collapsedBackgroundColor: Colors.black,
        collapsedIconColor: Colors.red,
        textColor: Colors.blue,
        backgroundColor: Colors.black, // kompletter Hintergrund
        title: Text(textland),
        subtitle: Text(textsektor),
        iconColor: Colors.grey,
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
                  const Country(),
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
                  const Sektor(),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 0), child: landSektor());
  }
}
