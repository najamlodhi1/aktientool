import 'package:aktientool/searcharea/marketcap.dart';
import 'package:aktientool/searcharea/searcharea.dart';
import 'package:aktientool/searcharea/showCompany.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'searcharea/country.dart';
import 'searcharea/sektor.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //getData();
    //AsyncValue<List<Photo>> photos = ref.watch(photoStateFuture);
    AsyncValue companies = ref.watch(companyStateFuture);

    // höre auf
    //var watchMarketCap = ref.watch(sp_marketcap);
    // ignore: unused_local_variable
    int marketcap = ref.watch(sp_marketcap);
    // ignore: unused_local_variable
    List<dynamic> generatedCountrieFromList =
        ref.watch(sp_generatedCountrieFromList);
    // ignore: unused_local_variable
    List<dynamic> generatedSektorFromList =
        ref.watch(sp_generatedSektorFromList);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: SearchArea(),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [
              Marketcap(),
              const Country(),
              Sektor(),
              //for (int i = 1; i <= 30; i++) const ShowCompany(),
              const ShowCompany(),
            ],
          ),

          /*
              Text(
                generatedCountrieFromList.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              Text(
                generatedSektorFromList.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              */
        ),
      ),
    );
  }

  Widget show() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('company').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: snapshot.data!.docs.map((document) {
            return Container(
              child: Center(child: Text(document['name'])),
            );
          }).toList(),
        );
      },
    );
  }

  Widget showCompa(String names) {
    return SizedBox(
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blue,
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              offset: Offset(-20, 20),
              color: Colors.red,
              blurRadius: 15,
              spreadRadius: -10,
            ),
            BoxShadow(
              offset: Offset(-20, -20),
              color: Colors.orange,
              blurRadius: 15,
              spreadRadius: -10,
            ),
            BoxShadow(
              offset: Offset(20, -20),
              color: Colors.blue,
              blurRadius: 15,
              spreadRadius: -10,
            ),
            BoxShadow(
              offset: Offset(20, 20),
              color: Colors.deepPurple,
              blurRadius: 15,
              spreadRadius: -10,
            )
          ]),
          child: Container(
            width: 180,
            height: 120,
            color: Colors.black,
            child: const Center(
                child: Text('Text',
                    style: TextStyle(color: Colors.white, fontSize: 40))),
          ),
        ),
      ),
    );
  }
}
