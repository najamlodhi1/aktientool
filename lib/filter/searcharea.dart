// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use, non_constant_identifier_names, must_be_immutable, unused_local_variable

import 'package:aktientool/authentication/services/request_service.dart';
import 'package:aktientool/payment/stripe/hompage.dart';
import 'package:aktientool/payment/stripe/stripe_checkout_web.dart';
import 'package:aktientool/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'filter.dart';

final sp_search = StateProvider((ref) => "");
int requestsLeft = 0;

class SearchArea extends ConsumerWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController searchController = TextEditingController();
  Icon customIcon = const Icon(Icons.cancel);
  bool isFirst = true;
  Widget customSearchBar = Image.asset(
    'assets/images/logo.png',
    height: 25,
  );

  SearchArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String text = ref.watch(sp_search);
    searchController.text = text;
    searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );

    {
      return AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Filter(),
                ),
              );
            },
            icon: const Icon(Icons.menu)),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: ListTile(
          title: TextField(
            textAlign: TextAlign.center,
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Aktie eingeben',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
            onChanged: (newText) {
              ref.read(sp_search.notifier).state = newText;
              /*ref.read(sp_search.notifier).update(
                    (state) => searchController.text,
                  );*/
            },
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          searchController.text.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    searchController.text = "";
                    ref.read(sp_search.notifier).state = "";

/*
            setState(() {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Aktie eingeben',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  ref
                  sp_search = searchController.toString();
                );
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = Image.asset(
                  'assets/images/logo.png',
                  height: 25,
                );
              }
            }

            );*/
                  },
                  icon: customIcon,
                ),
          const SizedBox(
            width: 5,
          ),
          if (FirebaseAuth.instance.currentUser != null)
            Padding(
              padding: const EdgeInsets.all(2),
              child: ElevatedButton(
                onPressed: () async {
                  // var uid = auth.currentUser!.uid;
                  upgradepopup(context);
                },
                child: StreamBuilder<int>(
                    stream: RequestService().getrequests(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        requestsLeft = snapshot.data!;
                        if (requestsLeft == 0 && isFirst) {
                          isFirst = false;
                          Future.delayed(const Duration(milliseconds: 200))
                              .then((value) {
                            upgradepopup(context);
                          });
                        }
                      }
                      return Text(
                          snapshot.hasData ? snapshot.data!.toString() : '0');
                    }),
              ),
            )
          else
            const SizedBox.shrink(),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              icon: const Icon(Icons.settings))
        ],
        centerTitle: true,
      );
    }
  }
}

void upgradepopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      scrollable: true,
      title: const Text(
          'Upgraden um weiterhin den Aktientool zu benutzen. Es existieren 3 Pakete. 30 Anfragen kosten 10 EURO'),
      content: Column(
        children: [
          const Text(
              'Hinweis: Es wird kein Abo abgeschlossen. Sie bezahlen einmalig. Wenn die Anzahl der Anfragen auf 0 steht können Sie erneut einen Paket buchen.'),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              IconButton(
                icon: Image.asset('assets/images/30.png'),
                iconSize: 250,
                padding: const EdgeInsets.all(5.0),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Homepage(paymenttype: 1),
                    ),
                  );
                  redirectToCheckout(context, 1);
                },
              ),
              IconButton(
                icon: Image.asset('assets/images/100.png'),
                iconSize: 250,
                padding: const EdgeInsets.all(5.0),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Homepage(paymenttype: 2),
                    ),
                  );
                  redirectToCheckout(context, 2);
                },
              ),
              IconButton(
                icon: Image.asset('assets/images/200.png'),
                iconSize: 250,
                padding: const EdgeInsets.all(5.0),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Homepage(paymenttype: 3),
                    ),
                  );
                  redirectToCheckout(context, 3);
                },
              ),
              IconButton(
                icon: Image.asset('assets/images/cancel.png'),
                iconSize: 250,
                padding: const EdgeInsets.all(5.0),
                onPressed: () => Navigator.pop(context, 'ABBRECHEN'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
