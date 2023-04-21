// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use, non_constant_identifier_names, must_be_immutable, unused_local_variable

import 'package:aktientool/payment/stripe/hompage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../settings/app_localizations.dart';

final sp_search = StateProvider((ref) => "");
int requestsLeft = 0;

class SearchArea extends ConsumerWidget {
  late AppLocalizations trans;

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
    trans = AppLocalizations.of(context);

    String text = ref.watch(sp_search);
    searchController.text = text;
    searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );

    {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: ListTile(
          title: TextField(
            textAlign: TextAlign.center,
            controller: searchController,
            decoration: InputDecoration(
              hintText: trans.translate('Enter stock'),
              hintStyle: const TextStyle(
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
                  // redirectToCheckout(context, 1);
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
                  // redirectToCheckout(context, 2);
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
                  // redirectToCheckout(context, 3);
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
