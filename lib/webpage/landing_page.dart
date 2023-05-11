import 'package:aktientool/authentication/screens/create_account.dart';
import 'package:aktientool/authentication/screens/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../datenschutz/myformpage.dart';
import 'footer1.dart';

var getLoginText = 'Anmelden';
var getStartedText = 'Get Started';
var contactUsText = 'Contact Us';
var viewDemoText = 'View Demo';

class Step {
  var h;
  var sh;
  Step(this.h, this.sh);
}

class TextWidgetClass {
  String h;
  String h1;
  String sh;
  String sh1;
  String img;

  TextWidgetClass(
      {required this.h,
      required this.sh,
      this.img = '',
      this.h1 = '',
      this.sh1 = ''});

  factory TextWidgetClass.fromJson(Map<String, dynamic> json) {
    return TextWidgetClass(
      h: json['h'],
      sh: json['sh'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h'] = h;
    data['sh'] = sh;
    data['img'] = img;
    return data;
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final ScrollController _scrollController;

  bool _isPageScrolled = false;
  List<TextWidgetClass> firstWidgetTexts = [
    TextWidgetClass(
      sh: 'Start selling online with your own web & mobile app in a few simple steps!',
      h: 'Grow Your Business',
      h1: 'By Taking Your Store Online.',
      img: 'assets/images/landing_page/banner_img.png',
    ),
  ];
  List<Step> secondWidgetTexts = [
    Step('Step #1', 'Create and name your store'),
    Step('Step #2', 'Load your products on store'),
    Step('Step #3', 'Share & maximize your profits'),
  ];
  List<TextWidgetClass> thirdWidgetTexts = [
    TextWidgetClass(
      sh: 'PixaCart is integrated with the proven techniques that optimizes your revenue!',
      h: 'Proven Methods For',
      h1: 'Raising Sales And Revenue',
    ),
    TextWidgetClass(
      h: 'Order Bump',
      sh: 'The order bump offer is prominently displayed on the checkout page, allowing customers to easily add an additional product to their purchase with a single click.\n\nThis simple yet effective feature provides customers with an effortless way to enhance their shopping experience\n\nOrder Bumps can significantly boost store sales and maximize profits.',
      img: 'assets/images/landing_page/s3_mockup1.png',
    ),
    TextWidgetClass(
      h: 'Cart Abandonment',
      sh: 'Revive lost sales by engaging with prospects who abandoned their purchase. Reach out to these potential customers and remind them of product & why they should come back and complete their purchase.\n\nUtilize targeted campaigns to re-engage these prospects and encourage them to make the purchase they were considering.\n\nBy doing so, you can increase your sales & build relationships with customers who may have otherwise been lost.',
      img: 'assets/images/landing_page/s3_mockup2.png',
    ),
    TextWidgetClass(
      h: 'Coupons, Cashbacks & Other Discounts',
      sh: 'You can generate a wide range of one-time, recurring, and diverse coupon types to reward your beloved customer\'s loyalty and appreciation.\n\nAdd enticing coupons, cashback offers, product discounts, and promotional banners to your store to reach out to potential customers and maximize your sales.\n\nThis feature allows you to show your customers how much you value them, while also providing them with exclusive discounts and offers.',
      img: 'assets/images/landing_page/s3_mockup3.png',
    ),
    TextWidgetClass(
      h: 'Affiliate Marketing',
      sh: 'Help your customers to earn commissions by selling your products through affiliate program. They will receive a commissionable amount on each sale made through their affiliate link.\n\nThis mutually beneficial arrangement will lead to increased profits for both you and your customers, creating a win-win situation.\n\nBy leveraging the power of affiliate marketing, you can maximize your profits while providing your customers with an opportunity to earn money.',
      img: 'assets/images/landing_page/s3_mockup4.png',
    ),
  ];
  List<TextWidgetClass> forthWidgetTexts = [
    TextWidgetClass(
      h: 'Get in touch',
      sh: 'Have questions or want to get a free demo? Contact us today to reserve your spot!',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      _isPageScrolled = _scrollController.offset > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width - 16;
    var isSmallScreen = true;
    if (sw > 800) {
      isSmallScreen = false;
    }

    var navBarItems = [
      if (!isSmallScreen) ...[
        Container(
          height: 60,
          width: 120,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyFormPage(),
                ),
              );
              // do something when the button is tapped
            },
            child: const Text(
              'Feedback',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
      Container(
        height: 50,
        alignment: Alignment.center,
        width: 120,
        margin: const EdgeInsets.symmetric(vertical: 3.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: gradientButtonWidget(btnText: getLoginText = getLoginText),
        ),
      ),
      if (isSmallScreen)
        Builder(
          builder: (BuildContext context) {
            return Container(
              height: 60,
              width: 55,
              margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB545FF), Color(0xFF7066FB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                  // do something when the button is tapped
                },
                child: const Icon(Icons.menu),
              ),
            );
          },
        ),
      const SizedBox(
        width: 5,
      ),
    ];

    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffF3F9FB),
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const <Widget>[
                TextButton(onPressed: null, child: Text('Features')),
                TextButton(onPressed: null, child: Text('Anmelden'))
              ],
            ),
          ),
          appBar: AppBar(
            scrolledUnderElevation: 1,
            toolbarHeight: 75,
            elevation: 0,
            backgroundColor:
                !_isPageScrolled ? const Color(0xffF3F9FB) : Colors.white,
            title: Image.asset(
              'assets/images/logo.png',
              height: 45.0,
            ),
            actions: navBarItems,
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // first Widget
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 35.0, horizontal: 8.0),
                  child: PageSectionWidget(
                      sw: sw * .98,
                      isSmallScreen: isSmallScreen,
                      heading: firstWidgetTexts[0],
                      showButtons: true),
                ),
                // second Widget
                Container(
                    padding: const EdgeInsets.fromLTRB(8, 35, 8, 15),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const HeadingTextWidget(
                            text: 'Get started in just 3 easy steps'),
                        isSmallScreen
                            ? const SizedBox()
                            : const SizedBox(
                                height: 30,
                                width: 20,
                              ),
                        isSmallScreen
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 40, 0, 0),
                                      width: sw,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Stack(children: [
                                          Image.asset(
                                              'assets/images/landing_page/mockup1.png'),
                                          Positioned(
                                            bottom: 20,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                                child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 16, 16, 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffB545FF),
                                                    Color(0xff7066FB),
                                                  ],
                                                  stops: [
                                                    0.1196,
                                                    .894,
                                                  ],
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    secondWidgetTexts[0].h,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    secondWidgetTexts[0].sh,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ]),
                                      )),
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
                                      width: sw,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Stack(children: [
                                          Image.asset(
                                              'assets/images/landing_page/mockup1.png'),
                                          Positioned(
                                            bottom: 20,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                                child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 16, 16, 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffB545FF),
                                                    Color(0xff7066FB),
                                                  ],
                                                  stops: [
                                                    0.1196,
                                                    .894,
                                                  ],
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    secondWidgetTexts[1].h,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    secondWidgetTexts[1].sh,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ]),
                                      )),
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
                                      width: sw,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Stack(children: [
                                          Image.asset(
                                              'assets/images/landing_page/mockup1.png'),
                                          Positioned(
                                            bottom: 20,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                                child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 16, 16, 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffB545FF),
                                                    Color(0xff7066FB),
                                                  ],
                                                  stops: [
                                                    0.1196,
                                                    .894,
                                                  ],
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    secondWidgetTexts[2].h,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    secondWidgetTexts[2].sh,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ]),
                                      )),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 40, 0, 0),
                                      width: (sw / 3) - 20,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Stack(children: [
                                          Image.asset(
                                              'assets/images/landing_page/mockup1.png'),
                                          Positioned(
                                            bottom: 20,
                                            left: 0,
                                            child: Center(
                                                child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 16, 16, 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffB545FF),
                                                    Color(0xff7066FB),
                                                  ],
                                                  stops: [
                                                    0.1196,
                                                    .894,
                                                  ],
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    'Step #1',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Create and name your store',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ]),
                                      )),
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 40),
                                      width: (sw / 3) - 20,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Stack(children: [
                                          Image.asset(
                                              'assets/images/landing_page/mockup1.png'),
                                          Positioned(
                                            bottom: 20,
                                            left: 5,
                                            right: 5,
                                            child: Center(
                                                child: Container(
                                              // height: 60,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 16, 16, 16),
                                              // width: 160,
                                              // margin: EdgeInsets.only(bottom: 23, left: 115),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffB545FF),
                                                    Color(0xff7066FB),
                                                  ],
                                                  stops: [
                                                    0.1196,
                                                    .894,
                                                  ],
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    secondWidgetTexts[1].h,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    secondWidgetTexts[1].sh,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ]),
                                      )),
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 40, 0, 0),
                                      width: (sw / 3) - 20,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Stack(children: [
                                          Image.asset(
                                              'assets/images/landing_page/mockup1.png'),
                                          Positioned(
                                            bottom: 20,
                                            right: 0,
                                            child: Center(
                                                child: Container(
                                              // height: 60,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 16, 16, 16),
                                              // width: 160,
                                              // margin: EdgeInsets.only(bottom: 23, left: 115),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffB545FF),
                                                    Color(0xff7066FB),
                                                  ],
                                                  stops: [
                                                    0.1196,
                                                    .894,
                                                  ],
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    secondWidgetTexts[2].h,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    secondWidgetTexts[2].sh,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ]),
                                      )),
                                ],
                              ),
                      ],
                    )),
                // third widget
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 35, 16, 15),
                  child: SizedBox(
                    width: sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextSectionWidget(
                          heading: thirdWidgetTexts[0],
                          ss: true,
                          h: 5,
                          showButtons: false,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        for (var i = 1; i < thirdWidgetTexts.length; i++)
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: isSmallScreen ? 10 : 0),
                              child: PageSectionWidget(
                                sw: sw,
                                isSmallScreen: isSmallScreen,
                                heading: thirdWidgetTexts[i],
                                isReverse: i.isOdd,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // forth widget
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 35.0),
                  color: Colors.white,
                  width: sw,
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    width: sw * .89,
                    height: (sw * .89) / (1170 / 293) < 293
                        ? 290
                        : (sw * .89) / (1170 / 293),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: AssetImage(
                            'assets/images/landing_page/section4_bg.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: SizedBox(
                      width: sw * .89,
                      height: (sw * .89) / (1170 / 293) < 293
                          ? 250
                          : (sw * .89) / (1170 / 293),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: TextSectionWidget(
                          heading: forthWidgetTexts[0],
                          showButtons: true,
                          isForthWidget: true,
                          h: 10,
                          showBlackButton: false,
                        ),
                      ),
                    ),
                  ),
                ),
                // fifth widget - footer
                SizedBox(width: sw, child: const FooterWidget())
              ],
            ),
          )),
    );
  }
}

class PageSectionWidget extends StatelessWidget {
  const PageSectionWidget(
      {super.key,
      required this.sw,
      required this.heading,
      this.isReverse = false,
      this.isSmallScreen = false,
      this.showBlackButton = true,
      this.showButtons = false});

  final double sw;
  final bool isReverse;
  final bool isSmallScreen;
  final bool showButtons;
  final bool showBlackButton;
  final TextWidgetClass heading;

  @override
  Widget build(BuildContext context) {
    return isSmallScreen
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                width: sw,
                child: Container(
                    alignment: Alignment.center,
                    child: ImageSectionWidget(img: heading.img)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                width: sw,
                child: TextSectionWidget(
                    ss: isSmallScreen,
                    heading: heading,
                    showButtons: showButtons,
                    showBlackButton: showBlackButton),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: !isReverse
                ? null
                : TextDirection
                    .rtl, // add this line to reverse the order of children

            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                width: sw / 2.1,
                child: TextSectionWidget(
                    heading: heading,
                    showButtons: showButtons,
                    showBlackButton: showBlackButton),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: sw / 2.1,
                child: ImageSectionWidget(img: heading.img),
              ),
            ],
          );
  }
}

class TextSectionWidget extends StatelessWidget {
  bool ss, showButtons, showBlackButton;
  bool isForthWidget;
  double h;

  TextSectionWidget(
      {super.key,
      required this.heading,
      this.ss = false,
      this.isForthWidget = false,
      this.h = 15,
      this.showBlackButton = true,
      this.showButtons = true});

  final TextWidgetClass heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          ss ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        HeadingTextWidget(text: heading.h, isForthWidget: isForthWidget),
        if (heading.h1.isNotEmpty) HeadingTextWidget(text: heading.h1),
        SizedBox(
          height: h,
          width: 20,
        ),
        Text(
          heading.sh,
          // textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: isForthWidget
                  ? const Color(0xffAFCBD4)
                  : const Color(0xff69767A),
              fontSize: 17),
        ),
        if (heading.sh1.isNotEmpty)
          Text(
            heading.sh1,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xff69767A),
                fontSize: 19),
          ),
        SizedBox(
          height: h,
          width: 20,
        ),
        if (showButtons) ...[
          Row(
            mainAxisAlignment:
                ss ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              gradientButtonWidget(
                btnText: isForthWidget ? contactUsText : getStartedText,
              ),
              if (showBlackButton)
                const SizedBox(
                  height: 20,
                  width: 15,
                ),
              if (showBlackButton)
                gradientButtonWidget(isBlack: true, btnText: viewDemoText),
            ],
          ),
        ]
      ],
    );
  }
}

class ImageSectionWidget extends StatelessWidget {
  const ImageSectionWidget({super.key, this.img});
  final img;

  @override
  Widget build(BuildContext context) {
    return Image.asset(img);
  }
}

class HeadingTextWidget extends StatelessWidget {
  const HeadingTextWidget({
    super.key,
    required this.text,
    this.isForthWidget = false,
  });

  final String text;
  final bool isForthWidget;
  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;

    return Text(
      text,
      style: TextStyle(
          fontSize: sw > 1000
              ? 31
              : sw > 800
                  ? 29
                  : sw > 600
                      ? 27
                      : sw > 400
                          ? 25
                          : 23,
          fontWeight: FontWeight.bold,
          color: isForthWidget ? Colors.white : null),
    );
  }
}

class gradientButtonWidget extends StatefulWidget {
  bool isBlack;
  final btnText;
  gradientButtonWidget({Key? key, this.isBlack = false, required this.btnText})
      : super(key: key);

  @override
  _gradientButtonWidgetState createState() => _gradientButtonWidgetState();
}

class _gradientButtonWidgetState extends State<gradientButtonWidget> {
  bool _colorChanged = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (PointerEnterEvent event) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              _colorChanged = true;
            });
          }
        });
        setState(() {});
      },
      onExit: (PointerExitEvent event) {
        setState(() {
          _colorChanged = false;
        });
      },
      child: Container(
        height: 50,
        width: 120,
        margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: widget.isBlack
              ? const LinearGradient(
                  colors: [Colors.black, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : _colorChanged
                  ? const LinearGradient(
                      colors: [Color(0xFF7066FB), Color(0xFFB545FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                      colors: [Color(0xFFB545FF), Color(0xFF7066FB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: GestureDetector(
          onTap: () {
            if (widget.btnText == "Get Started") {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateAccount(),
                ),
              );
            } else if (widget.btnText == "Anmelden") {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }
            // do something when the button is tapped
          },
          child: Container(
            child: Text(
              widget.btnText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FooterItemsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;

  const FooterItemsWidget({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var data in dataList)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: Text(
                    data['heading'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                for (var textData in data['texts'])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        textData['name'],
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff69767A),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
