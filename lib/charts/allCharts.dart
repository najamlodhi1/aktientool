// ignore_for_file: file_names
import 'dart:convert';
import 'package:aktientool/authentication/services/http_service.dart';
import 'package:aktientool/charts/Consensus/ConcensusScreen.dart';
import 'package:aktientool/charts/Rating/RatingScreen.dart';
import 'package:aktientool/charts/Scores/ScoreScreen.dart';
import 'package:aktientool/charts/StockNews/StockNewsScreen.dart';
import 'package:aktientool/charts/chart2/BarChartIncomeScreen.dart';
import 'package:aktientool/charts/chart4/createchart.dart';
import 'package:aktientool/stockscreener/home.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authentication/services/request_service.dart';
import '../filter/filter.dart';
import '../filter/searcharea.dart';
import '../settings/app_localizations.dart';
import '../settings/settings.dart';
import '../webpage/footer.dart';
import 'DCFLevered/DCFLeveredScreen.dart';
import 'Insider/InsiderScreen.dart';
import 'InstitutionalHolders/InstitutionalholdersScreen.dart';
import 'chart0/createchart.dart';
import 'chart11/createchart.dart';
import 'chart12/CompanyScreen.dart';
import 'chart1test/createchart.dart';
import 'chart2/createchart.dart';
import 'chart3/BarChartBalanceScreen.dart';
import 'chart3/createchart.dart';
import 'chart4/BarChartCashFlowScreen.dart';
import 'ESGScore/ESGScoreScreen.dart';

List<DrawLineModel> drawingoffsets = [];
var newsData;

class AllCharts extends StatefulWidget {
  late AppLocalizations trans;
  AllCharts({super.key});
  checkPopup(context) {
    trans = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(trans.translate('Payment Cancelled')),
      actions: [
        TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }

  @override
  State<AllCharts> createState() => _AllChartsState();
}

class _AllChartsState extends State<AllCharts> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  dynamic parentData;
  int selectedindex = 9;
  List<dynamic> widgetData = [];

  List pages = [
    "Overview",
    "Evaluation",
    "Performance1",
    "Growth",
    "Health",
    "Dividend",
    "Management",
    "News"
  ];

  late AppLocalizations trans;
  Future? getFuture;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < pages.length + 2; i++) {
      widgetData.add(null);
    }
    drawingoffsets = [];
    newsData = null;
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      drawer: MediaQuery.of(context).size.width < 700
          ? Drawer(backgroundColor: Colors.grey, child: customDrawer())
          : null,
      body: Row(
        children: [
          MediaQuery.of(context).size.width > 700
              ? Container(width: 300, color: Colors.grey, child: customDrawer())
              : Container(),
          Expanded(
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              appBar: AppBar(
                backgroundColor: Colors.grey,
                leadingWidth: 200,
                actions: (FirebaseAuth.instance.currentUser == null)
                    ? null
                    : [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: ElevatedButton(
                            onPressed: () async {
                              upgradepopup(context);
                            },
                            child: StreamBuilder<int>(
                                stream: RequestService().getrequests(),
                                builder: (context, snapshot) {
                                  return Text(snapshot.hasData
                                      ? snapshot.data!.toString()
                                      : '0');
                                }),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Filter(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.filter_alt)),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Settings(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.settings))
                      ],
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (MediaQuery.of(context).size.width < 700)
                      IconButton(
                          onPressed: () {
                            scaffoldkey.currentState!.openDrawer();
                          },
                          icon: const Icon(Icons.menu)),
                    const BackButton(color: Colors.white),
                  ],
                ),
                title: Text(ShowCompanies.companyname),
                centerTitle: true,
              ),
              body: FutureBuilder(
                  future: getFuture,
                  builder: (context, snapshot) {
                    if (selectedindex == 9 &&
                        FirebaseAuth.instance.currentUser != null) {
                      return const Home();
                    } else if (getFuture == null) {
                      return Container();
                    } else if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      parentData = jsonDecode(snapshot.data);
                      widgetData[selectedindex] = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            if (selectedindex == 0) ...[
                              CreateChart0(parentData[0]), // Info
                              CreateChart1Test(parentData[1]), // Chart
                            ],
                            if (selectedindex == 1) ...[
                              ConcensusScreen(
                                  parentData[0]), // Analysten bewertung
                            ],
                            if (selectedindex == 2) ...[
                              CreateChart11(parentData[0]), // Performance
                            ],
                            if (selectedindex == 3) ...[
                              BarChartIncomeScreen(
                                  parentData[0]), // Bar Chart income
                              CreateChart2(parentData[0]),
                              BarChartBalanceScreen(
                                  parentData[1]), // Bar Chart Balance
                              CreateChart3(parentData[1]),
                              BarChartCashFlowScreen(parentData[2]),
                              CreateChart4(parentData[2])
                            ],
                            if (selectedindex == 4) ...[
                              Institutionalholders(parentData[0]),
                              ESGScoreScreen(parentData[4]),
                              InsiderScreen(parentData[3]),
                              RatingScreen(parentData[2]),
                              ScoreScreen(parentData[1]), // Risikobewertung
                            ],
                            if (selectedindex == 5) ...[
                              CompanyScreen(parentData[0]), // Dividend History
                            ],
                            if (selectedindex == 6) ...[
                              DCFLeveredScreen(parentData[0])
                            ],
                            if (selectedindex == 7) ...[
                              StockNewsScreen(parentData[0]),
                            ],
                            Footer()
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget customDrawer() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Image.asset("assets/images/logo.png", width: 150),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                selectedindex = 8;
              });
              if (MediaQuery.of(context).size.width < 700) {
                Navigator.pop(context);
              }
            },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("Set Filter",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedindex = 9;
              });
              if (MediaQuery.of(context).size.width < 700) {
                Navigator.pop(context);
              }
            },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("View Stocks",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ),
          ),
          ...List.generate(
              pages.length,
              (index) => InkWell(
                    onTap: () {
                      if (ShowCompanies.companysymbol.isEmpty &&
                          FirebaseAuth.instance.currentUser != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Select a company to continue")));
                      }
                      {
                        setState(() {
                          selectedindex = index;
                          if (selectedindex == 0) {
                            getFuture =
                                getdata(widgetData[selectedindex], 'overview');
                          } else if (selectedindex == 1) {
                            getFuture = getdata(
                                widgetData[selectedindex], 'evaluation');
                          } else if (selectedindex == 2) {
                            getFuture = getdata(
                                widgetData[selectedindex], 'performance');
                          } else if (selectedindex == 3) {
                            getFuture =
                                getdata(widgetData[selectedindex], 'growth');
                          } else if (selectedindex == 4) {
                            getFuture =
                                getdata(widgetData[selectedindex], 'health');
                          } else if (selectedindex == 5) {
                            getFuture =
                                getdata(widgetData[selectedindex], 'dividend');
                          } else if (selectedindex == 6) {
                            getFuture = getdata(
                                widgetData[selectedindex], 'management');
                          } else if (selectedindex == 7) {
                            getFuture =
                                getdata(widgetData[selectedindex], 'news');
                          }
                        });
                      }
                      if (MediaQuery.of(context).size.width < 700) {
                        Navigator.pop(context);
                      }
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(trans.translate(pages[index]),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white)),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
