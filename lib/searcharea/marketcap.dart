import 'package:flutter/material.dart';

class Marketcap extends StatefulWidget {
  const Marketcap({super.key});

  @override
  State<Marketcap> createState() => _MarketcapState();
}

class _MarketcapState extends State<Marketcap> {
  List<Map> generatedCountrieFromList = [];
  final List<bool> _isSelected = [false, false, false, true];
  String text_marketcap = "> 50 Milliarden EUR";
  var icon = Icons.search;

  final List<String> _marketcap = [
    "> 1 Milliarde EUR",
    "> 10 Milliarden EUR",
    "> 25 Milliarden EUR",
    "> 50 Milliarden EUR",
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget marketCap() {
    return SizedBox(
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blue,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(icon, size: 25),
              title: const Text("Marktapitalisierung",
                  style: TextStyle(
                      color: Color.fromARGB(255, 69, 69, 69), fontSize: 18)),
              subtitle: Text(text_marketcap,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              child: ToggleButtons(
                constraints: const BoxConstraints(
                    maxWidth: 69, minWidth: 69, minHeight: 39, maxHeight: 69),
                borderWidth: 3,
                // ignore: sort_child_properties_last
                children: const [
                  Text(">1",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(">10",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(">25",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(">50",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
                isSelected: _isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      _isSelected[i] = i == index;
                      text_marketcap = _marketcap[index].toString();
                    }
                  });
                },
                // region example 1
                color: Colors.white,
                selectedColor: Colors.white,
                fillColor: Colors.lightBlueAccent,
                // endregion
                // region example 2
                borderColor: Colors.lightBlueAccent,
                selectedBorderColor: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                // endregion
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 0), child: marketCap());
  }
}
