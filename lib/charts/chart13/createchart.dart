import 'dart:developer';

import 'package:aktientool/charts/chart13/data.dart';
import 'package:aktientool/charts/chart13/datagridwidget.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';

class CreateChart13 extends StatefulWidget {
  const CreateChart13({super.key});

  @override
  State<CreateChart13> createState() => CreateChart13State();
}

class CreateChart13State extends State<CreateChart13> {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  loadData() {
    log('api key : ${Env.fmpKey}');
    return RemoteService().getData(
        "https://financialmodelingprep.com/api/v3/ipo_calendar?&apikey=${Env.fmpKey}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('IPO Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<dynamic>(
                future: loadData(),
                builder: (
                  context,
                  snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Container(
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
                              child: DataGridWidget(
                                  companyInfoList: snapshot.data)),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
