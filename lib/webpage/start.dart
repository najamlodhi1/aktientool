import 'package:aktientool/webpage/components/cv_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aktientool/datenschutz/cookie.dart';
import 'package:aktientool/webpage/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../authentication/screens/login.dart';
import 'components/footer.dart';

final cookieProvider = StateProvider((ref) => false);

class Start extends ConsumerWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () {
      // ignore: deprecated_member_use
      if (ref.watch(cookieProvider.state).state == false) {
        checkCookies2(context, ref);
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "AKTIENTOOL UNTERSTÜTZT DICH",
                    style: GoogleFonts.oswald(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    "BEI DEINER ANLAGEENTSCHEIDUNG",
                    style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Analysiere schnell und einfach die Aktien, die deinen Anforderungen entsprechen. Vergleiche aktuelle und historische Aktienkurse und verschiedene Finanzkennzahlen, um mögliche Trends oder Muster in den Aktienmärkten erkennen. Und das alles in kürzester Zeit, ohne Stunden damit verbringen zu müssen, manuell Daten zu sammeln und zu analysieren. Investiere in deine Effizienz und nutze unseren Tool, um deine Anlageentscheidungen zu optimieren.",
                    style: TextStyle(
                      color: kCaptionColor,
                      fontSize: 15.0,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    child: Wrap(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              "Kostenlos Mitglied werden und testen!",
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      height: 48.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "LOS GEHTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 500,
              child: Image.asset(
                "assets/images/image1.gif",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            CvSection(),
            //IosAppAd(),
            /*const SizedBox(
            height: 70.0,
          ),
          WebsiteAd(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            child: PortfolioStats(),
          ),
          const SizedBox(
            height: 50.0,
          ),
          EducationSection(),
          const SizedBox(
            height: 50.0,
          ),
          SkillSection(),
          const SizedBox(
            height: 50.0,
          ),
          Sponsors(),
          const SizedBox(
            height: 50.0,
          ),
          TestimonialWidget(), */
            Footer(),
          ],
        ),
      ),
    );
  }
}
