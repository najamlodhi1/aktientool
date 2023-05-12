import 'package:aktientool/charts/chart0/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../settings/app_localizations.dart';
import '../chart11/performanceList.dart';

// App Theme Colors
Color primaryColor = const Color.fromARGB(255, 26, 26, 26);
Color backgroundColor = const Color.fromARGB(255, 0, 0, 0);

ValueNotifier<String> currencyNotifier = ValueNotifier('USD');

class CreateChart0 extends StatefulWidget {
  const CreateChart0(this.data, this.performanceData, {super.key});
  final dynamic data;
  final dynamic performanceData;
  @override
  State<CreateChart0> createState() => CreateChart0State();
}

class CreateChart0State extends State<CreateChart0> {
  late AppLocalizations trans;
  double? apppadding = 10;
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
            Future.delayed(const Duration(seconds: 1)).then((value) {
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: primaryColor,
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      if (constraints.maxWidth >= 890) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            instagramWidget(snapshot),
                            const SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            performanceListWidget(),
                            const SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            Expanded(
                                child:
                                    aboutCompanyWidget(snapshot, maxLines: 20)),
                          ],
                        );
                      } else if (constraints.maxWidth >= 600) {
                        return Container(
                          constraints: const BoxConstraints(
                            minHeight: 600,
                          ),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  instagramWidget(snapshot),
                                  const SizedBox(
                                    width: 10,
                                    height: 10,
                                  ),
                                  performanceListWidget(),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                                height: 10,
                              ),
                              aboutCompanyWidget(snapshot),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          constraints: const BoxConstraints(
                            minHeight: 600,
                          ),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  instagramWidget(snapshot),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  performanceListWidget(),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                                height: 10,
                              ),
                              aboutCompanyWidget(snapshot),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget aboutCompanyWidget(AsyncSnapshot<CompanyInfo> snapshot,
      {final maxLines = 100}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: primaryColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: primaryColor,
          ),
          child: WidgetWithReadMore(
              data: snapshot.data!, trans: trans, maxLines: maxLines)
          // child: discriptionWidget(snapshot.data!)
          ),
    );
  }

  Expanded performanceListWidget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: primaryColor,
        ),
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
        child: PerformanceList(widget.performanceData),
      ),
    );
  }

  Expanded instagramWidget(AsyncSnapshot<CompanyInfo> snapshot) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: primaryColor,
        ),
        padding: const EdgeInsets.all(15),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildGridViewItemImage(snapshot.data!.image.toString(),
                          width: 50),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data!.companyName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 19,
                                          color: Colors.white),
                                      textAlign: TextAlign.left),
                                  const Spacer(),
                                  Text(
                                      "${snapshot.data!.price} ${snapshot.data!.currency}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 19,
                        ),
                        InstagramWidgetListItems(
                          text:
                              "DIVR ${snapshot.data!.lastDiv}\nBETA ${snapshot.data!.beta}",
                          value: snapshot.data!.country,
                          isCountry: true,
                        ),
                        InstagramWidgetListItems(
                            text: trans.translate("Exchange"),
                            value: snapshot.data!.exchangeShortName),
                        InstagramWidgetListItems(
                            text: trans.translate("Sektor"),
                            // value: "${snapshot.data!.sector} / ${snapshot.data!.industry}"),
                            value: snapshot.data!.sector),
                        InstagramWidgetListItems(
                            text: trans.translate("Industry"),
                            value: snapshot.data!.industry),
                        InstagramWidgetListItems(
                          text: trans.translate("Marketcap"),
                          value:
                              // "${snapshot.data!.mktCap}${snapshot.data!.currency}"
                              snapshot.data!.mktCap +
                                  snapshot.data!.currency.toString(),
                        ),
                        InstagramWidgetListItems(
                            text: trans.translate("Sitz"),
                            value:
                                "${snapshot.data!.city} / ${snapshot.data!.state}"),
                        InstagramWidgetListItems(
                            text: trans.translate("Website"),
                            value: snapshot.data!.website,
                            isWebsite: true),
                        InstagramWidgetListItems(
                            text: trans.translate("CEO"),
                            // value: "${snapshot.data!.sector} / ${snapshot.data!.industry}"),
                            value: snapshot.data!.ceo),
                        InstagramWidgetListItems(
                            text: trans.translate("Börsengang"),
                            // value: "${snapshot.data!.sector} / ${snapshot.data!.industry}"),
                            value: snapshot.data!.ipoDate),
                        InstagramWidgetListItems(
                            text: trans.translate("Mitarbeiter"),
                            // value: "${snapshot.data!.sector} / ${snapshot.data!.industry}"),
                            value: snapshot.data!.fullTimeEmployees),
                        InstagramWidgetListItems(
                            text: "isin".toUpperCase(),
                            value: snapshot.data!.isin,
                            showDivider: false),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _buildGridViewItemImage(String image, {double width = 700}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(0)),
        alignment: Alignment.center,
        child: Image.network(image, width: width));
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
                      color: primaryColor, // foreground

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
}

class InstagramWidgetListItems extends StatelessWidget {
  final text, value, isWebsite, isCountry, showDivider;
  const InstagramWidgetListItems(
      {super.key,
      this.text,
      this.value,
      this.isWebsite = false,
      this.isCountry = false,
      this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: showDivider
                ? const EdgeInsets.fromLTRB(2, 6, 2, 5)
                : const EdgeInsets.fromLTRB(2, 6, 2, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text,
                    style: const TextStyle(color: Colors.white, fontSize: 15.5),
                    textAlign: TextAlign.left),
                isWebsite
                    ? GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse(value));
                        },
                        child: Text(
                          value.toString().replaceRange(0, 8, ""),
                          style: const TextStyle(
                              color: Colors.blue, fontSize: 15.5),
                          textAlign: TextAlign.left,
                        ))
                    : isCountry
                        ? Row(
                            children: [
                              Text(value,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15.5),
                                  textAlign: TextAlign.left),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: SvgPicture.asset(
                                  (kIsWeb)
                                      ? "assets/images/${value.toLowerCase()}.svg"
                                      : "images/${value.toLowerCase()}.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          )
                        : Text(value,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15.5),
                            textAlign: TextAlign.left),
              ],
            )),
        showDivider
            ? const SizedBox(
                width: double.maxFinite,
                child: Divider(
                  height: 1,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class WidgetWithReadMore extends StatefulWidget {
  final CompanyInfo data;
  final trans;
  final maxLines;
  const WidgetWithReadMore(
      {super.key,
      required this.data,
      @required this.trans,
      @required this.maxLines});

  @override
  _WidgetWithReadMoreState createState() => _WidgetWithReadMoreState();
}

class _WidgetWithReadMoreState extends State<WidgetWithReadMore> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final trans = widget.trans;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            trans.translate("AboutCompany"),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.data.description}\n",
                style: const TextStyle(
                  color: Color(0xffEAEAEB),
                  height: 1.15,
                  fontSize: 15.5,
                ),
                maxLines: _isExpanded ? 500 : widget.maxLines,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              if ((widget.data.description.trim().length) >
                  widget.maxLines * 15.5 * 1.15)
                if (widget.maxLines == 20)
                  Padding(
                    padding: _isExpanded
                        ? const EdgeInsets.only(top: 0.0, bottom: 7)
                        : const EdgeInsets.only(top: 8.0, bottom: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Text(
                              _isExpanded
                                  ? trans.translate("showLess")
                                  : trans.translate("readMore"),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
