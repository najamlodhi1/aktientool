// ignore_for_file: avoid_web_libraries_in_flutter, constant_identifier_names

import 'dart:html' as html;
import 'package:aktientool/authentication/screens/create_account.dart';
import 'package:aktientool/authentication/services/request_service.dart';
import 'package:aktientool/stockscreener/home.dart';
import 'package:aktientool/webpage/body.dart';
import 'package:aktientool/webpage/components/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aktientool/webpage/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authentication/screens/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'charts/allCharts.dart';
import 'firebase_options.dart';
import 'settings/app_localizations.dart';
import 'webpage/start.dart';

// flutter run -d chrome --web-renderer html
main() async {
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

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.clicks});
  final String? clicks;
  @override
  MyAppState createState() => MyAppState();
  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
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

  late final tabController = TabController(length: 4, vsync: this);
  bool? isLoggedIn = false;

  @override
  void initState() {
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
            return const Home();
          } else {
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        actions: [
                          if (tabController.index != 3)
                            IconButton(
                              icon: SvgPicture.asset(
                                "assets/images/${selectedLocale.languageCode}.svg",
                                fit: BoxFit.cover,
                              ),
                              iconSize: 40,
                              /*Image.asset(
                                  'assets/images/${selectedLocale.languageCode}.svg'),
                              */
                              onPressed: () {
                                MyApp.of(context)!.setLocale(
                                    selectedLocale.languageCode == 'us'
                                        ? 'de'
                                        : 'us');
                                setState(() {});
                              },
                            )
                          /* TextButton(
                              child: Text(
                                selectedLocale.languageCode == 'en'
                                    ? "English"
                                    : "Deutsch",
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                MyApp.of(context)!.setLocale(
                                    selectedLocale.languageCode == 'en'
                                        ? 'de'
                                        : 'en');
                                setState(() {});
                              },
                            ),*/
                        ],
                        backgroundColor: Colors.black,
                        title:
                            Image.asset('assets/images/logo.png', height: 25),
                        centerTitle: true,
                        pinned: true,
                        floating: true,
                        bottom: TabBar(
                          controller: tabController,
                          isScrollable: true,
                          tabs: <Widget>[
                            const Tab(child: Text('Home')),
                            Tab(child: Text(trans.translate('Login'))),
                            Tab(child: Text(trans.translate('Register'))),
                            Tab(child: Text(trans.translate('Test'))),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              SizedBox(
                                width: 600,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      trans
                                          .translate("AKTIENTOOL SUPPORTS YOU"),
                                      style: GoogleFonts.oswald(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                    Text(
                                      trans.translate(
                                          "IN YOUR INVESTMENT DECISION"),
                                      style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w900,
                                        height: 1.3,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      trans.translate('hometext1'),
                                      style: const TextStyle(
                                        color: kCaptionColor,
                                        fontSize: 15.0,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    SizedBox(
                                      child: Wrap(
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Text(
                                                trans.translate(
                                                    "Register and test for free"),
                                                style: const TextStyle(
                                                  height: 0.5,
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Wrap(
                                      children: [
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            height: 48.0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 28.0,
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                tabController.index = 2;
                                              },
                                              child: Text(
                                                trans
                                                    .translate("Register")
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            height: 48.0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 28.0,
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                tabController.index = 1;
                                              },
                                              child: Text(
                                                trans
                                                    .translate("Login")
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              SizedBox(
                                  height: 400,
                                  child: Image.asset("assets/images/image1.png",
                                      fit: BoxFit.contain)),
                              const SizedBox(height: 0.0),

                              //CvSection(),

                              //IosAppAd(),
                              /*const SizedBox(
            height: 70.0,
          ),
          WebsiteAd(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            child: PortfolioStats(),
          ),
          const SizedBox(
            height: 50.0,
          ),
          EducationSection(),
          const SizedBox(
            height: 50.0,
          ),
          SkillSection(),
          const SizedBox(
            height: 50.0,
          ),
          Sponsors(),
          const SizedBox(
            height: 50.0,
          ),
          TestimonialWidget(), */
                              const SizedBox(
                                height: 450,
                              ),
                              Body(),
                              Footer(),

                              const SizedBox(height: 1, child: Start()),
                            ],
                          ),
                        ),
                      ),
                      LoginScreen(),
                      CreateAccount(),
                      AllCharts(),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
