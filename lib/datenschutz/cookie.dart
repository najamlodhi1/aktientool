// ignore: file_names

// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aktientool/datenschutz/impressum.dart';
import 'package:aktientool/webpage/start.dart';

import '../webpage/constants.dart';
import 'agb.dart';
import 'datenschutzerklaerung.dart';

// stores ExpansionPanel state information
List<bool> switchState = [
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
];

cookiesLong(context) {
  // flutter defined function
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        contentPadding: const EdgeInsets.only(left: 25, right: 25),
        title: const Center(child: Text("Datenschutzerklärung")),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          margin: const EdgeInsets.all(5.0),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
//
                const Text(
                  'Um dir den bestmöglichen Service auf unserer Webseite zu gewährleisten, verwenden wir verschiedene Cookies. Wenn du damit einverstanden bist, klicke bitte auf "Erlauben und weiter". Du kannst deine Entscheidung jederzeit widerrufen. Alle Infos findest du in unserer Datenschutzerklärung.Wenn Sie unter 16 Jahre alt sind und Ihre Zustimmung zu freiwilligen Diensten geben möchten, müssen Sie Ihre Erziehungsberechtigten um Erlaubnis bitten.',
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print(switchState[0].toString());
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(300, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Alle Akzeptieren und weiter'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(300, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text('Speichern und weiter'),
                ),
                const Text(""),
                const Text(
                    "Essenzielle Cookies ermöglichen grundlegende Funktionen und sind für die einwandfreie Funktion der Website erforderlich."),
                createCookie(
                    0,
                    ''
                        'Essenziell',
                    'Name: Ezoic',
                    'Anbieter: Ezoic Inc, 6023 Innovation Way 2nd Floor, Carlsbad, CA 92009, USA',
                    'Zweck: Notwendig für die Grundfunktionen der Webseite.',
                    'Datenschutzerklärung: https://www.ezoic.com/privacy-policy/',
                    'Cookie Name: ez*, cf*, unique_id, __cf*, __utmt*',
                    'Cookie Laufzeit: 1 Jahr'),
                const Text(
                    "Präferenz Cookies speichern Informationen zur Darstellung und Funktion der Webseite, etwa ob eine optimierte oder die originale Version der Webseite angezeigt wird."),
                createCookie(
                    1,
                    'Präferenzen',
                    'Name: Ezoic - Preferences',
                    'Anbieter: Ezoic Inc, 6023 Innovation Way 2nd Floor, Carlsbad, CA 92009, USA',
                    'Zweck: Speichert Informationen, die das Verhalten oder Aussehen der Website verändern, wie z.B. Ihre bevorzugte Sprache oder die Region, in der Sie sich befinden.',
                    'Datenschutzerklärung: https://www.ezoic.com/privacy-policy/',
                    'Cookie Name: ez*, sitespeed_preview, FTNT*, SITESERVER, SL*, speed_no_process, GED_PLAYLIST_ACTIVITY, __guid',
                    'Cookie Laufzeit: 1 Jahr'),
                const Text(
                    "Statistik Cookies erfassen Informationen anonym. Diese Informationen helfen uns zu verstehen, wie unsere Besucher unsere Website nutzen."),
                createCookie(
                    2,
                    'Statistiken',
                    'Name: Ezoic - Statistics',
                    'Anbieter: Ezoic Inc, 6023 Innovation Way 2nd Floor, Carlsbad, CA 92009, USA',
                    'Zweck: Hilft zu verstehen, wie Besucher mit Websites interagieren, indem sie Informationen anonym sammeln und melden.',
                    'Datenschutzerklärung: https://www.ezoic.com/privacy-policy/',
                    'Cookie Name: ez*, __qca, _gid, _ga, _gat, AMP_ECID_EZOIC, __utm*, _ga*',
                    'Cookie Laufzeit: 1 Jahr'),

                createCookie(
                    3,
                    'Statistiken',
                    'Name: Google Analytics',
                    'Anbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Ireland',
                    'Zweck: Cookie von Google für Website-Analysen. Erzeugt statistische Daten darüber, wie der Besucher die Website nutzt.',
                    'Datenschutzerklärung: https://policies.google.com/privacy?hl=de',
                    'Cookie Name: _ga,_gat,_gid',
                    'Cookie Laufzeit: 2 Monate'),
                const Text(
                    "Marketing Cookies werden von Drittanbietern oder Publishern verwendet, um personalisierte Werbung anzuzeigen. Sie tun dies, indem sie Besucher über Websites hinweg verfolgen."),
                createCookie(
                    4,
                    'Marketing',
                    'Name: Ezoic - Marketing',
                    'Anbieter: Ezoic Inc, 6023 Innovation Way 2nd Floor, Carlsbad, CA 92009, USA',
                    'Zweck: Wird verwendet, um Besucher über Websites hinweg zu verfolgen. Die Absicht besteht darin, Anzeigen anzuzeigen, die für den einzelnen Benutzer relevant und ansprechend sind.',
                    'Datenschutzerklärung: https://www.ezoic.com/privacy-policy/',
                    'Cookie Name: ez*, _sm_au, cto*, __gads, mind*, _ym_uid, GoogleAdServingTest',
                    'Cookie Laufzeit: 1 Jahr'),
                const Text(
                    "Inhalte von Videoplattformen und Social Media Plattformen werden standardmäßig blockiert. Wenn Cookies von externen Medien akzeptiert werden, bedarf der Zugriff auf diese Inhalte keiner manuellen Zustimmung mehr."),
                createCookie(
                    5,
                    'Externe Medien',
                    'Name: Facebook',
                    'Anbieter: 	Meta Platforms Ireland Limited, 4 Grand Canal Square, Dublin 2, Ireland',
                    'Zweck: Wird verwendet, um Facebook-Inhalte zu entsperren.',
                    'Datenschutzerklärung: https://www.facebook.com/privacy/explanation',
                    'Host(s): .facebook.com',
                    ''),
                createCookie(
                    6,
                    'Externe Medien',
                    'Name: Google Maps',
                    'Anbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Ireland',
                    'Zweck: Wird zum Entsperren von Google Maps-Inhalten verwendet.',
                    'Datenschutzerklärung: https://policies.google.com/privacy',
                    'Host(s):	.google.com'
                        'Cookie Name: NID',
                    'Cookie Laufzeit: 6 Monate'),
                createCookie(
                    7,
                    'Externe Medien',
                    'Name: Instagram',
                    'Anbieter: Meta Platforms Ireland Limited, 4 Grand Canal Square, Dublin 2, Ireland',
                    'Zweck: Wird verwendet, um Instagram-Inhalte zu entsperren.',
                    'Datenschutzerklärung: https://www.instagram.com/legal/privacy/',
                    'Host(s): .instagram.com'
                        'Cookie Name: pigeon_state',
                    'Cookie Laufzeit: Sitzung'),
                createCookie(
                    8,
                    'Externe Medien',
                    'Name: OpenStreetMap',
                    'Anbieter: Openstreetmap Foundation, St John’s Innovation Centre, Cowley Road, Cambridge CB4 0WS, United Kingdom',
                    'Zweck: Wird verwendet, um OpenStreetMap-Inhalte zu entsperren.',
                    'Datenschutzerklärung: https://wiki.osmfoundation.org/wiki/Privacy_Policy',
                    'Host(s): .openstreetmap.org'
                        'Cookie Name: _osm_location, _osm_session, _osm_totp_token, _osm_welcome, _pk_id., _pk_ref., _pk_ses., qos_token',
                    'Cookie Laufzeit: 1-10 Jahre'),
                createCookie(
                    9,
                    'Externe Medien',
                    'Name: Twitter',
                    'Anbieter: Twitter International Company, One Cumberland Place, Fenian Street, Dublin 2, D02 AX07, Ireland',
                    'Zweck: Wird verwendet, um Twitter-Inhalte zu entsperren.',
                    'Datenschutzerklärung: https://twitter.com/privacy',
                    'Host(s): .twimg.com, .twitter.com'
                        'Cookie Name: __widgetsettings, local_storage_support_test',
                    'Cookie Laufzeit: Unbegrenzt'),
                createCookie(
                    10,
                    'Externe Medien',
                    'Name: Vimeo',
                    'Anbieter: Vimeo Inc., 555 West 18th Street, New York, New York 10011, USA',
                    'Zweck: Wird verwendet, um Vimeo-Inhalte zu entsperren.',
                    'Datenschutzerklärung: https://vimeo.com/privacy',
                    'Host(s): player.vimeo.com'
                        'Cookie Name: vuid',
                    'Cookie Laufzeit: 2 Jahre'),
                createCookie(
                    11,
                    'Externe Medien',
                    'Name: YouTube',
                    'Anbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Ireland',
                    'Zweck: Wird verwendet, um YouTube-Inhalte zu entsperren.',
                    'Datenschutzerklärung: https://policies.google.com/privacy',
                    'Host(s): google.com'
                        'Cookie Name: NID',
                    'Cookie Laufzeit: 6 Monate'),
                const Text(""),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print(switchState[0].toString());
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(300, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Alle Akzeptieren und weiter'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(300, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text('Speichern und weiter'),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Datenschutzerklaerung(),
                      ),
                    );
                  },
                  child: const Text("Datenschutzerklärung"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Impressum(),
                      ),
                    );
                  },
                  child: const Text("Impressum"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AGB(),
                      ),
                    );
                  },
                  child: const Text("AGB"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

checkCookies(context) {
  // flutter defined function
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: const Text("Datenschutzerklärung"),
        content: const Text(
          'Um dir den bestmöglichen Service auf unserer Webseite zu gewährleisten, verwenden wir verschiedene Cookies. Wenn du damit einverstanden bist, klicke bitte auf "Erlauben und weiter". Du kannst deine Entscheidung jederzeit widerrufen. Alle Infos findest du in unserer Datenschutzerklärung.Wenn Sie unter 16 Jahre alt sind und Ihre Zustimmung zu freiwilligen Diensten geben möchten, müssen Sie Ihre Erziehungsberechtigten um Erlaubnis bitten.',
        ),
        actions: <Widget>[
          Wrap(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    cookiesLong(context);
                  },
                  child: const Text("Cookie-Details")),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Datenschutzerklaerung(),
                    ),
                  );
                },
                child: const Text("Datenschutzerklärung"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Impressum(),
                    ),
                  );
                },
                child: const Text("Impressum"),
              ),
            ],
          ),
          // usually buttons at the bottom of the dialog
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cookiesLong(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: const Text('Individuelle Datenschutzeinstellung'),
          ),
          ElevatedButton(
            onPressed: () {
              if (kDebugMode) {
                print("Alle Cookies erlauben");
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: const Size(200, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Erlauben und weiter'),
          ),
        ],
      );
    },
  );
}

checkCookies2(context, WidgetRef ref) {
  // flutter defined function
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: const Text("Verwendung von Cookies"),
        content: const Text(
          'Um unsere Webseite für Sie optimal zu gestalten und fortlaufend verbessern zu können, verwenden wir Cookies. Durch die weitere Nutzung der Webseite stimmen Sie der Verwendung von Cookies zu.',
        ),
        actions: <Widget>[
          Wrap(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Datenschutzerklaerung(),
                    ),
                  );
                },
                child: const Text("Datenschutzerklärung"),
              ),
            ],
          ),
          // usually buttons at the bottom of the dialog

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(cookieProvider.state).state = true;
              if (kDebugMode) {
                print("Alle Cookies erlauben");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              fixedSize: const Size(200, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Widget createCookie(switchPos, String a, String b, String c, String d, String e,
    String f, String g) {
  //bool isSwitched = false;

  return Container(
    height: 300,
    padding: const EdgeInsets.all(2),
    alignment: Alignment.topLeft,
    decoration: const BoxDecoration(
      color: Colors.grey,
    ),
    child: Column(
      children: <Widget>[
        SizedBox(
            width: 350,
            child: Text(a,
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.left)),
        StatefulBuilder(builder: (context, setState) {
          return Center(
            child: Switch(
              value: switchState[switchPos],
              onChanged: (value) {
                setState(() {
                  switchState[switchPos] = value;
                  if (kDebugMode) {
                    print(value);
                  }
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          );
        }),
        SizedBox(
            width: 400,
            child: Text(b,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.left)),
        SizedBox(
            width: 400,
            child: Text(c,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.left)),
        SizedBox(
            width: 400,
            child: Text(d,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.left)),
        SizedBox(
            width: 400,
            child: Text(e,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.left)),
        SizedBox(
            width: 400,
            child: Text(f,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.left)),
        SizedBox(
            width: 400,
            child: Text(g,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.left)),
      ],
    ),
  );
}

class CookieList {}
