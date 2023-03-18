import 'package:aktientool/filter/industry.dart';
import 'package:aktientool/filter/marketcap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../charts/allCharts.dart';
import '../charts/chart13/createchart.dart';
import 'country.dart';

class Filter extends ConsumerWidget {
  Filter({super.key});
  bool isShowCalender = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar:
            AppBar(title: const Text('Filter'), backgroundColor: Colors.black),
        body: SingleChildScrollView(
            child: Column(children: [
          Marketcap(),
          SizedBox(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'Countries',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Alle",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountrySelect()));
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'Industry',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Alle",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndustrySelect(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                        title: const Text(
                          'IPO',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: const Text(
                          "Calendar",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      CreateChart13(parentData[6])));
                        })
                  ])))
        ])));
  }
}
