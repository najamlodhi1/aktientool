// ignore_for_file: file_names
import 'package:aktientool/stockscreener/showCompanies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chart0/createchart.dart';

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
            CreateChart0(),

            /*
            CreateChart1(),
            CreateChart2(),
            CreateChart3(),
            CreateChart4(),
            CreateChart5(),
            CreateChart6(),
            CreateChart7(),
            CreateChart8(),
            CreateChart9(),
            */
          ],
        ),
      ),
    );
  }
}
