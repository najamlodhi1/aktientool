// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';
import 'package:aktientool/models/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../constants/responsive.dart';
import 'country.dart';
import 'industry.dart';
import 'marketcap.dart';

class ShowCompanies extends ConsumerWidget {
  final ScrollController _controller = ScrollController();
  List<CompanyModel> companies = [];
  bool isLoading = true;

  ShowCompanies({super.key});

  var sp_offset = StateProvider((ref) {
    return 0;
  });

  Future<List<CompanyModel>> getCompanyList(int? offset, ref) async {
    String industryUrl = ref.watch(sp_industry_url).toString();
    String countryUrl = ref.watch(sp_country_url).toString();
    String marketcapUrl = ref.watch(sp_marketcap).toString();

    industryUrl = ref.watch(sp_industry_url).toString();
    if (industryUrl.contains(":")) {
      industryUrl = industryUrl.substring(1);
    }

    if (countryUrl.contains(":")) {
      countryUrl = countryUrl.substring(1);
    }

    String url =
        "https://l2uc5cepjxf923s-db80zsd.adb.eu-frankfurt-1.oraclecloudapps.com/ords/at/comp/companies?&p_country=$countryUrl&p_industry=$industryUrl&p_marketcap=$marketcapUrl&offset=$offset";
    print(url);

    final response = await http.get(
      Uri.parse(url),
    );
    final shortenResponse = response.body.substring(
      response.body.indexOf('['),
      response.body.indexOf(']') + 1,
    );

    final List resultBody = jsonDecode(shortenResponse);
    companies.addAll(resultBody.map((c) => CompanyModel.fromJson(c)));
    return companies;
  }

  checkDevice(context) {
    if (Responsive.isDesktop(context) == true) {
      return 7;
    }
    if (Responsive.isTablet(context) == true) {
      return 4;
    }
    if (Responsive.isMobile(context) == true) {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollListener() async {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        print("reach the bottom");
        ref.watch(sp_offset.state).state += 50;
      }
      if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        print("reach the top");
        ref.watch(sp_offset.state).state = 0;
      }
    }

    var offset = ref.watch(sp_offset);
    _controller.addListener(scrollListener);

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
                    child: Text(
                      snapshot.data![index].exchangeshortname!,
                      style: const TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Buttom(context, snapshot, index) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 0, 0, 0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "MC: \$${((snapshot.data![index].marketcap) / 1000000000).toStringAsFixed(0)} B",
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(15),
                      child: Image.asset(
                        "assets/images/${index + 1}.png",
                        fit: BoxFit.cover,
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

    return FutureBuilder(
      future: getCompanyList(offset, ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            controller: _controller,
            children: [
              Wrap(
                children: [
                  //Marketcap(),
                  //Filter2(),
                  //Feinfilter(),
                  GridView.builder(
                    primary: true,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: checkDevice(context),
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: SizedBox(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: const Color.fromARGB(255, 0, 0, 0),
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Top(context, snapshot, index),
                                Center(
                                  child: Text(
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
                                    "${snapshot.data![index].price} \$",
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
                                Buttom(context, snapshot, index),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
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
