import 'package:aktientool/charts/chart0/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../webpage/constants.dart';
import 'dart:html' as html;

class CreateChart0 extends StatefulWidget {
  const CreateChart0({super.key});

  @override
  State<CreateChart0> createState() => CreateChart0State();
}

class CreateChart0State extends State<CreateChart0> {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  loadData() {
    return RemoteService().getData(
        "https://financialmodelingprep.com/api/v3/profile/$stock?apikey=${Env.fmpKey}");
  }

  @override
  Widget build(BuildContext context) {
    print("symbol $stock");

    return Column(
      children: [
        FutureBuilder<dynamic>(
            future: loadData(),
            builder: (
              context,
              snapshot,
            ) {
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
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                snapshot.data[0].image.toString(),
                                width: 100.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Divider(),
                                /*Expanded(
                                  child: Divider(
                                    indent: 20.0,
                                    endIndent: 10.0,
                                    thickness: 1,
                                  ),
                                ),
                                
                                Text(
                                  snapshot.data[0].companyName.toString(),
                                  style: const TextStyle(
                                      color: kPrimaryColor, fontSize: 30),
                                ),
                                const Expanded(
                                  child: Divider(
                                    indent: 10.0,
                                    endIndent: 20.0,
                                    thickness: 1,
                                  ),
                                ),
                                */
                              ],
                            ),
                            const Text(""),
                            Text(
                              'Exchange: ${snapshot.data[0].exchangeShortName}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const Divider(),
                            Text(
                              'Sektor: ${snapshot.data[0].sector} / ${snapshot.data[0].industry}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const Divider(),
                            Text(
                              "Börsenwert: " + snapshot.data[0].mktCap,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const Divider(),
                            TextButton(
                              onPressed: () {
                                html.window.open(
                                    'https://www.google.com/search?q=${snapshot.data[0].ceo}',
                                    snapshot.data[0].ceo);
                              },
                              child: Text(
                                "Ceo: " + snapshot.data[0].ceo,
                                style: const TextStyle(
                                    fontSize: 16, color: kPrimaryColor),
                              ),
                            ),
                            const Divider(),
                            Text(
                              "Mitarbeiter: " +
                                  (snapshot.data[0].fullTimeEmployees ?? ""),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const Divider(),
                            Text(
                              "Börsengang: " + snapshot.data[0].ipoDate,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const Divider(),
                            Text(
                              "${"Sitz: " + snapshot.data[0].city}, " +
                                  (snapshot.data[0].state ?? ""),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Divider(),
                            Text(
                              snapshot.data[0].description + "\n",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Divider(
                                    indent: 20.0,
                                    endIndent: 10.0,
                                    thickness: 1,
                                  ),
                                ),
                                const Text(
                                  "Öffne : ",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    launch(snapshot.data[0].website);
                                  },
                                  child: Text(
                                    (snapshot.data[0].website)
                                        .toString()
                                        .replaceAll("https://www.", "")
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 16, color: kPrimaryColor),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    indent: 10.0,
                                    endIndent: 20.0,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
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
