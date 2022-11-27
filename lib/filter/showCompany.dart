// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';
import 'dart:math';
import 'package:aktientool/models/company.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemFetcher {
  final _itemsPerPage = 10;
  int _currentPage = 0;

  Future<List<CompanyModel>> fetch() async {
    final list = <CompanyModel>[];
    final response = await http.get(
      Uri.parse(
        'https://l2uc5cepjxf923s-db80zsd.adb.eu-frankfurt-1.oraclecloudapps.com/ords/at/comp/companies',
      ),
    );
    final shortenResponse = response.body.substring(
      response.body.indexOf('['),
      response.body.indexOf(']') + 1,
    );

    final List resultBody = jsonDecode(shortenResponse);
    final count = resultBody.length;

    final n = min(_itemsPerPage, count - _currentPage * _itemsPerPage);

    await Future.delayed(const Duration(seconds: 1), () {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          //print(resultBody.length);
        }
        for (int i = 0; i < n; i++) {
          list.add(CompanyModel.fromJson(resultBody[i]));
        }
      }
    });
    _currentPage++;
    return list;
  }
}

class ShowCompany extends StatefulWidget {
  ShowCompany({
    Key? key,
    this.marketCap,
  }) : super(key: key);
  int? marketCap;

  @override
  State<ShowCompany> createState() => _ShowCompanyState();
}

class _ShowCompanyState extends State<ShowCompany> {
  List<CompanyModel> companies = [];
  bool _isLoading = true;
  bool _hasMore = true;
  final _itemFetcher = ItemFetcher();

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMore();
  }

  void _loadMore() {
    _isLoading = true;
    _itemFetcher.fetch().then((List<CompanyModel> fetchedList) {
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          companies.addAll(fetchedList);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      shrinkWrap: true,
      // Need to display a loading tile if more items are coming
      itemCount: _hasMore
          ? companies
                  .where((c) => c.marketcap! >= widget.marketCap!)
                  .where((c) => c.country == 'US')
                  .toList()
                  .length +
              1
          : companies
              .where((c) => c.marketcap! >= widget.marketCap!)
              .where((c) => c.country == 'US')
              .toList()
              .length,
      itemBuilder: (BuildContext context, int index) {
        if (index >= companies.length) {
          if (!_isLoading) {
            _loadMore();
          }
          return const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }
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
                  companies[index].companyname!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 69, 69, 69),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  companies[index].exchangeshortname!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 69, 69, 69),
                    fontSize: 12,
                  ),
                ),
                Text(
                  companies[index].sector!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 69, 69, 69),
                    fontSize: 12,
                  ),
                ),
                Text(
                  companies[index].industry!,
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
                  companies[index].marketcap.toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 69, 69, 69),
                    fontSize: 20,
                  ),
                ),
                Text(
                  "${companies[index].price} Dollar",
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
    );
  }
}
