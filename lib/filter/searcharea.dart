// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aktientool/payment/stripe/hompage.dart';
import 'package:aktientool/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'filter.dart';

class SearchArea extends AppBar {
  SearchArea({Key? key}) : super(key: key);

  @override
  State<SearchArea> createState() => _SearchfieldState();
}

class _SearchfieldState extends State<SearchArea> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Image.asset(
    'assets/images/logo.png',
    height: 25,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Filter(),
              ),
            );
          },
          icon: const Icon(Icons.menu)),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      title: customSearchBar,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = const ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'Aktie eingeben',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = Image.asset(
                  'assets/images/logo.png',
                  height: 25,
                );
              }
            });
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
                            child: const Text('NEIN'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Upgrade'),
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
