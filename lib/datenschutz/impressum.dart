import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class Impressum extends StatelessWidget {
  const Impressum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Impressum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                const Text(
                  'Angaben gemäß § 5 TMG',
                  style: TextStyle(fontSize: 25),
                ),
                const Text('''
\nBetül Öztürk
Donauschwabenweg 10
72108 Ergenzingen

Steuer-ID. 86343/21762
\n'''),
                const Text(
                  'Kontakt',
                  style: TextStyle(fontSize: 25),
                ),
                const Text('''\nTelefon: +4915251509689
E-Mail: aktientool[at]outlook.de\n'''),
                const Text(
                  'Verantwortlich für den Inhalt nach § 55 Abs. 2 RStV:',
                  style: TextStyle(fontSize: 25),
                ),
                const Text('''
\nBetül Öztürk
Donauschwabenweg 10
72108 Ergenzingen\n'''),
                const Text(
                  'EU-Streitschlichtung',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                    '''\nDie Europäische Kommission stellt eine Plattform zur Online-Streitbeilegung (OS) bereit. Die Plattform finden Sie unter: '''),
                TextButton(
                    onPressed: () {
                      js.context.callMethod(
                          'open', ['https://ec.europa.eu/consumers/odr/']);
                    },
                    child: const Text("https://ec.europa.eu/consumers/odr/\n")),
                const Text(
                  'Verbraucher­streit­beilegung/\n'
                  'Universal­schlichtungs­stelle',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                    '''\nWir sind nicht bereit oder verpflichtet, an Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle teilzunehmen.\n'''),
                const Text(
                  'Haftung für Inhalte',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                    '''\nAls Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen.

Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten Rechtsverletzung möglich. Bei Bekanntwerden von entsprechenden Rechtsverletzungen werden wir diese Inhalte umgehend entfernen.\n'''),
                const Text(
                  'Haftung für Links',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                    '''\nUnser Angebot enthält Links zu externen Websites Dritter, auf deren Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar.

Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links umgehend entfernen.\n'''),
                const Text(
                  'Urheberrecht',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                    '''\nDie durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den privaten, nicht kommerziellen Gebrauch gestattet.

Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte umgehend entfernen.\n'''),
                const Text(
                  'Angaben gemäß §34b WpHG',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                    '''\nVom Betreiber dieser Webseite gehandelte NFTs, Aktien, ETFs und Fonds sind immer mit Risiken behaftet. Alle Texte sowie die Hinweise und Informationen stellen keine Anlageberatung oder Empfehlung dar. Sie wurden nach bestem Wissen und Gewissen aus öffentlich zugänglichen Quellen übernommen. Alle zur Verfügung gestellten Informationen (alle Gedanken, Prognosen, Kommentare, Hinweise, Ratschläge etc.) dienen allein der Bildung und der privaten Unterhaltung.

Eine Haftung für die Richtigkeit kann in jedem Einzelfall trotzdem nicht übernommen werden. Sollten die Besucher dieser Seite sich die angebotenen Inhalte zu eigen machen oder etwaigen Ratschlägen folgen, so handeln sie eigenverantwortlich.\n'''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
