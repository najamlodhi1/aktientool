// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../authentication/services/auth_service.dart';
import '../payment/paypal_payment.dart';
import '../start.dart';

class SearchArea extends AppBar {
  SearchArea({Key? key}) : super(key: key);

  @override
  State<SearchArea> createState() => _SearchfieldState();
}

class _SearchfieldState extends State<SearchArea> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('AktienTool');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      title: customSearchBar,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = const ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'Aktie eingeben',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = const Text('AktienTool');
              }
            });
          },
          icon: customIcon,
        ),
        const SizedBox(
          width: 10,
        ),
        FirebaseAuth.instance.currentUser != null
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PaypalPayment(
                          onFinish: (number) async {
                            // Payment Done
                            if (kDebugMode) {
                              print('order id: '+number);
                            }
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text('Paypal'),
                ),
              )
            : const SizedBox.shrink(),
        FirebaseAuth.instance.currentUser != null
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthService().signOut().then((result) {
                      if (kDebugMode) {
                        print(result);
                      }
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const Start(),
                        ),
                      );
                    }).catchError((error) {
                      if (kDebugMode) {
                        print('Registration Error: $error');
                      }
                    });
                  },
                  child: const Text('Logout'),
                ),
              )
            : const SizedBox.shrink(),
        FirebaseAuth.instance.currentUser != null
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth.instance.currentUser!.delete();
                    await AuthService().signOut().then((result) {
                      if (kDebugMode) {
                        print(result);
                      }
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const Start(),
                        ),
                      );
                    }).catchError((error) {
                      if (kDebugMode) {
                        print('Registration Error: $error');
                      }
                    });
                  },
                  child: const Text('Delete Account'),
                ),
              )
            : const SizedBox.shrink(),
      ],
      centerTitle: true,
    );
  }
}
