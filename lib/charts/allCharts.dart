// ignore_for_file: file_names
import 'package:aktientool/charts/chart2/createchart.dart';
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chart1/createchart.dart';
import 'chart3/createchart.dart';
import 'chart4/createchart.dart';
import 'chart5/createchart.dart';
import 'chart6/createchart.dart';
import 'chart7/createchart.dart';
import 'chart8/createchart.dart';
import 'chart9/createchart.dart';

class AllCharts extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            //CreateChart0(),
            CreateChart1(),
            CreateChart2(),
            CreateChart3(),
            CreateChart4(),
            CreateChart5(),
            CreateChart6(),
            CreateChart7(),
            CreateChart8(),
            CreateChart9(),
            //    CreateChart10(),
          ],
        ),
      ),
    );
  }
}
