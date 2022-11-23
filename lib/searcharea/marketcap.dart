import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: non_constant_identifier_names
final sp_marketcap = StateProvider((ref) {
  return 50000000;
});

// ignore: non_constant_identifier_names
final sp_isSelected = StateProvider((ref) {
  return [false, false, false, true];
});

// ignore: must_be_immutable
class Marketcap extends ConsumerWidget {
  List<Map> generatedCountrieFromList = [];
  var icon = Icons.search;

  final List<int> _marketcap = [
    1000000,
    10000000,
    25000000,
    50000000,
  ];

  Marketcap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isSelected = ref.watch(sp_isSelected);
    var textMarketcap = ref.watch(sp_marketcap);

    return SizedBox(
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color.fromARGB(255, 97, 30, 177),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text("Marketcap:",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 16)),
              subtitle: Text(textMarketcap.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: ToggleButtons(
                constraints: const BoxConstraints(
                    maxWidth: 39, minWidth: 39, minHeight: 39, maxHeight: 39),
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
                isSelected: isSelected,
                onPressed: (int index) {
                  for (int i = 0; i < isSelected.length; i++) {
                    // ignore: avoid_print
                    print(isSelected.toString());

                    isSelected[i] = i == index;
                    ref.read(sp_marketcap.state).state = _marketcap[index];
                  }
                },
                color: Colors.white,
                selectedColor: Colors.white,
                fillColor: Colors.lightBlueAccent,
                borderColor: Colors.lightBlueAccent,
                selectedBorderColor: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/**

 Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    offset: Offset(-20, 20),
                    color: Colors.red,
                    blurRadius: 15,
                    spreadRadius: -10,
                  ),
                  BoxShadow(
                    offset: Offset(-20, -20),
                    color: Colors.orange,
                    blurRadius: 15,
                    spreadRadius: -10,
                  ),
                  BoxShadow(
                    offset: Offset(20, -20),
                    color: Colors.blue,
                    blurRadius: 15,
                    spreadRadius: -10,
                  ),
                  BoxShadow(
                    offset: Offset(20, 20),
                    color: Colors.deepPurple,
                    blurRadius: 15,
                    spreadRadius: -10,
                  )
                ]),
                child: Container(
                  width: 180,
                  height: 120,
                  color: Colors.black,
                  child: const Center(
                      child: Text(
                    'Text',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  )),
                ),
              ),
              Container(
                height: 200.0,
                width: 200.0,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 25.0, //extend the shadow
                      offset: Offset(
                        5.0, // Move to right 5  horizontally
                        5.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                ),
                child: const Text("Hello world"),
              ), 
 

 */