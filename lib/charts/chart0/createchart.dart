import 'package:aktientool/charts/chart0/data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../settings/app_localizations.dart';

const primaryColor = Color(0xff5B2D90);
const secondaryColor = Color(0xff442881);
//String currencNow = "USD";

ValueNotifier<String> currencyNotifier = ValueNotifier('');

class CreateChart0 extends StatefulWidget {
  const CreateChart0(this.data, {super.key});
  final dynamic data;
  @override
  State<CreateChart0> createState() => CreateChart0State();
}

class CreateChart0State extends State<CreateChart0> {
  late AppLocalizations trans;
  double? apppadding = 20;
  late Future<CompanyInfo> getFuture;

  @override
  void initState() {
    getFuture = RemoteService().getData(data: widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return FutureBuilder<CompanyInfo>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Future.delayed(Duration(seconds: 1)).then((value) {
              currencyNotifier.value = snapshot.data!.currency;
              currencyNotifier.notifyListeners();
            });
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    trans.translate('disclaimer'),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
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
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 35 / 13,
                            clipBehavior: Clip.antiAlias,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            shrinkWrap: true,
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 800 ? 3 : 2,
                            children: [
                              // _buildGridViewItemName(snapshot.data!.isin),
                              _buildGridViewItem(snapshot.data!.companyName,
                                  "Isin:  ${snapshot.data!.isin} "),
                              _buildGridViewItem(trans.translate("Price"),
                                  "${snapshot.data!.price} ${snapshot.data!.currency}  ${snapshot.data!.changes} %"),
                              _buildGridViewItemImage(
                                  snapshot.data!.image.toString()),
                              _buildGridViewItem("CEO", snapshot.data!.ceo),
                              _buildGridViewItem(trans.translate("Exchange"),
                                  snapshot.data!.exchangeShortName),
                              _buildGridViewItem(trans.translate("Sektor"),
                                  "${snapshot.data!.sector} / ${snapshot.data!.industry}"),
                              _buildGridViewItem(trans.translate("Marketcap"),
                                  "${snapshot.data!.mktCap}${snapshot.data!.currency}"),
                              _buildGridViewItem(trans.translate("Mitarbeiter"),
                                  snapshot.data!.fullTimeEmployees),
                              _buildGridViewItem(
                                  trans.translate("Dividendendenrendite"),
                                  snapshot.data!.lastDiv),
                              _buildGridViewItem(
                                  trans.translate("Beta"), snapshot.data!.beta),
                              _buildGridViewItem(trans.translate("Börsengang"),
                                  snapshot.data!.ipoDate),
                              _buildGridViewItem(trans.translate("Sitz"),
                                  "${snapshot.data!.city} / ${snapshot.data!.state}"),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget _buildGridViewItemImage(String image) {
    return Container(
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Image.network(image, width: 700));
  }

  Widget _buildGridViewItemName(String title) {
    return LayoutBuilder(builder: (_, c) {
      var fontSize = 16.0;
      if (c.maxWidth <= 480) {
        fontSize = 16.0;
      } else if (c.maxWidth > 480 && c.maxWidth <= 960) {
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
      var fontSize = 15.0;
      if (c.maxWidth <= 480) {
        fontSize = 15.0;
      } else if (c.maxWidth > 480 && c.maxWidth <= 960) {
        fontSize = 25.0;
      } else {
        fontSize = 50.0;
      }
      return InkWell(
        onTap: title == 'CEO'
            ? () {
                launchUrl(Uri(
                    scheme: 'https',
                    host: 'google.com',
                    path: 'search',
                    queryParameters: {'q': value}));
              }
            : null,
        child: Container(
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
        ),
      );
    });
  }

  Widget discriptionWidget(CompanyInfo data) {
    return Column(
      children: [
        Text("${data.description}\n",
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.left),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // foreground
              ),
              onPressed: () {
                launchUrl(Uri.parse(data.website));
              },
              child: Text(
                data.website.toString().replaceRange(0, 8, ""),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )),
        ),
      ],
    );
  }
}
