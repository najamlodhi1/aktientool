import 'package:aktientool/datenschutz/agb.dart';
import 'package:aktientool/datenschutz/datenschutzerklaerung.dart';
import 'package:aktientool/datenschutz/haftung.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

import '../../datenschutz/impressum.dart';
import '../../datenschutz/myformpage.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isSmallScreen = !(MediaQuery.of(context).size.width > 800);
    var sw = MediaQuery.of(context).size.width;
    var footerItemList = [
      {
        'heading': 'Company',
        'texts': [
          {'name': '', 'link': ''},
          {'name': 'About Us', 'link': '/about'},
          {'name': 'Services', 'link': '/services'},
          {'name': 'Contact Us', 'link': '/contact'},
        ],
      },
      {
        'heading': 'Socials',
        'texts': [
          {'name': '', 'link': ''},
          {
            'name': 'Youtube',
            'link':
                'https://www.youtube.com/channel/UCYMfu0xZgSTiNLjJLQ9zJhA?sub_confirmation=1'
          },
          {
            'name': 'Instagram',
            'link': '"https://www.instagram.com/aktientool/'
          },
          {'name': 'TikTok', 'link': 'https://www.instagram.com'},
        ],
      },
      {
        'heading': 'Legal',
        'texts': [
          {'name': '', 'link': ''},
          {'name': 'Impressum', 'link': '/raisa-a-ticket'},
          {'name': 'Datenschutz', 'link': '/privacy-policy'},
          {'name': 'AGB', 'link': '/blog'},
          {'name': 'Haftung', 'link': '/blog'},
        ],
      },
    ];
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left child widget
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SizedBox(
                    width: sw * .90 - 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 45.0,
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          '© Rohdaten von Financial Modeling Prep. Kennzahlen von Aktientool.Net\nAktientool kann für manche Links eine Affiliate-Provision erhalten \nwenn Produkte darüber erworben werden. Die Einnahmen fließen in die Entwicklung.',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff69767A),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'All rights reserved 2023.',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff69767A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // MyWidget on the right side
                SizedBox(
                  width: sw * .9 - 16,
                  child: FooterItemsWidget(
                    dataList: footerItemList,
                  ),
                ),
              ],
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left child widget
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.45) - 16 - 32,


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 45.0,
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            '© Rohdaten von Financial Modeling Prep. Kennzahlen von Aktientool.Net\nAktientool kann für manche Links eine Affiliate-Provision erhalten \nwenn Produkte darüber erworben werden. Die Einnahmen fließen in die Entwicklung.',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff69767A),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'All rights reserved.',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff69767A),
                            ),
                          ),
                        ],
                      ),
                    ),


                  // MyWidget on the right side
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.55) - 16 - 32,
                    child: FooterItemsWidget(
                      dataList: footerItemList,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class FooterItemsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;

  const FooterItemsWidget({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var data in dataList)
            Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Text(
                      data['heading'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  for (var textData in data['texts'])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () {
                          if (textData['name'] == "Youtube") {
                            js.context.callMethod(
                              'open',
                              [
                                'https://www.youtube.com/channel/UCYMfu0xZgSTiNLjJLQ9zJhA?sub_confirmation=1'
                              ],
                            );
                          } else if (textData['name'] == "Instagram") {
                            js.context.callMethod('open',
                                ["https://www.instagram.com/aktientool/"]);
                          } else if (textData['name'] == "TikTok") {
                            js.context.callMethod(
                                'open', ["https://www.tiktok.com/@aktientool"]);
                          } else if (textData['name'] == "Impressum") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Impressum(),
                              ),
                            );
                          } else if (textData['name'] == "Datenschutz") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Datenschutzerklaerung(),
                              ),
                            );
                          } else if (textData['name'] == "AGB") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AGB(),
                              ),
                            );
                          } else if (textData['name'] == "Haftung") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Haftung(),
                              ),
                            );
                          } else if (textData['name'] == "Contact Us") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyFormPage(),
                              ),
                            );
                          } else {
                            print(
                              textData['name'],
                            );
                          }
                        },
                        child: Text(
                          textData['name'],
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff69767A),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
