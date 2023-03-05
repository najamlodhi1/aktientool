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
  final primaryColor = const Color(0xff442881);
  final secondaryColor = const Color(0xff5B2D90);
  double? apppadding = 50;
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  Future<CompanyInfo> loadData() {
    return RemoteService().getData(
        "https://financialmodelingprep.com/api/v3/profile/$stock?apikey=${Env.fmpKey}");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CompanyInfo>(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: LayoutBuilder(builder: (_, c) {
                final width = c.maxWidth;
                var fontSize = 16.0;
                if (width <= 480) {
                  fontSize = 16.0;
                } else if (width > 480 && width <= 960) {
                  fontSize = 30.0;
                } else {
                  fontSize = 50.0;
                }
                return Column(
                  children: [
                    Container(
                        // margin: const EdgeInsets.only(left: 30, right: 30),
                        padding: const EdgeInsets.all(30),
                        width: double.maxFinite,
                        color: primaryColor,
                        child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(children: [
                              Image.network(snapshot.data!.image.toString(),
                                  width: 300),
                              const SizedBox(height: 20),
                              Text(snapshot.data!.companyName.toString(),
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Container(
                                  color: Colors.black,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Aktien Analyse",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold)))),
                              const SizedBox(height: 10),
                              Text("${snapshot.data!.description}\n",
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.justify),
                            ]))),
                    const SizedBox(height: 30),
                    Container(
                      color: Colors.black,
                      child: c.maxWidth > 500
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: leftwidget(snapshot.data!)),
                                Expanded(
                                    flex: 2, child: rightwidget(snapshot.data!))
                              ],
                            )
                          : Column(
                              children: [
                                leftwidget(snapshot.data!),
                                rightwidget(snapshot.data!)
                              ],
                            ),
                    )
                  ],
                );
              }),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildGridViewItem(String title, value) {
    return LayoutBuilder(builder: (_, c) {
      final width = c.maxWidth;
      var fontSize = 16.0;
      if (width <= 480) {
        fontSize = 16.0;
      } else if (width > 480 && width <= 960) {
        fontSize = 20.0;
      } else {
        fontSize = 25.0;
      }
      return Container(
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    });
  }

  Widget leftwidget(CompanyInfo data) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
                  height: 400,
                  width: 300,
                  child: Column(
                    children: [
                      Image.network(data.image.toString(), height: 100),
                      TextButton(
                        onPressed: () {
                          html.window.open(
                              'https://www.google.com/search?q=${data.ceo}',
                              data.ceo);
                        },
                        child: Text(
                          'By ${data.ceo}',
                          style: const TextStyle(
                              fontSize: 16, color: kPrimaryColor),
                        ),
                      ),
                    ],
                  )),
              Container(
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(200),
                        bottomRight: Radius.circular(200))),
                padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
                height: 150,
                width: 300,
              )
            ],
          )),
    );
  }

  Widget rightwidget(CompanyInfo data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: GridView.count(
            childAspectRatio: 20 / 9,
            clipBehavior: Clip.antiAlias,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: [
              _buildGridViewItem("Exchange", data.exchangeShortName),
              _buildGridViewItem("Sektor", "${data.sector} / ${data.industry}"),
              _buildGridViewItem("Börsenwert", data.mktCap),
              _buildGridViewItem("Mitarbeiter", data.fullTimeEmployees),
              _buildGridViewItem("Börsengang", data.ipoDate),
              _buildGridViewItem("Sitz", data.city + data.state),
            ],
          ),
        ),
      ],
    );
  }
}
