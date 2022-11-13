import 'package:flutter/material.dart';
import 'dart:js' as js;

class Beitrag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: <Widget>[
          Container(
            width: 365,
            height: 200,
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Column(
              children: [
                Wrap(
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        js.context.callMethod('open', [
                          'https://www.youtube.com/channel/UCYMfu0xZgSTiNLjJLQ9zJhA?sub_confirmation=1'
                        ]);
                      },
                      child: Image.asset('web/images/investments.png',
                          width: 400, height: 190, fit: BoxFit.fill),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 365,
            height: 200,
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Column(
              children: [
                Wrap(
                  children: <Widget>[
                    InkWell(
                      /*onTap: () async {
                        js.context.callMethod('open', [
                          'https://www.youtube.com/channel/UCYMfu0xZgSTiNLjJLQ9zJhA?sub_confirmation=1'
                        ]);
                      },*/
                      child: Image.asset('web/images/blog.png',
                          width: 400, height: 194, fit: BoxFit.fill),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              js.context.callMethod('open', ['https://amzn.to/3n7Y6ym']);
            },
            child: Container(
              width: 365,
              height: 200,
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(2.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Column(
                children: [
                  Wrap(
                    children: <Widget>[
                      const Center(),
                      Image.asset('web/images/buch.png',
                          width: 400, height: 194, fit: BoxFit.fill),
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
