// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../settings/app_localizations.dart';
import '../../webpage/components/footer.dart';

import '../../webpage/constants.dart';
import '../../stockscreener/home.dart';
import '../services/auth_service.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  late AppLocalizations trans;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  Map<String, dynamic>? paymentIntent;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);

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

        child: Column(children: <Widget>[
          const Center(
            child: SizedBox(
              height: 30,
            ),
          ),
          SizedBox(
              child: Column(
            children: [
              Text(
                "${trans.translate("WELCOME BACK")} :)",
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
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: trans.translate('Password'),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ForgotPassword(),
                ),
              );
            },
            child: Text(
              trans.translate('Forgot Password?'),
              style: const TextStyle(fontSize: 17, color: kPrimaryColor),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                final message = await AuthService().login(
                    email: _emailController.text,
                    password: _passwordController.text);
                if (message is UserCredential) {
                  pref.setBool('isLogin', true);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(trans.translate(message))));
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Text(trans.translate('Login').toUpperCase(),
                  style: const TextStyle(fontSize: 15)),
            ),
          ),
          const SizedBox(height: 15),
          /*
          SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                await AuthService().signInWithGoogle().then((result) {
                  if (kDebugMode) {
                    print(result);
                  }
                  if (result != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const Home(),
                      ),
                    );
                  }
                }).catchError((error) {
                  if (kDebugMode) {
                    print('Registration Error: $error');
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: const Text('LOGIN WITH GOOGLE',
                  style: TextStyle(fontSize: 15)),
            ),
          ),*/
          const SizedBox(
            height: 30.0,
          ),
          Footer()
        ]),
      )),
    );
  }
}
