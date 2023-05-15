// bring greater transparency to financial markets, enabling the investment community to make better decisions
// ignore_for_file: avoid_web_libraries_in_flutter, constant_identifier_names
//
import 'dart:html' as html;
import 'package:aktientool/authentication/services/request_service.dart';
import 'package:aktientool/webpage/landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'charts/allCharts.dart';
import 'constants/responsive.dart';
import 'datenschutz/datenschutzerklaerung.dart';

import 'firebase_options.dart';
import 'settings/app_localizations.dart';

// flutter run -d chrome --web-renderer html
main() async {
  final loader = html.document.getElementsByClassName('loader');
  if (loader.isNotEmpty) {
    loader.first.remove();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? q = Uri.base.queryParameters["q"];
  runApp(ProviderScope(child: MyApp(clicks: q)));
}

const List<Locale> SUPPORTED_LOCALES = [Locale('en'), Locale('de')];
Locale selectedLocale = const Locale('de');

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

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.clicks});
  final String? clicks;

  @override
  MyAppState createState() => MyAppState();
  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  void setLocale(String value) {
    setState(() {
      selectedLocale = Locale(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aktientool',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: SUPPORTED_LOCALES,
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        locale: selectedLocale,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        //
        home: HomePage(clicks: widget.clicks));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.clicks});
  final String? clicks;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AppLocalizations trans;

  bool mIsShowStripeCancelDialog = false;
  bool mIsShowStripeSuccessDialog = false;

  bool? isLoggedIn = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      checkCookiesx(context);
    });
    String currentUrl = html.window.location.href;
    if (currentUrl.contains("ret=cancel")) {
      setState(() {
        mIsShowStripeCancelDialog = true;
      });
    } else if (currentUrl.contains("ret=success")) {
      if (widget.clicks != null) {
        RequestService().addRequests(int.parse(widget.clicks!));
      }
      setState(() {
        mIsShowStripeSuccessDialog = true;
      });
    }
    isLogIn();
    super.initState();
  }

  Future<void> isLogIn() async {
    final pref = await SharedPreferences.getInstance();
    isLoggedIn = pref.getBool('isLogin');
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    var screenSize = MediaQuery.of(context).size;

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, ssFirebase) {
          User? firebaseUser = ssFirebase.data;

          if (firebaseUser != null && firebaseUser.emailVerified) {
            Future.delayed(
              const Duration(milliseconds: 1000),
              () async {
                if (mIsShowStripeCancelDialog == true) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(trans.translate('Payment Cancelled')),
                          actions: [
                            TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  mIsShowStripeCancelDialog = false;
                                  //Navigator.pop(context);
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                  mIsShowStripeCancelDialog = false;
                } else if (mIsShowStripeSuccessDialog == true) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(trans.translate('Payment Successful')),
                        actions: [
                          TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                mIsShowStripeSuccessDialog = false;
                                //Navigator.pop(context);
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    },
                  );
                  mIsShowStripeSuccessDialog = false;
                }
              },
            );
            return AllCharts();
          } else {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[];
                },
                body:  LandingPage(),
                // place for the code
              ),
            );
          }
        });
  }

  void checkCookiesx(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Verwendung von Cookies"),
          content: const Text(
            'Um unsere Webseite für Sie optimal zu gestalten und fortlaufend verbessern zu können, verwenden wir Cookies.\nDurch die weitere Nutzung der Webseite stimmen Sie der Verwendung von Cookies zu.',
          ),
          actions: <Widget>[
            Wrap(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllCharts(),
                      ),
                    );
                  },
                  child: const Text("AllCharts"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Datenschutzerklaerung()));
                  },
                  child: const Text("Datenschutzerklärung"),
                ),
              ],
            ),
            // usually buttons at the bottom of the dialog

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                //ref.read(cookieProvider.state).state = true;
                if (kDebugMode) {
                  print("Alle Cookies erlauben");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                fixedSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
