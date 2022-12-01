import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: non_constant_identifier_names
var sp_marketcap = StateProvider((ref) {
  return 1000000000000;
});

// ignore: non_constant_identifier_names
var sp_isSelected = StateProvider((ref) {
  return [false, false, false, true];
});

// ignore: must_be_immutable
class Marketcap extends ConsumerWidget {
  List<Map> generatedCountrieFromList = [];
  var icon = Icons.search;

  final List<int> _marketcap = [
    1000000000,
    10000000000,
    100000000000,
    1000000000000,
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
        color: const Color.fromARGB(255, 11, 196, 144),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text("Marketcap:",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 22)),
              subtitle: Text(textMarketcap.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  Text(">10",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  Text(">100",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  Text(">1000",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
                isSelected: isSelected,
                onPressed: (int index) {
                  for (int i = 0; i < isSelected.length; i++) {
                    // ignore: avoid_print
                    //print(isSelected.toString());
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
