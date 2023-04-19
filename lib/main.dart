// bring greater transparency to financial markets, enabling the investment community to make better decisions
// ignore_for_file: avoid_web_libraries_in_flutter, constant_identifier_names

import 'dart:html' as html;
import 'package:aktientool/authentication/screens/login.dart';
import 'package:aktientool/authentication/services/request_service.dart';
import 'package:aktientool/stockscreener/home.dart';
import 'package:aktientool/webpage/footer.dart';
import 'package:aktientool/webpage/ios_app_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neon/neon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'authentication/screens/create_account.dart';
import 'charts/allCharts.dart';
import 'constants/responsive.dart';
import 'datenschutz/datenschutzerklaerung.dart';
import 'datenschutz/myformpage.dart';
import 'firebase_options.dart';
import 'webpage/body.dart';
import 'webpage/screen_helper.dart';
import 'settings/app_localizations.dart';

import 'package:responsive_framework/responsive_framework.dart';

import 'webpage/constants.dart';

class Stat {
  final String count;
  final String text;

  Stat({
    required this.count,
    required this.text,
  });
}

final List<Stat> stats = [
  Stat(count: "22500+", text: "Aktien"),
  Stat(count: "60", text: "Ländern"),
  Stat(count: "180+", text: "Industrien"),
];
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
      // ignore: deprecated_member_use
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
            return const Home();
          } else {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              appBar: PreferredSize(
                preferredSize: Size(screenSize.width, 1000),
                child: Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.accessibility,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllCharts(),
                              ),
                            );
                          },
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Image.asset('assets/images/logo.png',
                                    height: 30),
                              ),
                              /*SizedBox(width: screenSize.width / 20),
                              const Text("BLOG",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),*/
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () {},
                            child: IconButton(
                              icon: SvgPicture.asset(
                                "assets/images/${selectedLocale.languageCode}.svg",
                                fit: BoxFit.cover,
                              ),

                              //iconSize: 40,
                              onPressed: () {
                                MyApp.of(context)!.setLocale(
                                    selectedLocale.languageCode == 'us'
                                        ? 'de'
                                        : 'us');
                                setState(() {});
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),

              /*
              AppBar(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/logo.png', height: 30),
                    ],
                  ),
                  leading: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.accessibility),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllCharts(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/images/${selectedLocale.languageCode}.svg",
                        fit: BoxFit.cover,
                      ),
                      iconSize: 40,
                      onPressed: () {
                        MyApp.of(context)!.setLocale(
                            selectedLocale.languageCode == 'us' ? 'de' : 'us');
                        setState(() {});
                      },
                    )
                  ]),

                  */
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      actions: [
                        const Spacer(),
                        ButtonTheme(
                          height: 20,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Neon(
                              text: 'ANMELDEN',
                              color: Colors.purple,
                              fontSize: 20,
                              font: NeonFont.NightClub70s,
                              flickeringText: true,
                              flickeringLetters: null,
                              glowingDuration: const Duration(seconds: 3),
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MyFormPage(),
                              ),
                            );
                          },
                          child: const Text("FEEDBACK",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        const Spacer(),
                      ],
                      backgroundColor: Colors.black,
                      centerTitle: true,
                      pinned: true,
                      floating: true,
                      bottom: null,
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const SizedBox(
                                width: 0,
                              ),
                              SizedBox(
                                //width: 500,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 50.0,
                                    ),
                                    Text(
                                      trans.translate("A STOCK SCREENER"),
                                      style: GoogleFonts.oswald(
                                        color: kPrimaryColor,
                                        fontSize: 50.0,
                                      ),
                                    ),
                                    Text(
                                      trans.translate(
                                          "that quickly and easily the right shares for your portfolio."),
                                      style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontSize: 35.0,
                                        //fontWeight: FontWeight.w900,
                                        height: 1.3,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 255,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: CustomTheme
                                                      .loginGradientStart,
                                                  offset: Offset(1.0, 6.0),
                                                  blurRadius: 20.0,
                                                ),
                                                BoxShadow(
                                                  color: CustomTheme
                                                      .loginGradientEnd,
                                                  offset: Offset(1.0, 6.0),
                                                  blurRadius: 20.0,
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                  colors: <Color>[
                                                    CustomTheme
                                                        .loginGradientEnd,
                                                    CustomTheme
                                                        .loginGradientStart
                                                  ],
                                                  begin: FractionalOffset(
                                                      0.2, 0.2),
                                                  end: FractionalOffset(
                                                      1.0, 1.0),
                                                  stops: <double>[0.0, 1.0],
                                                  tileMode: TileMode.clamp),
                                            ),
                                            child: MaterialButton(
                                              highlightColor:
                                                  Colors.transparent,
                                              splashColor:
                                                  CustomTheme.loginGradientEnd,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                child: Text(
                                                  trans.translate(
                                                      "Kostenlos Registrieren"),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22.0,
                                                      fontFamily:
                                                          'WorkSansBold'),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreateAccount(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        if (Responsive.isDesktop(context) ==
                                            false)
                                          const SizedBox(
                                            height: 100,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              SizedBox(
                                  height: 500,
                                  child: Image.asset(
                                      "assets/images/website.png",
                                      fit: BoxFit.contain)),
                              const SizedBox(
                                height: 600,
                              ),
                              Body(),
                              IosAppAd(),
                              const PortfolioStats(),
                              const SizedBox(
                                width: 200,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Footer(),
                    ],
                  ),
                ),
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
                        builder: (context) => const Datenschutzerklaerung(),
                      ),
                    );
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

class PortfolioStats extends StatelessWidget {
  const PortfolioStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }

  Widget _buildUi(double width, BuildContext context) {
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
          return Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: stats.map((stat) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                // Just use the helper here really
                width: ScreenHelper.isMobile(context)
                    ? constraint.maxWidth / 2.0 - 20
                    : (constraint.maxWidth / 4.0 - 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      stat.count,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w700,
                        fontSize: 32.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      stat.text,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: kCaptionColor,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
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
