// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'design_process.dart';

final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "BENUTZERFREUNDLICH",
    imagePath: "assets/images/1.png",
    subtitle:
        "Wir haben uns bei der Gestaltung unserer Software bemüht, sie so intuitiv und benutzerfreundlich wie möglich zu gestalten, damit du dich nicht durch verwirrende Menüs oder unübersichtliche Daten kämpfen zu musst.",
  ),
  DesignProcess(
    title: "QUALITATIVE ANALYSE",
    imagePath: "assets/images/2.png",
    subtitle:
        "Unser Tool unterstützt dich dabei, die wirtschaftliche Stärke und das zukünftige Wachstumspotential einer Aktie gründlich zu beurteilen und informierte Investitionsentscheidungen zu treffen.",
  ),
  DesignProcess(
    title: "UMFANGREICHE FILTER",
    imagePath: "assets/images/3.png",
    subtitle:
        "Die Filterfunktionen ermöglichen es, die Aktien anzuzeigen, die deinen Anforderungen entsprechen. Du kannst beispielsweise Aktien mit einer Dividendenrendite von mindestens 3% oder einem KGV von weniger als 15 anzeigen lassen.",
  ),
  DesignProcess(
    title: "AKTUELLE FINANZDATEN",
    imagePath: "assets/images/4.png",
    subtitle:
        "Wir bieten eine breite Palette an Daten zur Verfügung, einschließlich aktueller und historischer Informationen. Dies kann dir dabei helfen, fundierte Entscheidungen über ihre Investitionen zu treffen und mögliche Trends oder Muster in den Aktienmärkten zu erkennen.",
  ),
];

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: <Widget>[
          for (int i = 0; i < 4; i++)
            InkWell(
              onTap: () {},
              child: Container(
                width: 310,
                height: 210,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(2.0),
                //decoration: BoxDecoration(
                //  border: Border.all(color: Colors.white),
                //),
                child: Column(
                  children: [
                    Wrap(
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    designProcesses[i].imagePath,
                                    width: 40.0,
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    designProcesses[i].title,
                                    style: GoogleFonts.oswald(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                designProcesses[i].subtitle,
                                style: const TextStyle(
                                  color: kCaptionColor,
                                  height: 1.5,
                                  fontSize: 14.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
