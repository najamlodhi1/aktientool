// ignore_for_file: avoid_web_libraries_in_flutter, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../settings/app_localizations.dart';
import 'constants.dart';

final List title = [
  "INVESTIERE WIE BÖRSENGURUS",
  "EXTENSIVE FILTERS",
  "SCORING SYSTEM"
];

final List title2 = ["homesubtitle1", "homesubtitle3", "homesubtitle2"];

final List icons = [
  const Icon(
    Icons.accessibility_new_outlined,
    color: kPrimaryColor,
  ),
  const Icon(
    Icons.screen_search_desktop_outlined,
    color: kPrimaryColor,
  ),
  const Icon(
    Icons.account_tree_outlined,
    color: kPrimaryColor,
  ),
];

class Body extends StatelessWidget {
  Body({super.key});
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              Container(
                width: 330,
                height: 210,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(2.0),
                child: Wrap(
                  children: [
                    icons[i],
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      trans.translate(title[i]),
                      style: GoogleFonts.oswald(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      trans.translate(title2[i]),
                      style: const TextStyle(
                        color: kCaptionColor,
                        height: 1.5,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
