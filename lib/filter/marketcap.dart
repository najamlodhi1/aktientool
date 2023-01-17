import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: non_constant_identifier_names
var sp_marketcap = StateProvider((ref) {
  return 1000000000;
});

// ignore: non_constant_identifier_names
var sp_isSelected = StateProvider((ref) {
  return [true, false, false, false, false];
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
    10000000000000,
  ];

  Marketcap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textMarketcap = ref.watch(sp_marketcap);

    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ExpansionTile(
              title: const Text("Marketcap:",
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                textMarketcap.toString(),
                style: const TextStyle(color: Colors.blue),
              ),
              // Contents
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                  title: const Text('1000000000',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // ignore: deprecated_member_use
                    ref.read(sp_marketcap.state).state = _marketcap[0];
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  title: const Text('10000000000',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // ignore: deprecated_member_use
                    ref.read(sp_marketcap.state).state = _marketcap[1];
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                  title: const Text('100000000000',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // ignore: deprecated_member_use
                    ref.read(sp_marketcap.state).state = _marketcap[2];
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                  title: const Text(
                    '1000000000000',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // ignore: deprecated_member_use
                    ref.read(sp_marketcap.state).state = _marketcap[3];
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 144, 190, 158),
                  ),
                  title: const Text(
                    '10000000000000',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // ignore: deprecated_member_use
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
