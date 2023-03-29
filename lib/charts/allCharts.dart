// ignore_for_file: file_names
import 'dart:convert';
import 'package:aktientool/authentication/services/http_service.dart';
import 'package:aktientool/charts/Consensus/ConcensusScreen.dart';
import 'package:aktientool/charts/Scores/ScoreScreen.dart';
import 'package:aktientool/charts/StockNews/StockNewsScreen.dart';
import 'package:aktientool/charts/chart2/BarChartIncomeScreen.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:aktientool/webpage/components/footer.dart';
import 'package:flutter/material.dart';
import '../settings/app_localizations.dart';
import 'DCFLevered/DCFLeveredScreen.dart';
import 'InstitutionalHolders/InstitutionalholdersScreen.dart';
import 'chart0/createchart.dart';
import 'chart11/createchart.dart';
import 'chart12/CompanyScreen.dart';
import 'chart1test/createchart.dart';
import 'chart2/createchart.dart';
import 'chart3/BarChartBalanceScreen.dart';
import 'chart3/createchart.dart';
import 'chart4/BarChartCashFlowScreen.dart';

dynamic parentData;

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
  late Future getFuture;

  @override
  void initState() {
    super.initState();
    getFuture = getalldata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Colors.white),
        title: Text(ShowCompanies.companyname),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              parentData = jsonDecode(snapshot.data.body);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CreateChart0(parentData[0]), // Info
                    // CreateChart13(parentData[3]),
                    CreateChart1Test(parentData[4]), // Chart
                    CreateChart11(parentData[1]), // Performance
                    Institutionalholders(parentData[9]),
                    CompanyScreen(parentData[2]), // Dividend History
                    ScoreScreen(parentData[10]),
                    BarChartIncomeScreen(parentData[5]), // Bar Chart income
                    CreateChart2(parentData[5]),
                    BarChartBalanceScreen(parentData[6]), // Bar Chart Balance
                    CreateChart3(parentData[6]),
                    BarChartCashFlowScreen(parentData[7]),
                    DCFLeveredScreen(parentData[12]),
                    ConcensusScreen(parentData[8]),
                    StockNewsScreen(parentData[11]),
                    Footer()
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
