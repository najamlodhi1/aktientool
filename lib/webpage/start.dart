import 'package:aktientool/services/app_services.dart';
import 'package:aktientool/webpage/body.dart';
import 'package:aktientool/webpage/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aktientool/datenschutz/cookie.dart';

final cookieProvider = StateProvider((ref) => false);

class Start extends ConsumerWidget {
  Start({super.key});

  final AppServices appServices = AppServices();

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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: const <Widget>[
            Body(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
