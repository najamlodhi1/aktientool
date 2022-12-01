// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';
import 'package:aktientool/filter/test.dart';
import 'package:aktientool/models/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'country.dart';
import 'feinfilter.dart';
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

    return FutureBuilder(
      future: getCompanyList(offset, ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            controller: _controller,
            child: Wrap(
              children: [
                Marketcap(),
                Filter2(),
                Feinfilter(),
                GridView.builder(
                  primary: true,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 180,
                      height: 200,
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: const Color.fromARGB(255, 54, 244, 193),
                        child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              snapshot.data![index].symbol!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 69, 69, 69),
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              snapshot.data![index].companyname!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 69, 69, 69),
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data![index].exchangeshortname!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 69, 69, 69),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              snapshot.data![index].sector!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 69, 69, 69),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              snapshot.data![index].industry!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 69, 69, 69),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Marketcap:",
                              style: TextStyle(
                                color: Color.fromARGB(255, 69, 69, 69),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              snapshot.data![index].marketcap.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 69, 69, 69),
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "${snapshot.data![index].price} Dollar",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
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
