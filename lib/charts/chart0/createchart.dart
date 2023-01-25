import 'package:aktientool/charts/chart0/data.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/gestures.dart';
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
  var fromURL = "";
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "PLTR";

  loadData() {
    return RemoteService().getData(
        "https://financialmodelingprep.com/api/v3/profile/$stock?apikey=9ad9c8dfa54c11aff6c1489d109e87b6");
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
                            RichText(
                              text: TextSpan(
                                text: '',
                                style: GoogleFonts.oswald(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${snapshot.data[0].companyName}',
                                    style: GoogleFonts.oswald(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' (${snapshot.data[0].exchangeShortName})\n',
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Sektor: ${snapshot.data[0].sector} / ${snapshot.data[0].industry}\n',
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${"Börsenwert: " + snapshot.data[0].mktCap}\n",
                                    style: GoogleFonts.oswald(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${"Ceo: " + snapshot.data[0].ceo}\n",
                                  ),
                                  TextSpan(
                                    text:
                                        "${"Mitarbeiter: " + snapshot.data[0].fullTimeEmployees}\n",
                                  ),
                                  TextSpan(
                                    text:
                                        "${"Börsengang: " + snapshot.data[0].ipoDate}\n",
                                  ),
                                  const TextSpan(
                                    text: "Öffne: ",
                                  ),
                                  TextSpan(
                                    text: snapshot.data[0].website + "\n",
                                    style: const TextStyle(
                                        color: kPrimaryColor, fontSize: 18),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launch(snapshot.data[0].website);
                                      },
                                  ),
                                  const TextSpan(
                                    text: "\n",
                                  ),
                                  TextSpan(
                                    text: snapshot.data[0].description + "\n",
                                  ),
                                ],
                              ),
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
