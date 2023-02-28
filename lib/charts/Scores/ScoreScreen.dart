// ignore_for_file: file_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ScoreModel.dart';
import 'ScoreService.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late Future<ScoreModel> getFuture;
  int touchedIndex = -1;
  List labels = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i <= 9; i++) {
      labels.add(i);
    }
    getFuture = ScoreService().getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ScoreModel>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return bodyWidget(snapshot.data!);
          } else {
            //return const Center(child: CircularProgressIndicator());
            return const SizedBox();
          }
        });
  }

  Widget bodyWidget(ScoreModel data) {
    return Column(
      children: [carts(data), progressbar(data)],
    );
  }

  Widget progressbar(ScoreModel data) {
    return Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.teal,
            style: BorderStyle.none,
            width: 2,
          ),
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Risikoanalalyse',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            PhysicalModel(
              elevation: 5,
              color: Colors.grey.shade200,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Health trend: Piotroski F-Score',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${data.piotroskiScore.toStringAsFixed(0)} / 9',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.red,
                              Colors.yellow,
                              Colors.green,
                            ],
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                labels.length,
                                (index) => labels[index].toString() ==
                                        data.piotroskiScore.toStringAsFixed(0)
                                    ? const Icon(CupertinoIcons.arrow_down,
                                        size: 40)
                                    : Container())),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                labels.length,
                                (index) => Text(
                                      labels[index].toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Misst die Änderungen der Bilanzqualität. Geeignet für Value- & Turnaround-Aktien.',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 10),
            PhysicalModel(
              elevation: 5,
              color: Colors.grey.shade200,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Bankruptcy-Risk (Altman Z-Score)',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data.altmanZScore.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                      const SizedBox(height: 10),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.red,
                                Colors.red,
                                Colors.red,
                                Colors.black12,
                                Colors.black12,
                                Colors.green,
                                Colors.green,
                                Colors.green,
                                Colors.green,
                                Colors.green,
                                Colors.green,
                              ],
                            ),
                          ),
                          child: Align(
                            alignment: Alignment(data.altmanZScore / 12, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data.altmanZScore >= 4
                                      ? 'Safe  '
                                      : data.altmanZScore >= 2
                                          ? 'Caution  '
                                          : 'Distress  ',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(CupertinoIcons.arrow_down,
                                    color: Colors.blueGrey, size: 40),
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                labels.length,
                                (index) => Text(
                                      labels[index] == 1
                                          ? 'Distress'
                                          : labels[index] == 3
                                              ? 'Caution'
                                              : '       ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Ein Insolvenzprognoseverfahren das 3 Zustände einnehmen kann.',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }

  Widget carts(ScoreModel data) {
    double altmanZScorePercent = (data.altmanZScore / 9) * 100;
    double piotroskiScorePercent = (data.piotroskiScore / 9) * 100;
    return Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.teal,
            style: BorderStyle.none,
            width: 2,
          ),
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'AltmanZ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingAltmanzSections(data),
                        ),
                      ),
                    ),
                    Text(
                      '${data.altmanZScore.toStringAsFixed(2)} (${altmanZScorePercent.toStringAsFixed(2)}%)',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Piotroski',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingPiotroskiSections(data),
                        ),
                      ),
                    ),
                    Text(
                      '${data.piotroskiScore.toStringAsFixed(2)} (${piotroskiScorePercent.toStringAsFixed(2)}%)',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  List<PieChartSectionData> showingAltmanzSections(ScoreModel data) {
    final isTouched = 0 == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    return [
      PieChartSectionData(
        color: Colors.green,
        value: data.altmanZScore,
        title: '',
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        color: Colors.grey.shade200,
        value: (9 - data.altmanZScore),
        title: '',
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      )
    ];
  }

  List<PieChartSectionData> showingPiotroskiSections(ScoreModel data) {
    final isTouched = 0 == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    return [
      PieChartSectionData(
        color: Colors.purple,
        value: data.piotroskiScore,
        title: '',
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        color: Colors.grey.shade200,
        value: 9 - data.piotroskiScore,
        title: '',
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      )
    ];
  }
}

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.color, required this.text});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 25, width: 25, color: color),
        const SizedBox(width: 10),
        Text(text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
      ],
    );
  }
}
