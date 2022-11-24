// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'marketcap.dart';

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

class ShowCompany extends ConsumerWidget {
  const ShowCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int marketcap = ref.watch(sp_marketcap);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("company")
          .where('marketCap', isGreaterThanOrEqualTo: marketcap)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Wrap(
          children: snapshot.data!.docs
              .where((element) => element.get("country") == "US")
              .map((document) {
            return Wrap(
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
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
    );
  }
}
