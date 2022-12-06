import 'package:aktientool/filter/filter2.dart';
import 'package:aktientool/filter/marketcap.dart';
import 'package:flutter/material.dart';

import 'industry.dart';

class Filter extends StatelessWidget {
  final List<int> _list = List.generate(20, (i) => i);
  final List<bool> _selected =
      List.generate(20, (i) => false); // Fill it with false initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Filter'), backgroundColor: Colors.black),
      // Implement the ExpansionTile
      body: Column(
        children: [
          Marketcap(),
          const ExpansionTile(
            title: Text('Marketcap'),
            subtitle: Text('10000000'),
            // Contents
            children: [Filter2()],
          ),
          ExpansionTile(
            title: const Text('Country'),
            subtitle: const Text('10000000'),
            // Contents
            children: [
              IndustrySelect(),
            ],
          ),
          const ExpansionTile(
            title: Text('Sector'),
            subtitle: Text('10000000'),
            // Contents
            children: [
              ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                  title: Text('Blue')),
              ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  title: Text('Red')),
              ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                  title: Text('Amber')),
              ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                  title: Text('Pink')),
              ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                  title: Text('Green')),
            ],
          ),
        ],
      ),
    );
  }
}
