import 'package:aktientool/webpage/carousel_item_model.dart';
import 'package:aktientool/webpage/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<CarouselItemModel> carouselItems = List.generate(
  3,
  (index) => CarouselItemModel(
    text: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
          Container(
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
                onPressed: () {},
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
    image: Container(
      child: Image.asset(
        "assets/images/image1.gif",
        fit: BoxFit.contain,
      ),
    ),
  ),
);
