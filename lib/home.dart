import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'searcharea/searchfield.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textland = 'Land und Sektor';
  String tileImage = 'assets/images/false.gif';
  bool alleAuswaehlen = false;

  getData() async {
    var collection = FirebaseFirestore.instance.collection('company');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var name = data['name'];
      // ignore: avoid_print
      print(name);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Aktientool',
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Searchfield(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            //direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              cardView(
                "Marktkapitalisierung",
                "eingeben",
                "Auswahl",
                Color.fromARGB(255, 45, 164, 207),
              ),
              cardView(
                "Land",
                "eingeben",
                "Auswahl",
                Color.fromARGB(255, 37, 137, 173),
              ),
              cardView(
                "Sektor",
                "eingeben",
                "Auswahl",
                Color.fromARGB(255, 30, 109, 138),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardView(
      String title, String subtitle, String buttonTitle, Color color) {
    return SizedBox(
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: color,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album, size: 70),
              title: Text(title, style: TextStyle(color: Colors.white)),
              subtitle: Text(subtitle, style: TextStyle(color: Colors.white)),
            ),
            ButtonTheme(
              child: ButtonBar(
                children: <Widget>[
                  ElevatedButton(
                    child: Text(buttonTitle,
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
