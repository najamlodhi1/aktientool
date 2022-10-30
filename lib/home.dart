import 'package:aktientool/searcharea/marketcap.dart';
import 'package:aktientool/searcharea/searcharea.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'searcharea/country.dart';
import 'searcharea/sektor.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  getData() async {
    var collection = FirebaseFirestore.instance.collection('company');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var name = data['name'];
      // ignore: avoid_print
      print(name);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // höre auf
    //var watchMarketCap = ref.watch(sp_marketcap);
    // ignore: unused_local_variable
    String marketcap = ref.watch(sp_marketcap);
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
              /*Text(
                marketcap.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              Text(
                generatedCountrieFromList.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              Text(
                generatedSektorFromList.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

/**

 Container(
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
                      child: Text(
                    'Text',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  )),
                ),
              ),
              Container(
                height: 200.0,
                width: 200.0,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 25.0, //extend the shadow
                      offset: Offset(
                        5.0, // Move to right 5  horizontally
                        5.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                ),
                child: const Text("Hello world"),
              ), 
 

 */
