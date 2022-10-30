import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: non_constant_identifier_names
final sp_marketcap = StateProvider((ref) {
  return "> 50 Milliarden EUR";
});

// ignore: non_constant_identifier_names
final sp_isSelected = StateProvider((ref) {
  return [false, false, false, true];
});

// ignore: must_be_immutable
class Marketcap extends ConsumerWidget {
  List<Map> generatedCountrieFromList = [];
  var icon = Icons.search;

  final List<String> _marketcap = [
    "> 1 Milliarde EUR",
    "> 10 Milliarden EUR",
    "> 25 Milliarden EUR",
    "> 50 Milliarden EUR",
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
        color: Colors.blue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text("Marktapitalisierung",
                  style: TextStyle(
                      color: Color.fromARGB(255, 69, 69, 69), fontSize: 16)),
              subtitle: Text(textMarketcap,
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
                    ref.read(sp_marketcap.state).state =
                        _marketcap[index].toString();
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
