// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../charts/allCharts.dart';
import '../../settings/app_localizations.dart';
import '../../webpage/footer1.dart';
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
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        width: MediaQuery.of(context).size.width,
        child: Column(children: <Widget>[
          // login section starts here
          LayoutBuilder(builder: (_, c) {
            var w = c.maxWidth;
            var firstChildWidget = w;
            var secondChildWidget = w;
            var showImage = false;
            if (w > 800) {
              firstChildWidget = w * 0.6;
              secondChildWidget = w * 0.31;
              showImage = true;
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              width: w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    width: firstChildWidget,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            child: Column(
                          children: [
                            Text(
                              "${trans.translate("WELCOME BACK")} :)",
                              style: GoogleFonts.oswald(
                                color: const Color.fromARGB(255, 255, 255, 255),
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

                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            SizedBox(
                              width: 250,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
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
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 42.0),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: 'WorkSansBold'),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final pref =
                                        await SharedPreferences.getInstance();
                                    final message = await AuthService().login(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                    if (message is UserCredential) {
                                      pref.setBool('isLogin', true);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllCharts()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  trans.translate(message))));
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'WorkSansMedium'),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: <Color>[
                                        Colors.white10,
                                        Colors.white,
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 1.0),
                                      stops: <double>[0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Text(
                                  'Or',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'WorkSansMedium'),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: <Color>[
                                        Colors.white,
                                        Colors.white10,
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 1.0),
                                      stops: <double>[0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: 100.0,
                                height: 1.0,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 10.0),
                              child: GestureDetector(
                                onTap: () => null,
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: Color(0xFF0084ff),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: GestureDetector(
                                onTap: () => null,
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.google,
                                    color: Color(0xFF0084ff),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: showImage,
                    child: Container(
                        height:
                            MediaQuery.of(context).size.height - kToolbarHeight,
                        alignment: Alignment.topCenter,
                        width: secondChildWidget,
                        child: Image.asset(
                          'assets/images/login.gif',
                          height: MediaQuery.of(context).size.height -
                              kToolbarHeight -
                              kToolbarHeight,
                          fit: BoxFit.cover,
                        )),
                  )
                ],
              ),
            );
          }),
          // login section ends here
          FooterWidget(),
        ]),
      )),
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
