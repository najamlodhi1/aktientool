import 'package:aktientool/startseite/footer.dart';
import 'package:aktientool/startseite/geld.dart';
import 'package:aktientool/startseite/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aktientool/datenschutz/cookie.dart';

final cookieProvider = StateProvider((ref) => false);

class Start extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () {
      if (ref.watch(cookieProvider.state).state == false) {
        checkCookies2(context, ref);
        //FireStoreDataBase fire = FireStoreDataBase();
        //fire.besuchercount();
      }
    });

    return Scaffold(
      appBar: headerNav(context),
      //drawer: drawerX(context),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[Geld() /*, Tools(), Beitrag(),*/, Footer()],
        ),
      ),
    );
  }
}
