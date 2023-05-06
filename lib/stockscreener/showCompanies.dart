// ignore_for_file: file_names, must_be_immutable, avoid_print, duplicate_ignore
import 'dart:convert';
import 'package:aktientool/charts/allCharts.dart';
import 'package:aktientool/models/company.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../authentication/services/request_service.dart';
import '../constants/responsive.dart';
import '../filter/country.dart';
import '../filter/industry.dart';
import '../filter/marketcap.dart';
import '../filter/searcharea.dart';

class ShowCompanies extends ConsumerWidget {
  final ScrollController _controller = ScrollController();
  static String companyname = "";
  static String companysymbol = "";

  List<CompanyModel> companies = [];
  bool isLoading = true;

  ShowCompanies({super.key});

  // ignore: non_constant_identifier_names
  var sp_offset = StateProvider((ref) {
    return 0;
  });

  Future<List<CompanyModel>> getCompanyList(int? offset, ref) async {
    String industryUrl = ref.watch(sp_industry_url).toString();
    String sectorUrl = ref.watch(sp_sector_url).toString();
    String countryUrl = ref.watch(sp_country_url).toString();
    String marketcapStartUrl = ref.watch(sp_marketcap_start).toString();
    String marketcapEndUrl = ref.watch(sp_marketcap_end).toString();
    String search = ref.watch(sp_search);

    String modifiedMarketcapStartUrl =
        (int.parse(marketcapStartUrl) * 1000000000).toString();
    String modifiedMarketcapEndUrl =
        (int.parse(marketcapEndUrl) * 1000000000).toString();

    //String cname = "";
    industryUrl = ref.watch(sp_industry_url).toString();
    //print(industryUrl);

    if (industryUrl.contains(":")) {
      industryUrl = industryUrl.substring(1);
    }

    if (countryUrl.contains(":")) {
      countryUrl = countryUrl.substring(1);
    }
    print("---------------");
    print(modifiedMarketcapStartUrl);
    print(modifiedMarketcapEndUrl);

    String url =
        "https://l2uc5cepjxf923s-db80zsd.adb.eu-frankfurt-1.oraclecloudapps.com/ords/at/comp/v1/list?p_cname=$search&offset=$offset&p_cou=$countryUrl&p_ind=$industryUrl&p_sec=$sectorUrl&p_mkmin=100&p_mkmax=100000000000000&p_betmin=0&p_betmax=0.2&p_epsmin=-10&p_epsmax=10";
    //String url =
    //  "https://l2uc5cepjxf923s-db80zsd.adb.eu-frankfurt-1.oraclecloudapps.com/ords/at/comp/companies?&p_country=$countryUrl&p_industry=$industryUrl&p_marketcap=$modifiedMarketcapStartUrl&p_marketcapEnd=$modifiedMarketcapEndUrl&p_cname=$search&offset=$offset";
    print(url);
    var responses = await Dio().get(url);
    var x = responses;
    var y = x.toString();
    //print(y);
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
    var offset = ref.watch(sp_offset);
    scrollListener() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        // ignore: deprecated_member_use
        ref.watch(sp_offset.state).state += 50;
        offset += 50;
        // ignore: avoid_print
        print("offset: $offset");
        // ignore: avoid_print
        print("rofset: ${ref.watch(sp_offset)}");
      }
      if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        // ignore: avoid_print
        print("reach the top");
        // ignore: deprecated_member_use
        //ref.watch(sp_offset.state).state = 0;
        //offset = 50;
      }
    }

    // ignore: deprecated_member_use
    if (ref.watch(sp_offset.state).state ==
            // ignore: deprecated_member_use
            ref.watch(sp_offset.state).state + 50 ||
        // ignore: deprecated_member_use
        ref.watch(sp_offset.state).state == 0) {
      _controller.addListener(scrollListener);
    }

    // ignore: non_constant_identifier_names
    Top(context, snapshot, index) {
      return Row(
        children: [
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
                      style: const TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data![index].symbol!,
                      style: const TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ),
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
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // ignore: non_constant_identifier_names

    return FutureBuilder(
      future: getCompanyList(offset, ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            child: Wrap(
              children: [
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
                          companyname = snapshot.data![index].companyname!;
                          companysymbol = snapshot.data![index].symbol!;
                          RequestService().updateRequests();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllCharts(),
                            ),
                          ).then((value) {
                            if (requestsLeft == 0) {
                              upgradepopup(context);
                            }
                          });
                        } else {
                          upgradepopup(context);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Column(
                          children: <Widget>[
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
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "MC: \$${((snapshot.data![index].mktCap)! / 1000000000).toStringAsFixed(0)} B",
                                //"${snapshot.data![index].price} \$",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 255, 145),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                snapshot.data![index].sector!,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 148, 148, 148),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                snapshot.data![index].industry!,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 148, 148, 148),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
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
