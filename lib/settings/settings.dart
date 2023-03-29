import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../authentication/services/auth_service.dart';
import '../main.dart';
import 'app_localizations.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);

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
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: PopupMenuButton(
                        padding: const EdgeInsets.all(17),
                        onSelected: (value) {
                          MyApp.of(context)!.setLocale(value);
                          setState(() {});
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: 'en',
                            child: Text('English'),
                          ),
                          PopupMenuItem(
                            value: 'de',
                            child: Text('Deutsch'),
                          )
                        ],
                        child: Row(
                          children: [
                            Text(
                                selectedLocale.languageCode == 'en'
                                    ? "English"
                                    : "Deutsch",
                                style: const TextStyle(color: Colors.white)),
                            const SizedBox(width: 7),
                            const Icon(Icons.arrow_drop_down_sharp,
                                color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      title: Text(
                        trans.translate('Logout'),
                        style: const TextStyle(color: Colors.white),
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
                      title: Text(
                        trans.translate('Delete Account'),
                        style: const TextStyle(color: Colors.white),
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
