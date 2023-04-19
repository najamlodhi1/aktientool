// ignore_for_file: avoid_web_libraries_in_flutter, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../settings/app_localizations.dart';
import 'constants.dart';
import 'design_process.dart';

final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "INVESTIERE WIE BÖRSENGURUS",
    imagePath: const Icon(
      Icons.accessibility_new_outlined,
      color: kPrimaryColor,
    ),
    subtitle: "homesubtitle1",
  ),
  DesignProcess(
    title: "EXTENSIVE FILTERS",
    imagePath: const Icon(
      Icons.screen_search_desktop_outlined,
      color: kPrimaryColor,
    ),
    subtitle: "homesubtitle3",
  ),
  DesignProcess(
    title: "SCORING SYSTEM",
    imagePath: const Icon(
      Icons.account_tree_outlined,
      color: kPrimaryColor,
    ),
    subtitle: "homesubtitle2",
  ),
  /*
  DesignProcess(
    title: "CURRENT FINANCIAL DATA",
    imagePath: "assets/images/4.png",
    subtitle: "homesubtitle4",
  ),
  */
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
              InkWell(
                onTap: () {},
                child: Container(
                  width: 330,
                  height: 210,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(2.0),
                  //decoration: BoxDecoration(
                  //  border: Border.all(color: Colors.white),
                  //),
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                designProcesses[i].imagePath,
                                //Icons.account_tree_outlined,

                                const SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  trans.translate(designProcesses[i].title),
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
                              trans.translate(designProcesses[i].subtitle),
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}
