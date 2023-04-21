import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter

class Haftung extends StatelessWidget {
  const Haftung({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Haftung für Inhalte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: const <Widget>[
                Text(
                  'Risikohinweis & Haftungsausschluss gemäß § 15 und § 17 AGB Aktientool.net',
                  style: TextStyle(fontSize: 25),
                ),
                Text('''\n
§ 15 Haftung\n
15.1 Soweit Nutzer Inhalte in Diskussionsforen, sogenannten Streams, Chats oder Blogs einstellen und dort Ratschläge oder Anlagetipps erteilen, handelt es sich ausschließlich um von den betreffenden Nutzern verantwortete Inhalte. Aktientool.net stellt insofern lediglich das Medium technisch zur Verfügung und ist nicht für die Genauigkeit, Richtigkeit oder Verlässlichkeit dieser Inhalte verantwortlich. Insbesondere ist Aktientool.net nicht für Verluste oder Schäden haftbar, die dem Nutzer dadurch entstehen, dass dieser auf eine solche Information vertraut.

15.2 Resultieren Schäden des Nutzers aus dem Verlust von Daten, so haftet Aktientool.net hierfür unabhängig von einer etwaigen Beteiligung nicht, soweit die Schäden durch eine zweckgemäße, regelmäßige und vollständige Sicherung aller relevanten Daten durch den Nutzer vermieden worden wären.

15.3 Im übrigen haften Aktientool.net, ihre gesetzlichen Vertreter und Erfüllungsgehilfen nur bei Verletzung des Lebens, des Körpers, der Gesundheit oder bei Verletzung wesentlicher Vertragspflichten (Kardinalpflichten), das heißt solcher Pflichten, deren Erfüllung die ordnungsgemäße Durchführung des Vertrages überhaupt erst ermöglicht und auf deren Einhaltung der Nutzer regelmäßig vertrauen darf, und deren Verletzung auf der anderen Seite die Erreichung des Vertragszwecks gefährdet. Aktientool.net haftet weiterhin für Schäden, die aus dem Fehlen zugesicherter Eigenschaften beruhen, sowie für sonstige Schäden, die auf einer vorsätzlichen oder grob fahrlässigen Pflichtverletzung von Aktientool.net, seiner gesetzlichen Vertreter oder Erfüllungsgehilfen beruhen.

15.4 Bei der Verletzung wesentlicher Vertragspflichten (vgl. Ziff. 15.3) haftet Aktientool.net nur auf den vertragstypischen, vorhersehbaren Schaden, wenn dieser einfach fahrlässig verursacht wurde, es sei denn, es handelt sich um Schadensersatzansprüche des Kunden aus einer Verletzung des Lebens, des Körpers oder der Gesundheit.

15.5 Weitergehende Ansprüche des Nutzers auf Schadensersatz sind ausgeschlossen. Die Vorschriften des Produkthaftungsgesetzes bleiben unberührt.

§ 17 Risikohinweis\n
Die Informationen und Services auf den Portalen von Aktientool.net wenden sich an registrierte sowie nichtregistrierte Nutzer. Die Angebote, die der Nutzer auf den Portalen von Aktientool.net findet, richten sich jedoch ausdrücklich nicht an Personen in Ländern, die das Vorhalten bzw. den Aufruf der darin eingestellten Inhalte untersagen, insbesondere nicht an US-Personen im Sinne der Regulation S des US Securities Act von 1933 sowie Internet-Nutzer in Großbritannien, Nordirland, Kanada und Japan. Jeder Nutzer ist selbst verantwortlich, sich über etwaige Beschränkungen vor Aufruf der Portale zu informieren und diese einzuhalten.

Insbesondere weist Aktientool.net hierbei auf die bei Geschäften mit Optionsscheinen, Derivaten und derivativen Finanzinstrumenten besonders hohen Risiken hin. Der Handel mit Optionsscheinen bzw. Derivaten ist ein Finanztermingeschäft. Den erheblichen Chancen stehen entsprechende Risiken gegenüber, die nicht nur einen Totalverlust des eingesetzten Kapitals, sondern darüber hinausgehende Verluste nach sich ziehen können. Aus diesem Grund setzt diese Art von Geschäften vertiefte Kenntnisse im Bezug auf diese Finanzprodukte, die Wertpapiermärkte, Wertpapierhandelstechniken und -strategien voraus.

Soweit Aktientool.net Börsen- oder Wirtschaftsinformationen, Kurse, Indizes, Preise, Nachrichten, Marktdaten sowie sonstige allgemeine Marktinformationen auf ihren Portalen bereitstellt, dienen diese nur zur Information und zur Unterstützung der selbstständigen Anlageentscheidung des Nutzers. Auch wenn Aktientool.net alle eingebundenen Informationen sorgsam überprüft, erhebt Aktientool.net keinen Anspruch auf inhaltliche Richtigkeit, Vollständigkeit oder Aktualität. Es obliegt dem Nutzer selbst, die Richtigkeit, Vollständigkeit und Aktualität dieser Daten zu überprüfen. Dies betrifft insbesondere, aber nicht ausschließlich, Kursdaten von Drittquellen. Die genannten Informationen stellen keine Aufforderung zum Kaufen, Halten oder Verkaufen von Wertpapieren und derivativen Finanzprodukten dar und begründen kein individuelles Beratungs- oder Auskunftsverhältnis. Sie sind keine Rechts-, Steuer- oder sonstige Beratung und können eine solche auch nicht ersetzen.

Bevor der Nutzer Investmententscheidungen trifft, sollte er sich sorgfältig über die Chancen und Risiken des Investments informiert haben. Aus einer positiven Wertentwicklung eines Finanzprodukts in der Vergangenheit kann keinesfalls auf zukünftige Erträge geschlossen werden. Aktientool.net übernimmt keine Haftung für die erteilten Informationen, die von Aktientool.net als vertrauenswürdig erachtet wurden, für bereitgestellte Handelsanregungen sowie für deren Vollständigkeit.

Leser sowie Teilnehmer an multimedialen Veranstaltungen wie Webinare, Online-Seminare, Seminare oder Vortragsveranstaltungen, die aufgrund der veröffentlichten Inhalte Anlageentscheidungen treffen bzw. Transaktionen durchführen, handeln in vollem Umfang auf eigene Gefahr und auf eigenes Risiko.

Aktientool.net übernimmt keine Haftung für die Inhalte externer Links. Für den Inhalt der verlinkten Seiten sind ausschließlich deren Betreiber verantwortlich. Eine Haftung von Aktientool.net für die Inhalte derartiger Internetseiten ist ausgeschlossen, soweit dies gesetzlich zulässig ist.

Stand Januar 2023
'''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
