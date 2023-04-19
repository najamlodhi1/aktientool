// ignore_for_file: avoid_web_libraries_in_flutter, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../settings/app_localizations.dart';
import 'constants.dart';
import 'design_process.dart';

final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "USER FRIENDLY",
    imagePath: "assets/images/1.png",
    subtitle: "homesubtitle1",
  ),
  DesignProcess(
    title: "QUALITATIVE ANALYSIS",
    imagePath: "assets/images/2.png",
    subtitle: "homesubtitle2",
  ),
  DesignProcess(
    title: "EXTENSIVE FILTERS",
    imagePath: "assets/images/3.png",
    subtitle: "homesubtitle3",
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
                                  const Icon(
                                    Icons.account_tree_outlined,
                                    color: kPrimaryColor,
                                  ),
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
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
