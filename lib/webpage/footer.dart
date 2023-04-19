// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:aktientool/datenschutz/agb.dart';
import 'package:aktientool/datenschutz/datenschutzerklaerung.dart';
import 'package:aktientool/datenschutz/impressum.dart';
import 'package:aktientool/webpage/constants.dart';
import 'package:aktientool/webpage/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:js' as js;
import '../../settings/app_localizations.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }
}

Widget _buildUi(double width, BuildContext context) {
  AppLocalizations trans = AppLocalizations.of(context);

  return Center(
    child: ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: SizedBox(
                height: 130,
                child:
                    Image.asset("assets/images/men.gif", fit: BoxFit.contain),
              )),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    print('click on edit');
                  },
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                    height: 40,
                  )),
              Wrap(
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                    color: kPrimaryColor,
                    iconSize: 50,
                    onPressed: () async {
                      js.context.callMethod(
                          'open', ["https://www.instagram.com/aktientool/"]);
                    },
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.youtube),
                    color: kPrimaryColor,
                    iconSize: 54,
                    onPressed: () async {
                      js.context.callMethod('open', [
                        'https://www.youtube.com/channel/UCYMfu0xZgSTiNLjJLQ9zJhA?sub_confirmation=1'
                      ]);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Datenschutzerklaerung(),
                        ),
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "\n${trans.translate("Data Protection")}",
                        style: const TextStyle(
                          color: kCaptionColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      "\n|",
                      style: TextStyle(
                        color: kCaptionColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Impressum(),
                        ),
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "\n${trans.translate("Imprint")}",
                        style: const TextStyle(color: kCaptionColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      "\n|",
                      style: TextStyle(
                        color: kCaptionColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AGB(),
                        ),
                      );
                    },
                    child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text("\n${trans.translate("Conditions")}",
                            style: const TextStyle(color: kCaptionColor))),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Center(
                    child: Text(
                      trans.translate("rawdata"),
                      style: const TextStyle(
                        color: kCaptionColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                child: Text(
                  "Aktientool kann für manche Links eine Affiliate-Provision erhalten wenn Produkte darüber erworben werden. Die Einnahmen fließen in die Entwicklung.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
