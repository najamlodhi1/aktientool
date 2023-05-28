import 'dart:convert';
import 'package:aktientool/authentication/services/request_service.dart';
import 'package:aktientool/charts/allCharts.dart';
import 'package:aktientool/charts/chart3/BarChartBalanceScreen.dart';
import 'package:aktientool/models/company.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/responsive.dart';
import '../filter/country.dart';
import '../filter/industry.dart';
import '../filter/searcharea.dart';

String selectedcompanyname = "";
String selectedcompanysymbol = "";

class ShowCompanies extends ConsumerWidget {
  ShowCompanies({super.key});
  final ScrollController _controller = ScrollController();

  List<CompanyModel> companies = [];
  bool isLoading = true;

  var spOffset = StateProvider((ref) {
    return 0;
  });

  Future<List<CompanyModel>> getCompanyList(int? offset, ref) async {
    String industryUrl = ref.watch(sp_industry_url).toString();
    String sectorUrl = ref.watch(sp_sector_url).toString();
    String countryUrl = ref.watch(sp_country_url).toString();
    String search = ref.watch(sp_search);

    industryUrl = ref.watch(sp_industry_url).toString();

    if (industryUrl.contains(":")) {
      industryUrl = industryUrl.substring(1);
    }

    if (countryUrl.contains(":")) {
      countryUrl = countryUrl.substring(1);
    }

    String url =
        "https://l2uc5cepjxf923s-db80zsd.adb.eu-frankfurt-1.oraclecloudapps.com/ords/at/comp/v1/list?p_cname=$search&offset=$offset&p_cou=$countryUrl&p_ind=$industryUrl&p_sec=$sectorUrl&p_mkmin=&p_mkmax=&p_betmin=&p_betmax=&p_epsmin=&p_epsmax=";
    var responses = await Dio().get(url);
    var x = responses;
    var y = x.toString();

    y = y.substring(y.indexOf('['), y.indexOf(']') + 1).toString();
    var encoded = utf8.encode(y);
    var decoded = utf8.decode(encoded);
    final List resultBody = jsonDecode(decoded);

    if (resultBody.isNotEmpty) {
      companies.addAll(resultBody.map((c) => CompanyModel.fromJson(c)));
    }

    return companies;
  }

  checkDevice(context) {
    if (Responsive.isDesktop(context) == true) {
      return 5;
    }
    if (Responsive.isTablet(context) == true) {
      return 3;
    }
    if (Responsive.isMobile(context) == true) {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var offset = ref.watch(spOffset);
    scrollListener() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref.watch(spOffset.state).state += 50;
        offset += 50;
      }
      // if (_controller.offset <= _controller.position.minScrollExtent &&
      //     !_controller.position.outOfRange) {
      //   print("reach the top");
      // }
    }

    if (ref.watch(spOffset.state).state ==
            ref.watch(spOffset.state).state + 50 ||
        ref.watch(spOffset.state).state == 0) {
      _controller.addListener(scrollListener);
    }

    Top(context, snapshot, index) {
      return Row(children: [
        Expanded(
            flex: 2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data![index].exchangeshortname!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 15),
                          ))),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data![index].symbol!,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 15)))),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              child: SizedBox.fromSize(
                                  size: const Size.fromRadius(10),
                                  child: SvgPicture.asset(
                                      "assets/images/${(snapshot.data![index].country).toLowerCase()}.svg",
                                      fit: BoxFit.cover)))))
                ]))
      ]);
    }

    return FutureBuilder(
      future: getCompanyList(offset, ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: _controller,
              child: Wrap(children: [
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: checkDevice(context),
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            if (requestsLeft > 0) {
                              selectedcompanyname =
                                  snapshot.data![index].companyname!;
                              selectedcompanysymbol =
                                  snapshot.data![index].symbol!;
                              RequestService().updateRequests();
                              AllCharts.of(context)!.updateIndex();
                            } else {
                              upgradepopup(context);
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.all(2.0),
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 87, 87, 87))),
                              child: Column(children: <Widget>[
                                Top(context, snapshot, index),
                                Center(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: false,
                                    textAlign: TextAlign.center,
                                    snapshot.data![index].companyname!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 251, 251, 251),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Center(
                                  child: Text(
                                    "MC: \$${numberToKFormat(snapshot.data![index].mktcap!)}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 255, 145),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Center(
                                    child: Text(snapshot.data![index].sector!,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 148, 148, 148),
                                            fontSize: 12))),
                                Center(
                                    child: Text(snapshot.data![index].industry!,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 148, 148, 148),
                                            fontSize: 12)))
                              ])));
                    })
              ]));
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('There was an error, Please try again'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
