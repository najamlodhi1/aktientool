// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:aktientool/main.dart';
import 'package:aktientool/webpage/constants.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/auth_status.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ZURÜCKSETZEN WAR ERFOLGREICH'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bitte prüfe deine JUNK - Postfach'),
                  Text('Dein Passwort wurde erfolgreich zurückgesetzt.'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('VERSTANDEN'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 30),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Center(
              child: SizedBox(
                height: 30,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white,
                    hintText: '1. Email eingeben'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  final status = await AuthService()
                      .resetPassword(email: _emailController.text.trim());
                  if (status == AuthStatus.successful) {
                    _showMyDialog();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                ),
                child: const Text('2. PASSWORT ZURÜCKSETZEN',
                    style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
