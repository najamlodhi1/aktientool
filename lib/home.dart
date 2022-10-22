import 'package:aktientool/searchfield/searchfield.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      print(name);
    }
  }

  @override
  void initState() {
    super.initState();
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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Searchfield(),
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
