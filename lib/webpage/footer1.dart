import 'package:flutter/material.dart';

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
          {'name': 'About Us', 'link': '/about'},
          {'name': 'Services', 'link': '/services'},
          {'name': 'Contact Us', 'link': '/contact'},
        ],
      },
      {
        'heading': 'Socials',
        'texts': [
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
          {'name': 'Impressum', 'link': '/raisa-a-ticket'},
          {'name': 'Datenschutz', 'link': '/privacy-policy'},
          {'name': 'AGB', 'link': '/blog'},
          {'name': 'Haftung', 'link': '/blog'},
        ],
      },
    ];
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left child widget
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          '© Rohdaten von Financial Modeling Prep. Kennzahlen von Aktientool.Net\nAktientool kann für manche Links eine Affiliate-Provision erhalten wenn Produkte darüber erworben werden. Die Einnahmen fließen in die Entwicklung.',
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
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left child widget
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.35) - 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 45.0,
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          '© Rohdaten von Financial Modeling Prep. Kennzahlen von Aktientool.Net\nAktientool kann für manche Links eine Affiliate-Provision erhalten wenn Produkte darüber erworben werden. Die Einnahmen fließen in die Entwicklung.',
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
                ),

                // MyWidget on the right side
                SizedBox(
                  width: (MediaQuery.of(context).size.width * 0.55) - 16,
                  child: FooterItemsWidget(
                    dataList: footerItemList,
                  ),
                ),
              ],
            ),
    );
  }
}

class FooterItemsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;

  const FooterItemsWidget({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var data in dataList)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      onTap: () {},
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
    );
  }
}
