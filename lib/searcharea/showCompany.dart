// ignore_for_file: file_names

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'marketcap.dart';

final companyStateFuture = FutureProvider((ref) async {
  var collection = FirebaseFirestore.instance.collection('company');

  var querySnapshot = await collection.get();
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> data = queryDocumentSnapshot.data();
    //var name = data['name'];
    // ignore: avoid_print
    return jsonDecode(data['name']);
  }
});

class ShowCompany extends ConsumerWidget {
  const ShowCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int marketcap = ref.watch(sp_marketcap);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("company")
          .where(
            'marketcap',
            isGreaterThanOrEqualTo: marketcap,
          )
          //.where('land', isEqualTo: 'Deutschland')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Wrap(
          children: snapshot.data!.docs.map((document) {
            return Wrap(
              children: [
                SizedBox(
                  width: 180,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: const Color.fromARGB(255, 54, 244, 193),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(document['name'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 69, 69, 69),
                                  fontSize: 20)),
                        ),
                        ButtonTheme(
                          child: ButtonBar(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  SizedBox.fromSize(
                                    size: const Size.fromRadius(24),
                                    child: Image.asset(
                                      'assets/images/52.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
      },
    );
  }
}
