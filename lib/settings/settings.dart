import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authentication/services/auth_service.dart';
import '../main.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar:
          AppBar(title: const Text('Settings'), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: const Color.fromARGB(255, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        AuthService().signOut().then((result) {
                          if (kDebugMode) {
                            print(result);
                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => const MyApp(),
                            ),
                          );
                        }).catchError((error) {
                          if (kDebugMode) {
                            print('Registration Error: $error');
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: const Text(
                        'Delete Account',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        FirebaseAuth.instance.currentUser!.delete();
                        AuthService().signOut().then((result) {
                          if (kDebugMode) {
                            print(result);
                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => const MyApp(),
                            ),
                          );
                        }).catchError((error) {
                          if (kDebugMode) {
                            print('Registration Error: $error');
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
