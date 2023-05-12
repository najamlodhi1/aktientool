// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, must_be_immutable, empty_catches, avoid_print

import 'package:aktientool/datenschutz/agb.dart';
import 'package:aktientool/datenschutz/datenschutzerklaerung.dart';
import 'package:aktientool/settings/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../webpage/footer1.dart';
import '../services/auth_service.dart';

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

  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  Future<void> addRequests(String email, String id) {
    return requests
        .doc(email)
        .set({'request': 3, 'created': DateTime.now()})
        .then((value) => print("req data Added"))
        .catchError((error) => print("req couldn't be added."));
  }

  showSecond(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Column(
          children: [
            Text(trans.translate('Verify your email for Aktientool')),
          ],
        ),
        //content: const Icon(Icons.done, size: 50),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
              //Navigator.of(context).pop();
            },
            child: const Icon(Icons.done,
                size: 50, color: Color.fromARGB(255, 105, 240, 179)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 30),
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
                  height: 100,
                ),
              ),
              SizedBox(
                  child: Wrap(
                children: [
                  Text(
                    trans.translate("Kostenlos registrieren"),
                    style: GoogleFonts.oswald(
                      color: Colors.white,
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
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
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
                      fillColor: Colors.white,
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
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  SizedBox(
                    width: 250,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: CustomTheme.loginGradientStart,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: CustomTheme.loginGradientEnd,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: LinearGradient(
                            colors: <Color>[
                              CustomTheme.loginGradientEnd,
                              CustomTheme.loginGradientStart
                            ],
                            begin: FractionalOffset(0.2, 0.2),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: CustomTheme.loginGradientEnd,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            trans.translate("REGISTERS"),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontFamily: 'WorkSansBold'),
                          ),
                        ),
                        onPressed: () async {
                          //registerWithEmailAndPassword();

                          final message = await AuthService().registration(
                              email: _emailController.text,
                              password: _passwordController.text);
                          if (message is UserCredential) {
                            addRequests(
                                _emailController.text, message.user!.uid);
                            showSecond(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(trans.translate(
                                      'Verification Email is sent. Please verify to continue'))),
                            );
                            AuthService().signOut();
                          } else if (message is String) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(trans.translate(message))),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      trans.translate("Hast Du ein Benutzerkonto? Einloggen"),
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'WorkSansMedium'),
                    )),
              ),
              const SizedBox(height: 100),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTheme {
  const CustomTheme();

  static const Color loginGradientStart = Color.fromARGB(255, 157, 102, 251);
  static const Color loginGradientEnd = Color(0xFFf7418c);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
