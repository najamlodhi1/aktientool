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
            ListTile(
              title: Text(
                selectedLocale.languageCode == 'en' ? "Deutsch" : "English",
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                MyApp.of(context)!.setLocale(
                    selectedLocale.languageCode == 'en' ? 'de' : 'en');
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
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
    );
  }
}
