import 'package:aktientool/authentication/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'country.dart';
import 'industry.dart';

// ignore: must_be_immutable
class Filter2 extends ConsumerWidget {
  List<Map> generatedIndustryFromList = [];

  Filter2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        if (FirebaseAuth.instance.currentUser != null) {
          // Navigator.push(
          //context,
          //MaterialPageRoute(
          //  builder: (context) => IndustrySelect(),
          //),
          //);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
      },
      child: SizedBox(
        width: 180,
        height: 120,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CountrySelect()),
              );
            },
            child: Column(children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 11, 196, 144)),
                  child: const Center(
                      child: Text("Country",
                          style: TextStyle(
                            fontSize: 20,
                          ))),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IndustrySelect()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Center(
                        child: Text("Industry",
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
