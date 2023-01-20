import 'package:aktientool/charts/chart0/data.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';

class CreateChart0 extends StatefulWidget {
  @override
  State<CreateChart0> createState() => CreateChart0State();
}

class CreateChart0State extends State<CreateChart0> {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";
  var fromURL = "";

  @override
  Widget build(BuildContext context) {
    fromURL =
        "https://financialmodelingprep.com/api/v3/profile/$stock?apikey=9ad9c8dfa54c11aff6c1489d109e87b6";

    return Column(
      children: [
        FutureBuilder<dynamic>(
            future: RemoteService().getData(fromURL),
            builder: (
              BuildContext context,
              AsyncSnapshot<dynamic> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.done) {
                //final splitted = snapshot.data.toString().split(' ');
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
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Image.network(
                              snapshot.data[0].image.toString(),
                              width: 100.0,
                            ),
                            /*
                              RichText(
                                text: TextSpan(
                                  text: '${snapshot.data[0].companyName}\n',
                                  children: [
                                    TextSpan(
                                      text:
                                          "${"Marktkapitalisierung: " + snapshot.data[0].mktCap} \n",
                                    ),
                                    TextSpan(
                                      text: snapshot.data[0].exchangeShortName +
                                          "\n",
                                    ),
                                    TextSpan(
                                      text: snapshot.data[0].sector + "\n",
                                    ),
                                    TextSpan(
                                      text: snapshot.data[0].industry + "\n",
                                    ),
                                    TextSpan(
                                      text: snapshot.data[0].website + "\n",
                                    ),
                                    TextSpan(
                                      text: snapshot.data[0].description + "\n",
                                    ),
                                    TextSpan(
                                      text:
                                          "${"Mitarbeiter: " + snapshot.data[0].fullTimeEmployees}\n",
                                    ),
                                    TextSpan(
                                      text:
                                          "${"Börsengang: " + snapshot.data[0].ipoDate}\n",
                                    ),
                                    TextSpan(
                                      text: snapshot.data[0].ceo + "\n",
                                    ),
                                    
                                  ],
                                ),
                              ),
                              */
                          ],
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
