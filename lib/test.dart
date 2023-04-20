// ignore_for_file: avoid_web_libraries_in_flutter

/*
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 30),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Center(
              child: SizedBox(
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:aktientool/webpage/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:js' as js;

import 'webpage/screen_helper.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late PageController _pageController;

  List listquality = [
    "Warren Buffett,Hagstrom Screen,url",
    "Ronald Muhlenkamp,ROE Screen,url",
    "Joseph Piotroski,High F-Score Screen,url",
  ];

  List listgrowth = [
    "Jim Slater,ZULU Screen,url",
    "William O'Neil,CAN-SLIM Screen,url",
    "Martin Zweig,Growth Screen,url",
    "T Rowe Price,T Rowe Price Screen,url",
    "Philip Fisher,Growth Screen,url",
    "Peter Lynch,Growth Screen,url",
  ];

  List listvalue = [
    "Benjamin Graham,Enterprising Investor Screen,url",
    "Ludwig Chincarini,Neglected Firms Screen,url",
    "Bill Miller,Contrarian Value Screen,url",
    "John Templeton,Bargain Screen,url",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  loadCardQuality(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++) createCard(list[i].toString())
    ]);
  }

  loadCardGrowth(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++) createCard(list[i].toString())
    ]);
  }

  loadCardValue(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++) createCard(list[i].toString())
    ]);
  }

  createCard(
    String txt,
  ) {
    // split txt
    List<String> result = txt.split(',');
    return SizedBox(
      width: ScreenHelper.isMobile(context)
          ? MediaQuery.of(context).size.width / 1.0
          : (MediaQuery.of(context).size.width / 4.0),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Image.asset(
                    'assets/images/${result[0]}.png',
                  ),
                  subtitle: Text(result[0]),
                  title: Text(result[1]),
                  trailing: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.bookAtlas),
                    color: kPrimaryColor,
                    iconSize: 40,
                    onPressed: () async {
                      js.context.callMethod(
                          'open', ["https://www.instagram.com/aktientool/"]);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Strategy'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('READ BOOK'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guru Strategy"),
      ),
      body: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                  onTap: (value) {
                    print("Tab$value");
                  },
                  unselectedLabelColor: kPrimaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: kPrimaryColor),
                  tabs: [
                    Container(color: Colors.transparent),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: kPrimaryColor, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Quality"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: kPrimaryColor, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Growth"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: kPrimaryColor, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Value"),
                        ),
                      ),
                    ),
                    Container(color: Colors.transparent),
                  ]),
            ),
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(color: Colors.transparent),
                  loadCardQuality(listquality),
                  loadCardGrowth(listgrowth),
                  loadCardValue(listvalue),
                  Container(color: Colors.transparent),
                ]),
          )),
    );
  }
}
