import 'package:aktientool/charts/chart0/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../webpage/constants.dart';

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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
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
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                text: "\n",
                                style: GoogleFonts.oswald(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Exchange: ${snapshot.data[0].exchangeShortName}\n',
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Sektor: ${snapshot.data[0].sector} / ${snapshot.data[0].industry}\n',
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${"Börsenwert: " + snapshot.data[0].mktCap}\n",
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${"Ceo: " + snapshot.data[0].ceo}\n",
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${"Mitarbeiter: " + snapshot.data[0].fullTimeEmployees}\n",
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${"Börsengang: " + snapshot.data[0].ipoDate}\n",
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "\n",
                                  ),
                                ],
                              ),
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
                                  "Mehr auf: ",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    launch(snapshot.data[0].website);
                                  },
                                  child: Text(
                                    (snapshot.data[0].website)
                                        .toString()
                                        .replaceAll("https://www.", ""),
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
                            const Text(""),
                            Text(
                              snapshot.data[0].description + "\n",
                              style: const TextStyle(fontSize: 16),
                            )
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
