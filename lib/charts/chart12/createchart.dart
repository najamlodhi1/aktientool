import 'package:aktientool/charts/chart12/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateChart12 extends StatefulWidget {
  const CreateChart12({super.key});

  @override
  State<CreateChart12> createState() => CreateChart12State();
}

class CreateChart12State extends State<CreateChart12> {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  loadData() {
    return RemoteService().getData(
        "https://financialmodelingprep.com/api/v3/historical-price-full/stock_dividend/$stock?apikey=${Env.fmpKey}");
  }

  @override
  Widget build(BuildContext context) {
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
                            RichText(
                              text: TextSpan(
                                text: 'Dividend History \n',
                                style: GoogleFonts.oswald(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Declared ${snapshot.data[0].declarationDate}\n',
                                  ),
                                  TextSpan(
                                    text:
                                        'Record ${snapshot.data[0].recordDate}\n',
                                  ),
                                  TextSpan(
                                    text:
                                        'Payable ${snapshot.data[0].paymentDate}\n',
                                  ),
                                  TextSpan(
                                    text:
                                        'Amount ${snapshot.data[0].dividend}\$\n',
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
