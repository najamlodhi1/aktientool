// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';
import 'package:aktientool/filter/test.dart';
import 'package:aktientool/models/company.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/responsive.dart';
import 'feinfilter.dart';
import 'marketcap.dart';

class ShowCompany extends StatefulWidget {
  ShowCompany({
    Key? key,
    this.marketCap,
    this.countries,
    this.industries,
  }) : super(key: key);
  int? marketCap;
  List<dynamic>? countries;
  List<dynamic>? industries;

  @override
  State<ShowCompany> createState() => _ShowCompanyState();
}

class _ShowCompanyState extends State<ShowCompany> {
  final ScrollController _scrollController = ScrollController();
  List<CompanyModel> companies = [];
  bool isLoading = true;
  int offset = 0;

  loadOffset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      offset = (prefs.getInt('offset') ?? 0);
    });
  }

  incrementOffset() async {}

  void _scrollListener() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;
        if (isLoading) {
          setState(() {
            offset += 50;
            prefs.setInt('offset', offset);
            getCompanyList(offset);
          });
        }
      });
    }
  }

  Future<List<CompanyModel>> getCompanyList(int? offset) async {
    final response = await http.get(
      Uri.parse(
        'https://l2uc5cepjxf923s-db80zsd.adb.eu-frankfurt-1.oraclecloudapps.com/ords/at/comp/companies?offset=$offset',
      ),
    );
    final shortenResponse = response.body.substring(
      response.body.indexOf('['),
      response.body.indexOf(']') + 1,
    );

    final List resultBody = jsonDecode(shortenResponse);
    companies.addAll(resultBody.map((c) => CompanyModel.fromJson(c)));

    List<String> countryNames = [];
    List<String> industryNames = [];

    for (dynamic country
        in widget.countries!.where((e) => e['isSelected'] == true)) {
      countryNames.add(country['name']);
    }

    for (dynamic industry
        in widget.industries!.where((e) => e['isSelected'] == true)) {
      industryNames.add(industry['name']);
    }

    if (countryNames.isEmpty && industryNames.isEmpty) {
      return companies.where((c) => c.marketcap! >= widget.marketCap!).toList();
    } else if (countryNames.isEmpty && industryNames.isNotEmpty) {
      return companies
          .where((c) => c.marketcap! >= widget.marketCap!)
          .where((c) => industryNames.contains(c.industry))
          .toList();
    } else if (countryNames.isNotEmpty && industryNames.isEmpty) {
      return companies
          .where((c) => c.marketcap! >= widget.marketCap!)
          .where((c) => countryNames.contains(c.country))
          .toList();
    } else if (countryNames.isNotEmpty && industryNames.isNotEmpty) {
      return companies
          .where((c) => c.marketcap! >= widget.marketCap!)
          .where((c) => countryNames.contains(c.country))
          .where((c) => industryNames.contains(c.industry))
          .toList();
    } else {
      return companies.where((c) => c.marketcap! >= widget.marketCap!).toList();
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    loadOffset();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: FutureBuilder(
        future: getCompanyList(offset),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Wrap(
              children: [
                Marketcap(),
                Filter2(),
                Feinfilter(),
                GridView.builder(
                  primary: true,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isDesktop(context) ? 6 : 2,
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
      ),
    );
  }
}
