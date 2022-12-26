import 'package:aktientool/authentication/screens/create_account.dart';
import 'package:aktientool/authentication/screens/login.dart';
import 'package:aktientool/webpage/start.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
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

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        length: 5,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.black,
                  title: Image.asset('images/logo.png', height: 30),
                  pinned: true,
                  floating: true,
                  bottom: const TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(child: Text('Home')),
                      Tab(child: Text('Anmelden')),
                      Tab(child: Text('Mitgliedschaft')),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[Start(), LoginScreen(), CreateAccount()],
            ),
          ),
        ),
      ),
    );
  }
}
