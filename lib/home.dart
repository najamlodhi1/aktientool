import 'package:aktientool/searcharea/country.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';

import 'constants/constants.dart';
import 'searcharea/searchfield.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('AktienTool');
  String textland = 'Land und Sektor';
  String tileImage = 'assets/images/false.gif';
  String text_marketcap = "> 100 Milliarde EUR";
  bool alleAuswaehlen = false;
  List<bool> _isSelected = [false, false, true, false];
  bool _selected = false;
  List<String> _marketcap = [
    "> 1 Milliarde EUR",
    "> 10 Milliarden EUR",
    "> 25 Milliarden EUR",
    "> 50 Milliarden EUR",
  ];

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
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = const ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Aktie eingeben',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('AktienTool');
                }
              });
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
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
              marketCap(
                "Marktkapitalisierung",
                text_marketcap,
                const Color.fromARGB(255, 45, 164, 207),
                Icons.bar_chart_rounded,
              ),
              cardView(
                  "Land",
                  "eingeben",
                  "Auswahl",
                  const Color.fromARGB(255, 37, 137, 173),
                  Icons.playlist_add_check),
              cardView(
                  "Sektor",
                  "eingeben",
                  "Auswahl",
                  const Color.fromARGB(255, 30, 109, 138),
                  Icons.store_mall_directory_outlined),
              cardView("Feinfilter", "eingeben", "Auswahl",
                  const Color.fromARGB(255, 30, 109, 138), Icons.filter),
            ],
          ),
        ),
      ),
    );
  }

  Widget marketCap(String title, String subtitle, Color color, IconData icon) {
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
              leading: Icon(icon, size: 25),
              title: Text(title,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 69, 69, 69), fontSize: 18)),
              subtitle: Text(subtitle,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              child: ToggleButtons(
                constraints: const BoxConstraints(
                    maxWidth: 69, minWidth: 69, minHeight: 39, maxHeight: 69),
                borderWidth: 3,

                // ignore: sort_child_properties_last
                children: const [
                  Text(">1",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(">10",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(">25",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(">50",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
                isSelected: _isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      _isSelected[i] = i == index;
                      text_marketcap = _marketcap[index].toString();
                    }
                  });
                },
                // region example 1
                color: Colors.white,
                selectedColor: Colors.white,
                fillColor: Colors.lightBlueAccent,
                // endregion
                // region example 2
                borderColor: Colors.lightBlueAccent,
                selectedBorderColor: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                // endregion
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardView(String title, String subtitle, String buttonTitle,
      Color color, IconData icon) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 16,
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    Center(
                      child: Text(
                        '1. Land auswählen',
                        style: kStyleDefault.copyWith(
                          color: Colors.blue,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Country(),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: SizedBox(
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
                leading: Icon(icon, size: 25),
                title: Text(title,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69), fontSize: 18)),
                subtitle: Text(subtitle,
                    style: const TextStyle(
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
                              // imageList[index]
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
}
