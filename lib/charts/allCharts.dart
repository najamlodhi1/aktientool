// ignore_for_file: file_names
import 'package:aktientool/charts/chart1test/CustomBarChart/BarChartScreen.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'chart0/createchart.dart';
import 'chart10/createchart.dart';
import 'chart11/createchart.dart';
import 'chart12/createchart.dart';
import 'chart1test/createchart.dart';
import 'chart2/createchart.dart';
import 'chart3/createchart.dart';
import 'chart4/createchart.dart';
import 'chart5/createchart.dart';
import 'chart6/createchart.dart';
import 'chart7/createchart.dart';
import 'chart8/createchart.dart';
import 'chart9/createchart.dart';

class AllCharts extends StatefulWidget {
  const AllCharts({super.key});
  checkPopup(context) {
    return AlertDialog(
      title: const Text('Payment Cancelled'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CreateChart0(), // Info
            CreateChart1Test(), // Chart
            const CreateChart11(), // Performance
            const CreateChart12(), // Dividend History
            BarChartScreen(), // Bar Chart of cost and revenue
            CreateChart2(),
            CreateChart3(),
            CreateChart4(),
            CreateChart5(),
            CreateChart6(),
            CreateChart7(),
            CreateChart8(),
            CreateChart9(),
            CreateChart10(),
/**/
          ],
        ),
      ),
    );
  }
}
