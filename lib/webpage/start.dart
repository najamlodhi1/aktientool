import 'package:aktientool/webpage/home2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aktientool/datenschutz/cookie.dart';

final cookieProvider = StateProvider((ref) => false);

class Start extends ConsumerWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () {
      // ignore: deprecated_member_use
      if (ref.watch(cookieProvider.state).state == false) {
        checkCookies2(context, ref);
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: const <Widget>[
            Home2(),
            //Body(),
            //Footer(),
          ],
        ),
      ),
    );
  }
}
