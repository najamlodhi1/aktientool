// ignore_for_file: avoid_web_libraries_in_flutter

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
  //List selectquality = [0, 0, 0];

  List listquality = [
    "Warren Buffett,Hagstrom Screen,1,https://amzn.to/3AyNoYv",
    "Ronald Muhlenkamp,ROE Screen,2,url,https://amzn.to/3AyvwwK",
    "Joseph Piotroski,High F-Score Screen,3,https://amzn.to/3oSgvDy",
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
    "Benjamin Graham,Enterprising Screen,10,url",
    "Ludwig Chincarini,Neglected Firms Screen,11,url",
    "Bill Miller,Contrarian Value Screen,12,url",
    "John Templeton,Bargain Screen,13,url",
  ];

  List shapeList = [
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect"
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
/*
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
*/

  loadCardQuality(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++)
        createCard(list[i].toString(), "Quality", Colors.green)
    ]);
  }

  loadCardGrowth(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++)
        createCard(list[i].toString(), "Growth", Colors.blue)
    ]);
  }

  loadCardValue(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++)
        createCard(list[i].toString(), "Value", Colors.red)
    ]);
  }

  createCard(String txt, String whichtype, var col) {
    List<String> result = txt.split(',');

    return SizedBox(
      width: ScreenHelper.isMobile(context)
          ? MediaQuery.of(context).size.width / 1.2
          : (MediaQuery.of(context).size.width / 5.0),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: SizedBox(
            height: 110,
            child: Card(
              color: col,
              shape: (shapeList[int.parse(result[2])] == "select")
                  ? const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3))
                  : null,
              elevation: 3,
              child: InkWell(
                onTap: () => setState(() {
                  if (shapeList[int.parse(result[2])] == "select") {
                    shapeList[int.parse(result[2])] = "unselect";
                  } else if (shapeList[int.parse(result[2])] == "unselect") {
                    shapeList = [
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect",
                      "unselect"
                    ];
                    shapeList[int.parse(result[2])] = "select";
                  }

                  print(
                      "${result[2]} ${"${result[1]} " + shapeList[int.parse(result[2])]}");
                }),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/images/${result[0]}.png'), // No matter how big it is, it won't overflow
                      ),
                      subtitle: Text(result[0]),
                      title: Text(result[1]),
                      trailing: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.amazon),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () async {
                          js.context.callMethod('open', [result[3]]);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(onPressed: null, child: Text(whichtype)),
                        const Spacer(),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text(
                            'READ STRATEGY',
                            style: TextStyle(color: Colors.white),
                          ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Divider(
            color: Colors.grey,
          ),
          const Align(
            alignment: FractionalOffset.topLeft,
            child: Text(
              "  Invest like a GURU",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            //margin: const EdgeInsets.symmetric(vertical: 5.0),
            height: 110.0,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                loadCardQuality(listquality),
                loadCardGrowth(listgrowth),
                loadCardValue(listvalue),
              ],
            ),
          ),
          const Text(
            " ",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          const Divider(
            color: Colors.grey,
          ),
          const Align(
            alignment: FractionalOffset.topLeft,
            child: Text(
              "  Or select MANUAL",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/*
                loadCardQuality(listquality),
                loadCardGrowth(listgrowth),
                loadCardValue(listvalue),
*/
