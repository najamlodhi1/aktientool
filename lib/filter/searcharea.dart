// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use, non_constant_identifier_names, must_be_immutable, unused_local_variable

import 'package:aktientool/payment/stripe/hompage.dart';
import 'package:aktientool/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'filter.dart';

final sp_search = StateProvider((ref) => "");

class SearchArea extends ConsumerWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController searchController = TextEditingController();
  Icon customIcon = const Icon(Icons.cancel);
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
          FirebaseAuth.instance.currentUser != null
              ? Padding(
                  padding: const EdgeInsets.all(2),
                  child: ElevatedButton(
                    onPressed: () async {
                      var uid = auth.currentUser!.uid;
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Upgrade'),
                          content: const Text(
                              'Um weitere Suchanfragen zu tätigen sind 10 Euro fällig. Möchten Sie upgraden?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Homepage(),
                                  ),
                                );

                                //redirectToCheckout(context);
                              },
                              child: const Text('20'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Homepage(),
                                  ),
                                );

                                //redirectToCheckout(context);
                              },
                              child: const Text('50'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Homepage(),
                                  ),
                                );

                                //redirectToCheckout(context);
                              },
                              child: const Text('100'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'ABBRECHEN'),
                              child: const Text('CANCEL'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('9999'),
                  ),
                )
              : const SizedBox.shrink(),
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
