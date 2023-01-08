// ignore_for_file: file_names
import 'package:aktientool/charts/chart2/createchart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllCharts extends ConsumerWidget {
  const AllCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Colors.white),
        title: const Text("Show Chart from Stock"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [CreateChart()],
        ),
      ),
    );
  }
}
