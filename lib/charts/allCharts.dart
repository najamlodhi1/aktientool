// ignore_for_file: file_names
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'chart1test/createchart.dart';
import 'chart2/createchart.dart';

class AllCharts extends StatefulWidget {
  const AllCharts({super.key});

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
            //const CreateChart0(), // Info
            CreateChart1Test(), // Chart

            //const CreateChart11(), // Performance
            //const CreateChart12(), // Dividend History
            CreateChart2(),
            //CreateChart3(),
            //CreateChart4(),
            /*CreateChart5(),
            CreateChart6(),
            CreateChart7(),
            CreateChart8(),
            CreateChart9(),
            CreateChart10(),
*/
          ],
        ),
      ),
    );
  }
}
