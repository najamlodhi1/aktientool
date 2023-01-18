import 'package:aktientool/charts/chart0/data.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';

class CreateChart0 extends StatefulWidget {
  @override
  State<CreateChart0> createState() => CreateChart0State();
}

class CreateChart0State extends State<CreateChart0> {
  var selectedDate = DateTime.now();
  static String modifiedDate = "";
  // Für 4 h
  //https://financialmodelingprep.com/api/v3/historical-chart/4hour/AAPL?apikey=9ad9c8dfa54c11aff6c1489d109e87b6";
  var fromURL = "";
  int yearsBack = 10;

  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  @override
  initState() {
    super.initState();
    RemoteService().getData(fromURL);
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(const Color.fromARGB(255, 58, 255, 202));
    color.add(const Color.fromARGB(255, 33, 254, 195));
    color.add(const Color.fromARGB(255, 0, 255, 200));

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);

    modifiedDate = DateTime(
            selectedDate.year - yearsBack, selectedDate.month, selectedDate.day)
        .toString()
        .substring(0, 10);
    //print("$stock $modifiedDate");

    fromURL =
        "https://financialmodelingprep.com/api/v3/profile/$stock?apikey=9ad9c8dfa54c11aff6c1489d109e87b6";

    return Column(
      children: [
        FutureBuilder(
            future: RemoteService().getData(fromURL),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Wrap(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.teal,
                            style: BorderStyle.none,
                            width: 2,
                          ),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                children: const [],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}
