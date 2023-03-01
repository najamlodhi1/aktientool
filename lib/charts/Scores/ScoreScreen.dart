// ignore_for_file: file_names

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
      children: [progressbar(data)],
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
              'Risikobewertung',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            PhysicalModel(
              elevation: 5,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Piotroski F-Score',
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
                                        color: Color.fromARGB(255, 0, 0, 0),
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
                        '',
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
              color: Colors.white,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Altman Z-Score',
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
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 40),
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
                        '',
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
}
