// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:aktientool/webpage/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:js' as js;

import 'webpage/screen_helper.dart';

class FilterArea extends StatefulWidget {
  const FilterArea({super.key});

  @override
  State<FilterArea> createState() => _FilterAreaState();
}

class _FilterAreaState extends State<FilterArea> {
  late PageController _pageController;
  int selectedItem = 0;
  //List selectquality = [0, 0, 0];

  List listquality = [
    "Warren Buffett,Hagstrom Screen,1,url",
    "Ronald Muhlenkamp,ROE Screen,2,url",
    "Joseph Piotroski,High F-Score Screen,3,url",
  ];

  List listgrowth = [
    "Jim Slater,ZULU Screen,4,url",
    "William O'Neil,CAN-SLIM Screen,5,url",
    "Martin Zweig,Growth Screen,6,url",
    "T Rowe Price,T Rowe Price Screen,7,url",
    "Philip Fisher,Growth Screen,8,url",
    "Peter Lynch,Growth Screen,9,url",
  ];

  List listvalue = [
    "Benjamin Graham,Enterprising Investor Screen,10,url",
    "Ludwig Chincarini,Neglected Firms Screen,11,url",
    "Bill Miller,Contrarian Value Screen,12,url",
    "John Templeton,Bargain Screen,13,url",
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
            shape: (selectedItem == int.parse(result[2]))
                ? const RoundedRectangleBorder(
                    side: BorderSide(color: kPrimaryColor, width: 3))
                : null,
            elevation: 3,
            child: InkWell(
              onTap: () => setState(() {
                print("${result[2]} ${result[1]}");
                selectedItem = int.parse(result[2]);
              }),
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
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('READ STRATEGY'),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 50,
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
                color: kPrimaryColor,
              ),
              tabs: [
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
                      child: Text("Financials"),
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
              ]),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              loadCardQuality(listquality),
              loadCardGrowth(listgrowth),
              loadCardValue(listvalue),
            ]),
      ),
    );
  }
}



/*

*/