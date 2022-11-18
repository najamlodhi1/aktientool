// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:aktientool/home.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

class Geld extends StatelessWidget {
  const Geld({super.key});

  Widget buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Das Analysetool wird gerade programmiert..'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Verstanden'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: <Widget>[
          InkWell(
            onTap: () async {
              js.context.callMethod(
                'open',
                ['https://de.scalable.capital/einladung/b3pkdh'],
              );
            },
            child: Container(
              width: 350,
              height: 596,
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(2.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Column(
                children: [
                  Wrap(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/scallable.png',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
            child: Container(
              width: 350,
              height: 596,
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                children: [
                  Wrap(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/tool.png',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              js.context.callMethod('open', [
                'https://www.youtube.com/channel/UCYMfu0xZgSTiNLjJLQ9zJhA?sub_confirmation=1'
              ]);
            },
            child: Container(
              width: 350,
              height: 596,
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                children: [
                  Wrap(
                    children: <Widget>[
                      Image.asset('assets/images/youtube.png'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              js.context.callMethod('open', ['https://amzn.to/3n7Y6ym']);
            },
            child: Container(
              width: 350,
              height: 596,
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Column(
                children: [
                  Wrap(
                    children: <Widget>[
                      Image.asset('assets/images/amazon.png'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
