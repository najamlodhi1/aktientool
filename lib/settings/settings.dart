import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../authentication/services/auth_service.dart';
import '../main.dart';
import 'app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    Color pickerColor = Colors.green;
    Color currentColor = Colors.green;

    // ValueChanged<Color> callback
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar:
          AppBar(title: const Text('Settings'), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                selectedLocale.languageCode == 'en' ? "English" : "Deutsch",
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                MyApp.of(context)!.setLocale(
                    selectedLocale.languageCode == 'en' ? 'de' : 'en');
                setState(() {});
              },
            ),
            ListTile(
              title: const Text(
                "Text Color",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Pick a Text Color!'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Save'),
                            onPressed: () {
                              setState(() => currentColor = pickerColor);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            ListTile(
              title: const Text(
                "Background Color",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Pick a Background Color!'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Save'),
                            onPressed: () {
                              setState(() => currentColor = pickerColor);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            if (FirebaseAuth.instance.currentUser != null) ...[
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
            ]
          ],
        ),
      ),
    );
  }
}
