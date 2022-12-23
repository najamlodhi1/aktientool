import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: non_constant_identifier_names
var sp_marketcap = StateProvider((ref) {
  return 1000000000;
});

// ignore: non_constant_identifier_names
var sp_isSelected = StateProvider((ref) {
  return [true, false, false, false];
});

var sp_foos = StateProvider((ref) {
  return '10';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isSelected = ref.watch(sp_isSelected);
    var textMarketcap = ref.watch(sp_marketcap);

    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ExpansionTile(
              title: const Text("Marketcap:"),
              subtitle: Text(textMarketcap.toString()),
              // Contents
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                  title: const Text('1000000000'),
                  onTap: () {
                    ref.read(sp_marketcap.state).state = _marketcap[0];
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  title: const Text('10000000000'),
                  onTap: () {
                    ref.read(sp_marketcap.state).state = _marketcap[1];
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                  title: const Text('100000000000'),
                  onTap: () {
                    ref.read(sp_marketcap.state).state = _marketcap[2];
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                  title: const Text('1000000000000'),
                  onTap: () {
                    ref.read(sp_marketcap.state).state = _marketcap[3];
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
