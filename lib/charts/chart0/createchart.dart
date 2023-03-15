import 'package:aktientool/charts/chart0/data.dart';
import 'package:aktientool/env/env.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 0, 0, 0);
const secondaryColor = Color(0xff5B2D90);

class CreateChart0 extends StatefulWidget {
  const CreateChart0({super.key});

  @override
  State<CreateChart0> createState() => CreateChart0State();
}

class CreateChart0State extends State<CreateChart0> {
  double? apppadding = 20;

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
                child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Die Inhalte stellen keine Anlageberatung oder Kaufempfehlung dar. Alle Angaben könnten komplett falsch sein!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                /*
                Container(
                  color: primaryColor,
                  padding: const EdgeInsets.all(10),
                  child: MediaQuery.of(context).size.width > 800
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: leftwidget(snapshot.data!),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Center(
                                        child: rightwidget(snapshot.data!))),
                              ],
                            ),
                            const SizedBox(
                              height: 550,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            rightwidget(snapshot.data!),
                            const SizedBox(height: 20),
                            leftwidget(snapshot.data!),
                            //discriptionWidget(snapshot.data!)
                          ],
                        ),
                ),
                */
                Container(
                    color: primaryColor,
                    padding: const EdgeInsets.all(20),
                    child: discriptionWidget(snapshot.data!)),
                const SizedBox(height: 10),
                Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GridView.count(
                            childAspectRatio: 20 / 9,
                            clipBehavior: Clip.antiAlias,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            shrinkWrap: true,
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 800 ? 3 : 2,
                            children: [
                              _buildGridViewItemName(
                                  snapshot.data!.companyName),
                              _buildGridViewItemImage(
                                  snapshot.data!.image.toString()),
                              _buildGridViewItem("Ceo", snapshot.data!.ceo),
                              _buildGridViewItem(
                                  "Exchange", snapshot.data!.exchangeShortName),
                              _buildGridViewItem("Sektor",
                                  "${snapshot.data!.sector} / ${snapshot.data!.industry}"),
                              _buildGridViewItem(
                                  "Börsenwert", snapshot.data!.mktCap),
                              _buildGridViewItem("Mitarbeiter",
                                  snapshot.data!.fullTimeEmployees),
                              _buildGridViewItem(
                                  "Börsengang", snapshot.data!.ipoDate),
                              _buildGridViewItem("Sitz",
                                  "${snapshot.data!.city} / ${snapshot.data!.state}"),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildGridViewItemImage(String image) {
    return Container(
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Image.network(image, width: 800));
  }

  Widget _buildGridViewItemName(String title) {
    return LayoutBuilder(builder: (_, c) {
      final width = c.maxWidth;
      var fontSize = 16.0;
      if (width <= 480) {
        fontSize = 16.0;
      } else if (width > 480 && width <= 960) {
        fontSize = 25.0;
      } else {
        fontSize = 50.0;
      }
      return Container(
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold)),
      );
    });
  }

  Widget _buildGridViewItem(String title, value) {
    return LayoutBuilder(builder: (_, c) {
      final width = c.maxWidth;
      var fontSize = 16.0;
      if (width <= 480) {
        fontSize = 16.0;
      } else if (width > 480 && width <= 960) {
        fontSize = 25.0;
      } else {
        fontSize = 50.0;
      }
      return Container(
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)
          ],
        ),
      );
    });
  }

  Widget rightwidget(CompanyInfo data) {
    return Image.network(
      data.image.toString(),
      fit: BoxFit.fill,
    );
  }

  Widget leftwidget(CompanyInfo data) {
    return LayoutBuilder(builder: (_, c) {
      final width = c.maxWidth;
      var fontSize = 100.0;
      if (width <= 480) {
        fontSize = 30.0;
      } else if (width > 480 && width <= 960) {
        fontSize = 100.0; // Apple Inc. Aktie Analyse gröse auf Laptop
      } else {
        fontSize = 50.0;
      }

      return Padding(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            Container(
                color: Colors.black,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${data.companyName}\nAktie Analyse",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold)))),
            //const SizedBox(height: 10),
            Container(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Aktie Analyse",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold)))),
          ]));
    });
  }

  Widget discriptionWidget(CompanyInfo data) {
    return Text(
      "${data.description}\n",
      style: const TextStyle(color: Colors.white, fontSize: 16),
      textAlign: TextAlign.justify,
    );
  }
}
