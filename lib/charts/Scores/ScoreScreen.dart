import 'package:fl_chart/fl_chart.dart';
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

  @override
  void initState() {
    super.initState();
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
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget bodyWidget(ScoreModel data) {
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
