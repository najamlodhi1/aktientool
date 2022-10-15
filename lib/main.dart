import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'constants.dart';

//
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FundamentalWidget {
  const FundamentalWidget(this.name);
  final String name;
}

class SektorWidget {
  const SektorWidget(this.name);
  final String name;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textHeader = "Land und Sektor auswählen";
  String textland = 'Land und Sektor';
  String tileImage = 'images/false.gif';
  String textsektor = '';
  bool alleAuswaehlen = false;
  bool visiblefundamentaleKennzeichen = false;
  bool alle = true;
  int marktkapitalisierung = 50;
  late List<FundamentalWidget> _fundamental;
  late List<LandWidget> _land;
  late List<SektorWidget> _sektor;
  List<String> _filtersLand = <String>[];
  List<String> _filtersSektor = <String>[];
  bool selectMarktkapitalisierung = false;
  bool _customTileExpanded = false;

  @override
  void initState() {
    super.initState();

    _land = <LandWidget>[
      LandWidget("Alle"),
      LandWidget("USA"),
      LandWidget("Deutschland"),
      LandWidget("Australien"),
      LandWidget("Belgien"),
      LandWidget("Bermuda"),
      LandWidget("China"),
      LandWidget("Dänemark"),
      LandWidget("Finnland"),
      LandWidget("Frankreich"),
      LandWidget("Großbritanien"),
      LandWidget("Hong-Kong"),
      LandWidget("Irland"),
      LandWidget("Israel"),
      LandWidget("Italien"),
      LandWidget("Kanada"),
      LandWidget("Luxemburg"),
      LandWidget("Niederlande"),
      LandWidget("Norwegen"),
      LandWidget("Österreich"),
      LandWidget("Schweden"),
      LandWidget("Schweiz"),
      LandWidget("Singapur"),
      LandWidget("Spanien"),
      LandWidget("Japan"),
      LandWidget("Südkorea"),
      LandWidget("Griechenland"),
      LandWidget("Malta"),
      LandWidget("Polen"),
      LandWidget("Portugal"),
      LandWidget("Zypern"),
      LandWidget("Russland"),
      LandWidget("Taiwan"),
      LandWidget("Indien"),
      LandWidget("Neuseeland"),
      LandWidget("Brasilien"),
      LandWidget("Chile"),
      LandWidget("Südafrika"),
      LandWidget("Kaimaninseln"),
    ];

    _sektor = <SektorWidget>[
      SektorWidget("Alle"),
      SektorWidget("Anlagenbau Zulieferer"),
      SektorWidget("Autos/Ersatzteile"),
      SektorWidget("Banken"),
      SektorWidget("Bau"),
      SektorWidget("Baumarkt-Produkte"),
      SektorWidget("Biotechnologie"),
      SektorWidget("Chemie"),
      SektorWidget("Container/Verpackung"),
      SektorWidget("Digitales Geld"),
      SektorWidget("Einzelhandel gemischt"),
      SektorWidget("Einzelhandel spezialisiert"),
      SektorWidget("Elektrizität"),
      SektorWidget("Elektro-Teile"),
      SektorWidget("Energie Dienstleister"),
      SektorWidget("Erdöl/Gas"),
      SektorWidget("Fonds"),
      SektorWidget("Fracht und Logistik"),
      SektorWidget("Fracht und Passagiere"),
      SektorWidget("Freizeitprodukte"),
      SektorWidget("Gas"),
      SektorWidget("Gesundheitspflege"),
      SektorWidget("Gesundheitspflege Geräte"),
      SektorWidget("Getränke"),
      SektorWidget("Halbleiter und Zubehör"),
      SektorWidget("Handel Nahrung/Medizin"),
      SektorWidget("Handelsgesellschaft"),
      SektorWidget("Haushalts-/Pflegeprodukte"),
      SektorWidget("Haushaltswaren"),
      SektorWidget("Holding"),
      SektorWidget("Hotels/Unterhaltung"),
      SektorWidget("Immobilien"),
      SektorWidget("Industriekonglomerate"),
      SektorWidget("Industrielle Dienste"),
      SektorWidget("Industrielle Lieferanten"),
      SektorWidget("Investment Services"),
      SektorWidget("Investment Trusts"),
      SektorWidget("Kommunikation"),
      SektorWidget("Kommunikation Ausrüster"),
      SektorWidget("Lebensmittel & Tabak"),
      SektorWidget("Maschinen"),
      SektorWidget("Maschinen/Zubehör"),
      SektorWidget("Medien"),
      SektorWidget("Metall/Abbau"),
      SektorWidget("Pharmazie"),
      SektorWidget("REIT"),
      SektorWidget("Raumfahrt/Verteidigung"),
      SektorWidget("Smart Contracts"),
      SektorWidget("Software/IT Dienste"),
      SektorWidget("Technische Konsumgüter"),
      SektorWidget("Textil - Kleidung"),
      SektorWidget("Transport Infrastruktur"),
      SektorWidget("Versicherungen"),
      SektorWidget("Versorger"),
      SektorWidget("Wasser"),
    ];

    _fundamental = <FundamentalWidget>[
      FundamentalWidget('Marktkapitalisierung'),
      FundamentalWidget('KUV'),
      FundamentalWidget('KGV'),
      FundamentalWidget('KBV'),
      FundamentalWidget('Div-Rendite'),
      FundamentalWidget('Free Cashflow letztes Jahr'),
      FundamentalWidget('EV/EBITDA aktuell'),
    ];
  }

  Widget LandundSektoren() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: const Size.fromRadius(20),
            child: Image.asset(
              tileImage,
              fit: BoxFit.cover,
            ),
          ),
        ),

        onExpansionChanged: (bool expanded) {
          setState(() {
            if (expanded) {
              tileImage = 'images/true.gif';
            } else {
              tileImage = 'images/false.gif';
            }
          });
        },

        collapsedTextColor: Colors.black,
        collapsedBackgroundColor: Colors.white,
        collapsedIconColor: Colors.red,
        textColor: Colors.blue,
        backgroundColor: Colors.black, // kompletter Hintergrund
        //key: closeKey,
        title: Text(textland),
        subtitle: Text(textsektor),
        iconColor: Colors.grey,
        // Contents
        children: [
          Container(
              width: 1000,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              child: Column(
                children: [
                  Text(
                    '1. Land auswählen',
                    style: kStyleDefault.copyWith(
                      color: Colors.blue,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(children: LandFilter.toList()),
                ],
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
              width: 1000,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              child: Column(
                children: [
                  Text(
                    '2. Sektor auswählen',
                    style: kStyleDefault.copyWith(
                      color: Colors.blue,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(children: SektorFilter.toList()),
                ],
              )),
        ],
      ),
    );
  }

  Widget custumizedButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: LiteRollingSwitch(
        value: true,
        width: 155,
        textOn: 'Alle auswählen',
        textOff: 'Alle abwählen',
        colorOn: Color.fromARGB(255, 34, 255, 133),
        colorOff: Color.fromARGB(255, 248, 19, 19),
        iconOn: Icons.done,
        iconOff: Icons.clear,
        animationDuration: const Duration(milliseconds: 300),
        onChanged: (bool state) {
          setState(() {
            alleAuswaehlen = !state;
          });
        },
        onDoubleTap: () {},
        onSwipe: () {},
        onTap: () {},
      ),
    );
  }

  Iterable<Widget> get LandFilter sync* {
    for (LandWidget land in _land) {
      yield FilterChip(
        label: Text(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          land.name,
        ),
        selected: _filtersLand.contains(land.name),
        selectedColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        showCheckmark: false,
        //avatar: CircleAvatar(backgroundColor: Colors.amber),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              if (land.name == "Alle") {
                _filtersLand.clear();
                if (alle == true) {
                  _filtersLand.add("USA");
                  _filtersLand.add("Deutschland");
                  _filtersLand.add("Australien");
                  _filtersLand.add("Belgien");
                  _filtersLand.add("Bermuda");
                  _filtersLand.add("China");
                  _filtersLand.add("Dänemark");
                  _filtersLand.add("Finnland");
                  _filtersLand.add("Frankreich");
                  _filtersLand.add("Großbritanien");
                  _filtersLand.add("Hong-Kong");
                  _filtersLand.add("Irland");
                  _filtersLand.add("Israel");
                  _filtersLand.add("Italien");
                  _filtersLand.add("Kanada");
                  _filtersLand.add("Luxemburg");
                  _filtersLand.add("Niederlande");
                  _filtersLand.add("Norwegen");
                  _filtersLand.add("Österreich");
                  _filtersLand.add("Schweden");
                  _filtersLand.add("Schweiz");
                  _filtersLand.add("Singapur");
                  _filtersLand.add("Spanien");
                  _filtersLand.add("Japan");
                  _filtersLand.add("Südkorea");
                  _filtersLand.add("Griechenland");
                  _filtersLand.add("Malta");
                  _filtersLand.add("Polen");
                  _filtersLand.add("Portugal");
                  _filtersLand.add("Zypern");
                  _filtersLand.add("Russland");
                  _filtersLand.add("Taiwan");
                  _filtersLand.add("Indien");
                  _filtersLand.add("Neuseeland");
                  _filtersLand.add("Brasilien");
                  _filtersLand.add("Chile");
                  _filtersLand.add("Südafrika");
                  _filtersLand.add("Kaimaninseln");
                }
              }
              _filtersLand.add(land.name);

              if (_filtersLand.toList().length == 38) {
                _filtersLand.add("Alle");
              }
            } else {
              _filtersLand.remove("Alle");

              if (land.name == "Alle") {
                _filtersLand.clear();
              } else if (land.name != "Alle") {
                //_filters.clear();

                _filtersLand.remove(land.name);
              } else {
                _filtersLand.remove(land.name);
              }
            }

            print(_filtersLand.toList());
            textland = "";
            textland = "Land: ${_filtersLand.toList()}";
            if (_filtersLand.toList().contains("Alle")) {
              textland = "Land: [Alle]";
            }
          });
        },
      );
    }
  }

  Iterable<Widget> get SektorFilter sync* {
    for (SektorWidget sektor in _sektor) {
      yield FilterChip(
        label: Text(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          sektor.name,
        ),
        selected: _filtersSektor.contains(sektor.name),
        selectedColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.black,
        //showCheckmark: false,
        //avatar: CircleAvatar(backgroundColor: Colors.amber),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              if (sektor.name == "Alle") {
                _filtersSektor.clear();

                if (alle == true) {
                  _filtersSektor.add("Anlagenbau Zulieferer");
                  _filtersSektor.add("Autos/Ersatzteile");
                  _filtersSektor.add("Banken");
                  _filtersSektor.add("Bau");
                  _filtersSektor.add("Baumarkt-Produkte");
                  _filtersSektor.add("Biotechnologie");
                  _filtersSektor.add("Chemie");
                  _filtersSektor.add("Container/Verpackung");
                  _filtersSektor.add("Digitales Geld");
                  _filtersSektor.add("Einzelhandel gemischt");
                  _filtersSektor.add("Einzelhandel spezialisiert");
                  _filtersSektor.add("Elektrizität");
                  _filtersSektor.add("Elektro-Teile");
                  _filtersSektor.add("Energie Dienstleister");
                  _filtersSektor.add("Erdöl/Gas");
                  _filtersSektor.add("Fonds");
                  _filtersSektor.add("Fracht und Logistik");
                  _filtersSektor.add("Fracht und Passagiere");
                  _filtersSektor.add("Freizeitprodukte");
                  _filtersSektor.add("Gas");
                  _filtersSektor.add("Gesundheitspflege");
                  _filtersSektor.add("Gesundheitspflege Geräte");
                  _filtersSektor.add("Getränke");
                  _filtersSektor.add("Halbleiter und Zubehör");
                  _filtersSektor.add("Handel Nahrung/Medizin");
                  _filtersSektor.add("Handelsgesellschaft");
                  _filtersSektor.add("Haushalts-/Pflegeprodukte");
                  _filtersSektor.add("Haushaltswaren");
                  _filtersSektor.add("Holding");
                  _filtersSektor.add("Hotels/Unterhaltung");
                  _filtersSektor.add("Immobilien");
                  _filtersSektor.add("Industriekonglomerate");
                  _filtersSektor.add("Industrielle Dienste");
                  _filtersSektor.add("Industrielle Lieferanten");
                  _filtersSektor.add("Investment Services");
                  _filtersSektor.add("Investment Trusts");
                  _filtersSektor.add("Kommunikation");
                  _filtersSektor.add("Kommunikation Ausrüster");
                  _filtersSektor.add("Lebensmittel & Tabak");
                  _filtersSektor.add("Maschinen");
                  _filtersSektor.add("Maschinen/Zubehör");
                  _filtersSektor.add("Medien");
                  _filtersSektor.add("Metall/Abbau");
                  _filtersSektor.add("Pharmazie");
                  _filtersSektor.add("REIT");
                  _filtersSektor.add("Raumfahrt/Verteidigung");
                  _filtersSektor.add("Smart Contracts");
                  _filtersSektor.add("Software/IT Dienste");
                  _filtersSektor.add("Technische Konsumgüter");
                  _filtersSektor.add("Textil - Kleidung");
                  _filtersSektor.add("Transport Infrastruktur");
                  _filtersSektor.add("Versicherungen");
                  _filtersSektor.add("Versorger");
                  _filtersSektor.add("Wasser");
                }
              }
              _filtersSektor.add(sektor.name);

              if (_filtersSektor.toList().length == 54) {
                _filtersSektor.add("Alle");
              }
            } else {
              _filtersSektor.remove("Alle");

              if (sektor.name == "Alle") {
                _filtersSektor.clear();
              } else if (sektor.name != "Alle") {
                _filtersSektor.remove(sektor.name);
              } else {
                _filtersSektor.remove(sektor.name);
              }
            }
            print(_filtersSektor.toList());
            textsektor = "";

            textsektor = "Sektor: ${_filtersSektor.toList()}";
            if (_filtersSektor.toList().contains("Alle")) {
              textsektor = "Sektor: [Alle]";
            }
          });
        },
      );
    }
  }

  Widget Marktkapitalisierung() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Text(
                    "Marktkapitalisierung: $marktkapitalisierung Mio EUR",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                child: const Text(
                  "+",
                  style: TextStyle(fontSize: 55, color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    marktkapitalisierung = marktkapitalisierung + 1;
/*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataPage()),
                    );
*/
                  });
                },
              ),
              ElevatedButton(
                child: const Text(
                  "-",
                  style: TextStyle(fontSize: 55, color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    marktkapitalisierung = marktkapitalisierung - 1;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: InkWell(
            onTap: () {
              print(textHeader);
            },
            child: Text("Aktientool-Test1"),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LandundSektoren(),
              Marktkapitalisierung(),
            ],
          ),
        ),
      ),
    );
  }
}
