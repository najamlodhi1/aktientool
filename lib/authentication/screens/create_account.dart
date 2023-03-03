// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, must_be_immutable, empty_catches, avoid_print

import 'package:aktientool/datenschutz/agb.dart';
import 'package:aktientool/datenschutz/datenschutzerklaerung.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../webpage/constants.dart';
import '../../stockscreener/home.dart';
import '../services/auth_service.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  Future<void> addRequests(String email, String id) {
    return requests
        .doc(email)
        .set({'request': 3, 'created': DateTime.now()})
        .then((value) => print("req data Added"))
        .catchError((error) => print("req couldn't be added."));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height
                  //set minimum height equal to 100% of VH
                  ),
          width: MediaQuery.of(context).size.width,
          //make width of outer wrapper to 100%
          /*
        
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 0, 255, 225),
              Color.fromARGB(255, 64, 255, 226),
              Color.fromARGB(255, 54, 244, 200),
              Color.fromARGB(255, 82, 255, 189),
            ],
          ),
        ), //show linear gradient background of page
*/
          //padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SizedBox(
                  child: Column(
                children: [
                  Text(
                    "WERDE JETZT KOSTENLOS MITGLIED",
                    style: GoogleFonts.oswald(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Email'),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Passwort',
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: SizedBox(
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text:
                                'Durch das Klicken auf MITGLIED WERDEN stimmst Du\nden ',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'AGB',
                                style: const TextStyle(color: kPrimaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const AGB(),
                                      ),
                                    );
                                  },
                              ),
                              const TextSpan(text: ' und '),
                              TextSpan(
                                text: 'Datenschutzrichtlinien',
                                style: const TextStyle(color: kPrimaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Datenschutzerklaerung(),
                                      ),
                                    );
                                  },
                              ),
                              const TextSpan(text: ' von Aktientool zu.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    //registerWithEmailAndPassword();

                    final message = await AuthService().registration(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (message is UserCredential) {
                      addRequests(_emailController.text, message.user!.uid);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Verification Email is sent. Please verify to continue')),
                      );
                      AuthService().signOut();
                    } else if (message is String) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text('MITGLIED WERDEN'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
