import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../authentication/services/auth_service.dart';
import '../main.dart';
import 'app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late AppLocalizations trans;
  String userInquiry = '';

  bool hideContactUsBlock = false;

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    Color pickerColor = Colors.green;
    Color currentColor = Colors.green;

    Color buttonTextGreenColor = const Color(0xff28b6aa);
    Color contactUsEmail = const Color(0xff25a49b);

    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    // Setting List Options
    List<SettingOption> generalOptionsList = [
      SettingOption(
        heading: 'App Language',
        subheading: 'Change the language of the app',
        trailingWidget: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                title: const Text('Select Language'),
                titlePadding: const EdgeInsets.fromLTRB(20, 24, 0, 0),
                children: [
                  ListTile(
                    title: const Text('English'),
                    onTap: () {
                      MyApp.of(context)!.setLocale('en');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Deutsch'),
                    onTap: () {
                      MyApp.of(context)!.setLocale('de');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: Text(
            'Change',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: buttonTextGreenColor),
          ),
        ),
        toggleFunction: (value) {},
      ),
      SettingOption(
        heading: "Text Color",
        subheading: 'Change the color of text in the app',
        trailingWidget: TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Pick a Text Color!'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          setState(() => currentColor = pickerColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
          child: Text(
            'Change',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: buttonTextGreenColor),
          ),
        ),
        toggleFunction: (value) {
          {}
        },
      ),
      SettingOption(
        heading: "Background Color",
        subheading: 'Change the background color of the app',
        trailingWidget: TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Pick a Background Color!'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          setState(() => currentColor = pickerColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
          child: Text(
            'Change',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: buttonTextGreenColor),
          ),
        ),
        toggleFunction: (value) {},
      ),
    ];

    List<SettingOption> notificationsList = [
      SettingOption(
        heading: "Portfolio Summary",
        subheading:
            'Your personal weekly summary of the market, your portfolios and your assets.',
        isToggle: true,
        toggleValue: false,
        isToggleDisabled: true,
        toggleFunction: (value) {},
      ),
      SettingOption(
        heading: "Product updates",
        subheading:
            'Find out about new features, product updates and exclusive promotions.',
        isToggle: true,
        toggleValue: true,
        toggleFunction: (value) {},
      ),
      SettingOption(
        heading: "Community Updated",
        subheading:
            'New comments on yours articles, summaries and more - managed directly in the community.',
        trailingWidget: TextButton(
          onPressed: () {},
          child: Text(
            'Manage',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: buttonTextGreenColor),
          ),
        ),
        toggleFunction: (value) {},
      ),
    ];
    List<SettingOption> accountSettingList = [
      SettingOption(
        heading: trans.translate('Logout'),
        subheading: 'Log out of your account',
        trailingWidget: TextButton(
          onPressed: () {
            AuthService().signOut().then((result) {
              if (kDebugMode) {
                print(result);
              }
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const MyApp(),
                ),
              );
            }).catchError((error) {
              if (kDebugMode) {
                print('Registration Error: $error');
              }
            });
          },
          child: Text(
            trans.translate('Logout'),
            style: TextStyle(
                fontWeight: FontWeight.w600, color: buttonTextGreenColor),
          ),
        ),
        toggleFunction: (value) {},
      ),
      SettingOption(
          headingWidget: Expanded(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(0, hideContactUsBlock ? 7 : 10, 0, 0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 15, color: Color(0xff434c5b), height: 1.3),
                  children: [
                    const WidgetSpan(
                        child: Icon(
                      Icons.warning_rounded,
                      size: 18,
                      color: Color(0xffFDBA74),
                    )),
                    const TextSpan(
                      text: ' ',
                    ),
                    const TextSpan(
                      text:
                          'If you only want to delete your portfolio, you can do this in your ',
                    ),
                    TextSpan(
                      text: 'Portfolio Dashboard ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonTextGreenColor),
                    ),
                    const TextSpan(
                      text: 'under ',
                    ),
                    const TextSpan(
                      text: '"Manage" ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff050d1c)),
                    ),
                    const TextSpan(
                      text: '- you don\'t have to delete your account.',
                    ),
                  ],
                ),
              ),
            ),
          ),
          subheadingWidget: SizedBox(
            height: hideContactUsBlock ? 0 : 5,
          ),
          noBottomBorder: true,
          toggleFunction: (_) {}),
      SettingOption(
        noBottomBorder: hideContactUsBlock,
        toggleFunction: (_) {},
        bottomBorderColor: const Color(0xffe7e9ed),
        leadingWidget: Container(
          margin: EdgeInsets.only(bottom: hideContactUsBlock ? 5 : 19),
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(0),
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xff232735),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Text(
                  'De-register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        trailingWidget: Container(
          margin: EdgeInsets.only(bottom: hideContactUsBlock ? 5 : 19),
          child: TextButton(
            onPressed: () {
              setState(() {
                hideContactUsBlock = true;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xfffee2e1),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                const Color(0xffc64240),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
              child: Text(
                trans.translate('Delete Account'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),

      // hide these blocks when delete account btn is clicked
      if (!hideContactUsBlock) ...[
        SettingOption(
            headingWidget: const Padding(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
              child: Text(
                "Too bad you are leaving us!",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff050d1c)),
              ),
            ),
            subheadingWidget: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 15, color: Color(0xff434c5b), height: 1.3),
                  children: [
                    const TextSpan(
                      text:
                          'Tell us how we can improve Parqet in the future. You had problems with parqet? Feel free to contact us at ',
                    ),
                    TextSpan(
                      text: 'support@parqet.com ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: contactUsEmail),
                    ),
                    const TextSpan(
                      text: 'and we will take care of your request.',
                    )
                  ],
                ),
              ),
            ),
            noBottomBorder: true,
            toggleFunction: (_) {}),
        SettingOption(
            customWidget: Padding(
              padding: const EdgeInsets.only(bottom: 18.0, top: 15),
              child: TextAreaWidget(
                onTextChanged: (String value) {
                  setState(() {
                    userInquiry = value;
                  });
                },
              ),
            ),
            noBottomBorder: true,
            toggleFunction: (_) {}),
        SettingOption(
          heading: '.',
          toggleFunction: (_) {},
          noBottomBorder: true,
          leadingWidget: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 0),
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xfffee2e1),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xffc64240),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Text(
                  'Delete account irrevocably',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          trailingWidget: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 0),
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.all(0),
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xff232735),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: Text(
                    'Interrupt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]
    ];
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(children: [
            SettingsWidget(
              heading_left: 'Theme & Language',
              heading_right: 'Personalization',
              subheading_left: 'Customize the app theme colors and language',
              options: generalOptionsList,
            ),
            if (FirebaseAuth.instance.currentUser != null) ...[
              SettingsWidget(
                heading_left: 'Notifications',
                heading_right: "E-Mail",
                subheading_left: 'Manage your notifications',
                options: notificationsList,
              ),
              SettingsWidget(
                heading_left: 'Your account',
                heading_right: "Account Settings",
                subheading_left:
                    'This is where you manage your parquet account.',
                options: accountSettingList,
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

class SettingOption {
  final String heading;
  final String subheading;
  final bool isToggle;
  final bool isToggleDisabled;
  bool toggleValue;
  bool noBottomBorder;
  final Function(dynamic argu) toggleFunction;
  Color? bottomBorderColor;
  Widget? leadingWidget;
  Widget? trailingWidget;
  Widget? headingWidget;
  Widget? subheadingWidget;
  Widget? customWidget;

  SettingOption({
    this.heading = '',
    this.headingWidget,
    this.subheading = '',
    this.subheadingWidget,
    this.isToggle = false,
    this.toggleValue = false,
    this.isToggleDisabled = false,
    this.leadingWidget,
    this.bottomBorderColor,
    this.trailingWidget,
    required this.toggleFunction,
    this.noBottomBorder = false,
    this.customWidget,
  });
}

class SettingsWidget extends StatefulWidget {
  final List<SettingOption> options;
  final String heading_left;
  final String heading_right;
  final String subheading_left;
  final bool showBottomBorder;

  const SettingsWidget({
    Key? key,
    required this.options,
    required this.heading_left,
    required this.heading_right,
    required this.subheading_left,
    this.showBottomBorder = true,
  }) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraint) {
        final width = constraint.maxWidth;
        final isSmallScreen = constraint.maxWidth < 600;
        double width_70 = isSmallScreen ? width : width * 0.69;
        double width_30 = width * 0.30;

        return Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color(0xffE6E8EC),
                width: widget.showBottomBorder ? 2 : 0,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: !isSmallScreen,
                child: Container(
                  width: width_30,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Color(0xff050d1c)),
                          widget.heading_left),
                    ),
                    subtitle: widget.subheading_left.isNotEmpty
                        ? Text(
                            widget.subheading_left,
                            style: const TextStyle(color: Color(0xff757b89)),
                          )
                        : null,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: SizedBox(
                  width: width_70,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      margin: EdgeInsets.zero,
                      elevation: 2,
                      child: Column(
                        children: [
                          Container(
                            height: 38,
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                              color: Color(0xffF9FAFB),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 3, 0, 0),
                              child: Text(
                                  style: const TextStyle(
                                      color: Color(0xff757b89),
                                      fontSize: 12,
                                      height: 0),
                                  widget.heading_right.toUpperCase()),
                            ),
                          ),
                          for (int index = 0;
                              index < widget.options.length;
                              index++)
                            widget.options[index].customWidget != null
                                ? Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: widget
                                            .options[index].customWidget!))
                                : Container(
                                    padding: widget.options[index]
                                                .bottomBorderColor ==
                                            null
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 16.0)
                                        : EdgeInsets.zero,
                                    margin: widget.options[index]
                                                .bottomBorderColor !=
                                            null
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 16.0)
                                        : EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      border:
                                          widget.options[index].noBottomBorder
                                              ? const Border()
                                              : Border(
                                                  bottom: BorderSide(
                                                    color: widget.options[index]
                                                            .bottomBorderColor ??
                                                        const Color(0xffF9FAFB),
                                                    width: 2,
                                                  ),
                                                ),
                                    ),
                                    child: ListTileWidget(index, context),
                                  ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  ListTile ListTileWidget(int index, BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      minVerticalPadding: widget.options[index].noBottomBorder ? 0 : 4,
      leading: widget.options[index].leadingWidget,
      title: widget.options[index].headingWidget ??
          (widget.options[index].heading.isNotEmpty
              ? Padding(
                  padding: widget.options[index].noBottomBorder
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff050d1c)),
                      widget.options[index].heading),
                )
              : null),
      subtitle: widget.options[index].subheadingWidget ??
          (widget.options[index].subheading.isNotEmpty
              ? Text(
                  widget.options[index].subheading,
                  style: const TextStyle(color: Color(0xff757b89)),
                )
              : null),
      trailing: widget.options[index].trailingWidget ??
          (widget.options[index].isToggle
              ? Container(
                  alignment: Alignment.centerRight,
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                          visible: widget.options[index].isToggleDisabled,
                          child: const Icon(
                            Icons.lock,
                            size: 15,
                            color: Color(0xffFDBA74),
                          )),
                      Transform.scale(
                        scale: 0.70,
                        child: CupertinoSwitch(
                          activeColor: const Color(0xff28b6aa),
                          value: widget.options[index].isToggleDisabled
                              ? false
                              : widget.options[index].toggleValue,
                          onChanged: (value) {
                            if (widget.options[index].isToggleDisabled) {
                              return;
                            }
                            setState(() {
                              widget.options[index].toggleValue =
                                  !widget.options[index].toggleValue;
                            });
                            widget.options[index].toggleFunction(value);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : null),
    );
  }
}

class TextAreaWidget extends StatefulWidget {
  final Function(String)? onTextChanged;

  const TextAreaWidget({Key? key, this.onTextChanged}) : super(key: key);

  @override
  _TextAreaWidgetState createState() => _TextAreaWidgetState();
}

class _TextAreaWidgetState extends State<TextAreaWidget> {
  String userInquiry = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: MediaQuery.of(context).size.width > 920 ? 75 : 100,
        child: TextField(
          keyboardType: TextInputType.multiline,
          expands: true,
          minLines: null,
          maxLines: null,
          onChanged: (value) {
            setState(() {
              userInquiry = value;
            });
            if (widget.onTextChanged != null) {
              widget.onTextChanged!(value);
            }
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            hintText: '',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
