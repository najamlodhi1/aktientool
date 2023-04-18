// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, must_be_immutable, empty_catches, avoid_print

import 'package:aktientool/datenschutz/agb.dart';
import 'package:aktientool/datenschutz/datenschutzerklaerung.dart';
import 'package:aktientool/settings/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../webpage/components/footer.dart';
import '../services/auth_service.dart';
import 'login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  late AppLocalizations trans;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Color firstdone = Colors.black;
  Color seconddone = Colors.black;
  Color thirddone = Colors.black;

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
    trans = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(trans.translate("REGISTERS")),
        backgroundColor: Colors.black,
        leading: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
                  child: Wrap(
                children: [
                  Text(
                    trans.translate("1. Type Email & Password"),
                    style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  Icon(Icons.done, color: firstdone, size: 40),
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
                      filled: true, //<-- SEE HERE
                      fillColor: Color.fromARGB(255, 150, 111, 255),
                      hintText: 'Email'),
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
                      filled: true, //<-- SEE HERE
                      fillColor: Color.fromARGB(255, 150, 111, 255),
                      hintText: 'Password'),
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
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: trans.translate('create1'),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                text: trans.translate('create2'),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const AGB(),
                                      ),
                                    );
                                  },
                              ),
                              TextSpan(text: trans.translate('create3')),
                              TextSpan(
                                text: trans.translate('create4'),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
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
                              TextSpan(text: trans.translate('create5')),
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
                width: 250,
                height: 40,
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            //registerWithEmailAndPassword();
                            setState(() {
                              firstdone = Colors.greenAccent;
                            });
                            final message = await AuthService().registration(
                                email: _emailController.text,
                                password: _passwordController.text);
                            if (message is UserCredential) {
                              addRequests(
                                  _emailController.text, message.user!.uid);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(trans.translate(
                                        'Verification Email is sent. Please verify to continue'))),
                              );
                              setState(() {
                                seconddone = Colors.greenAccent;
                              });

                              AuthService().signOut();
                            } else if (message is String) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(trans.translate(message))),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 114, 54, 244)),
                          ),
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              trans.translate('2. Become a Member'),
                              style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.done, color: seconddone, size: 40),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Wrap(
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          thirddone = Colors.greenAccent;
                        },
                        child: Text(
                          trans.translate("3. Check your Junk Mail"),
                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.done, color: thirddone, size: 40),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    trans.translate("4. Go to Login"),
                    style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}
