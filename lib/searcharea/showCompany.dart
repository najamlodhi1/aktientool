// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';
import 'package:aktientool/models/company.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
final companyStateFuture = FutureProvider(
  (ref) async {
    var collection = FirebaseFirestore.instance.collection('company');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      return jsonDecode(data['name']);
    }
  },
);
 */

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

  Future<List<CompanyModel>> fetchCompanies() async {
    final response = await http.get(
      Uri.parse(
        'https://l2uc5cepjxf923s-db80zsd.adb.eu-frankfurt-1.oraclecloudapps.com/ords/at/comp/companies?offset=50',
      ),
    );

    final shortenResponse = response.body.substring(
      response.body.indexOf('['),
      response.body.indexOf(']') + 1,
    );

    if (response.statusCode == 200) {
      final List extractedData = json.decode(shortenResponse);
      return extractedData
          .map(
            (company) => CompanyModel.fromJson(company),
          )
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CompanyModel>>(
      future: fetchCompanies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Wrap(
            children: snapshot.data!
                .where((element) => element.marketcap! >= widget.marketCap!)
                .map((e) {
              return Wrap(
                children: [
                  SizedBox(
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
                            e.companyname!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 69, 69, 69),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            e.exchangeshortname!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 69, 69, 69),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            e.sector!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 69, 69, 69),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            e.industry!,
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
                            e.marketcap.toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 69, 69, 69),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${e.price} Dollar",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

/*
class ShowCompany extends ConsumerWidget {
  const ShowCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int marketcap = ref.watch(sp_marketcap);

    return Wrap(
      children: companies
          .map(
            (e) => SizedBox(
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
                      e.companyname!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      e.exchangeshortname!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      e.sector!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      e.industry!,
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
                      e.marketcap.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${e.price} Dollar",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );

    /*
    return FutureBuilder<CompanyModel>(
      future: AppServices().fetchCompanies2(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Wrap(
            children: [
              SizedBox(
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
                        snapshot.data!.companyname!,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data!.exchangeshortname!,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        snapshot.data!.sector!,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        snapshot.data!.industry!,
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
                        snapshot.data!.marketcap.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${snapshot.data!.price} Dollar",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                      /*
                        ButtonTheme(
                          child: ButtonBar(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  SizedBox.fromSize(
                                    size: const Size.fromRadius(14),
                                    child: Image.asset(
                                      'assets/images/0.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        */
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(
            '${snapshot.error}',
            style: const TextStyle(color: Colors.red),
          );
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },

      //stream: FirebaseFirestore.instance.collection("company").where('marketCap', isGreaterThanOrEqualTo: marketcap).snapshots(),
      /*
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (kDebugMode) {
          print(snapshot.data!.docs.length);
        }

        return Wrap(
          children: snapshot.data!.docs
              .where((element) => element.get("country") == "US")
              .map((document) {
            return Wrap(
              children: [
                SizedBox(
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
                          document['companyName'],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 69, 69, 69),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          document['exchangeShortName'],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 69, 69, 69),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          document['sector'],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 69, 69, 69),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          document['industry'],
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
                          document['marketCap'].toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 69, 69, 69),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${document['price']} Dollar",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                        /*
                        ButtonTheme(
                          child: ButtonBar(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  SizedBox.fromSize(
                                    size: const Size.fromRadius(14),
                                    child: Image.asset(
                                      'assets/images/0.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ), 
                        */
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
       */
    );
     */
  }
}
 */
