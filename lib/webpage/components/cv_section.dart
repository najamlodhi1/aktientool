import 'package:aktientool/webpage/constants.dart';
import 'package:aktientool/webpage/design_process.dart';
import 'package:aktientool/webpage/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "BENUTZERFREUNDLICH",
    imagePath: "web/images/design.png",
    subtitle:
        "Wir haben uns bei der Gestaltung unserer Software bemüht, sie so intuitiv und benutzerfreundlich wie möglich zu gestalten, damit du dich nicht durch verwirrende Menüs oder unübersichtliche Daten kämpfen zu musst.",
  ),
  DesignProcess(
    title: "QUALITATIVE ANALYSE",
    imagePath: "web/images/develop.png",
    subtitle:
        "Unser Tool unterstützt dich dabei, die wirtschaftliche Stärke und das zukünftige Wachstumspotential einer Aktie gründlich zu beurteilen und informierte Investitionsentscheidungen zu treffen.",
  ),
  DesignProcess(
    title: "UMFANGREICHE FILTER",
    imagePath: "web/images/write.png",
    subtitle:
        "Die Filterfunktionen ermöglichen es, die Aktien anzuzeigen, die deinen Anforderungen entsprechen. Du kannst beispielsweise Aktien mit einer Dividendenrendite von mindestens 3% oder einem KGV von weniger als 15 anzeigen lassen.",
  ),
  DesignProcess(
    title: "AKTUELLE FINANZDATEN",
    imagePath: "web/images/promote.png",
    subtitle:
        "Wir bieten eine breite Palette an Daten zur Verfügung, einschließlich aktueller und historischer Informationen. Dies kann dir dabei helfen, fundierte Entscheidungen über ihre Investitionen zu treffen und mögliche Trends oder Muster in den Aktienmärkten zu erkennen.",
  ),
];

class CvSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ScreenHelper(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    // we need the context to get maxWidth before the constraints below
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              /*
              Text(
                "\nBENUTZERFREUNDLICH",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.8,
                  fontSize: 18.0,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "DOWNLOAD CV",
                    style: GoogleFonts.oswald(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),*/
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          Container(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ResponsiveGridView.builder(
                  padding: const EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  alignment: Alignment.topCenter,
                  gridDelegate: ResponsiveGridDelegate(
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    maxCrossAxisExtent: ScreenHelper.isTablet(context) ||
                            ScreenHelper.isMobile(context)
                        ? constraints.maxWidth / 2.0
                        : 250.0,
                    // Hack to adjust child height
                    childAspectRatio: ScreenHelper.isDesktop(context)
                        ? 1
                        : MediaQuery.of(context).size.aspectRatio * 1.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                designProcesses[index].imagePath,
                                width: 40.0,
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                designProcesses[index].title,
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
                            designProcesses[index].subtitle,
                            style: const TextStyle(
                              color: kCaptionColor,
                              height: 1.5,
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: designProcesses.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
