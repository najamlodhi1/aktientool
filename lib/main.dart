import 'package:aktientool/authentication/screens/create_account.dart';
import 'package:aktientool/webpage/body.dart';
import 'package:aktientool/webpage/components/footer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aktientool/webpage/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authentication/screens/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'webpage/start.dart';

main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.black,
                  title: Image.asset(
                    'assets/images/logo.png',
                    height: 25,
                  ),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    controller: tabController,
                    isScrollable: true,
                    tabs: const <Widget>[
                      Tab(child: Text('Home')),
                      Tab(child: Text('Anmelden')),
                      Tab(child: Text('Mitgliedschaft')),
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
                          width: 500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "AKTIENTOOL UNTERSTÜTZT DICH",
                                style: GoogleFonts.oswald(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25.0,
                                ),
                              ),
                              Text(
                                "BEI DEINER ANLAGEENTSCHEIDUNG",
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
                              const Text(
                                "Analysiere schnell und einfach die Aktien, die deinen Anforderungen entsprechen. Vergleiche aktuelle und historische Aktienkurse und verschiedene Finanzkennzahlen, um mögliche Trends oder Muster in den Aktienmärkten erkennen. Und das alles in kürzester Zeit, ohne Stunden damit verbringen zu müssen, manuell Daten zu sammeln und zu analysieren. Investiere in deine Effizienz und nutze unseren Tool, um deine Anlageentscheidungen zu optimieren.",
                                style: TextStyle(
                                  color: kCaptionColor,
                                  fontSize: 15.0,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              SizedBox(
                                child: Wrap(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: const MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Text(
                                          "Kostenlos Mitglied werden und testen!",
                                          style: TextStyle(
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
                                height: 15.0,
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
                                        child: const Text(
                                          "LOS GEHTS",
                                          style: TextStyle(
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
                                        child: const Text(
                                          "ANMELDEN",
                                          style: TextStyle(
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
                          width: 120,
                        ),
                        SizedBox(
                          height: 400,
                          child: Image.asset(
                            "assets/images/image1.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),

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
                        const Body(),
                        Footer(),

                        const SizedBox(height: 1, child: Start()),
                      ],
                    ),
                  ),
                ),
                LoginScreen(),
                CreateAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
