import 'dart:io';

import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/charts/chart1test/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:screenshot/screenshot.dart';

class CreateChart1Test extends StatefulWidget {
  const CreateChart1Test(this.data, {super.key});
  final dynamic data;
  @override
  State<CreateChart1Test> createState() => CreateChart1TestState();
}

class CreateChart1TestState extends State<CreateChart1Test> {
  ScreenshotController screenshotController = ScreenshotController();
  List<FlSpot> getFLData = [];
  int buttonIndex = 3;
  late Future getfuture;
  var selectedDate = DateTime.now();
  int anzeige = 2;
  bool drawLine = false;
  Uint8List? imageFile;
// create some values
  Color pickerColor = Colors.green;
  Color currentColor = Colors.green;
  List<DrawLineModel> offsets = [];

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  final List<Color> color = [
    const Color(0xFF6FFF7C),
    const Color(0xFF0087FF),
    const Color(0xFF5620FF)
  ];

  @override
  void initState() {
    getfuture = RemoteService().getData(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: getFLData.isNotEmpty ? [] : null,
      future: getfuture,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return showChart();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  btn() {
    return SizedBox(
      child: Wrap(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background
              ),
              onPressed: () {
                setState(() {
                  getFLData = flchartData1;
                  buttonIndex = 0;
                });
              },
              child: const Text("1 y")),
          const SizedBox(width: 5),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background
              ),
              onPressed: () {
                setState(() {
                  getFLData = flchartData3;
                  buttonIndex = 1;
                });
              },
              child: const Text("3 y")),
          const SizedBox(width: 5),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background
              ),
              onPressed: () {
                setState(() {
                  getFLData = flchartData5;
                  buttonIndex = 2;
                });
              },
              child: const Text("5 y")),
          const SizedBox(width: 5),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // background
            ),
            onPressed: () {
              setState(() {
                getFLData = flchartData10;
                buttonIndex = 3;
              });
            },
            child: const Text("10 y"),
          ),
          const SizedBox(width: 5),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // background
            ),
            onPressed: () {
              setState(() {
                getFLData = flchartDataMax;
                buttonIndex = 4;
              });
            },
            child: const Text("Max"),
          ),

          //
        ],
      ),
    );
  }

  double calculateDateTitlesInterval(int btnIndex) {
    int maxScreenWidth = 1200;
    switch (btnIndex) {
      // 1 y
      case 0:
        return maxScreenWidth / MediaQuery.of(context).size.width * 30;
      // 3 y
      case 1:
        return maxScreenWidth / MediaQuery.of(context).size.width * 45;
      // 5 y
      case 2:
        return maxScreenWidth / MediaQuery.of(context).size.width * 80;
      // Max
      case 4:
        return maxScreenWidth / MediaQuery.of(context).size.width * 600;
      // 10 y
      default:
        return maxScreenWidth / MediaQuery.of(context).size.width * 150;
    }
  }

  flc() {
    if (getFLData.isEmpty) {
      getFLData = flchartData10;
    }

    return GestureDetector(
      onPanStart: !drawLine
          ? null
          : (details) {
              setState(() {
                offsets.add(DrawLineModel(
                    start: details.localPosition,
                    end: details.localPosition,
                    color: currentColor));
              });
            },
      onPanUpdate: !drawLine
          ? null
          : (details) {
              setState(() {
                offsets.last.end = details.localPosition;
              });
            },
      child: AspectRatio(
        aspectRatio: 16 / 6,
        child: Center(
          child: Stack(
            children: [
              Screenshot(
                controller: screenshotController,
                child: (imageFile != null && drawLine == true)
                    ? Image.memory(imageFile!)
                    : LineChart(
                        LineChartData(
                          lineTouchData: drawLine
                              ? null
                              : LineTouchData(
                                  touchTooltipData: LineTouchTooltipData(
                                  fitInsideHorizontally: true,
                                  fitInsideVertically: true,
                                  getTooltipItems: (touchedSpots) {
                                    return touchedSpots
                                        .map((LineBarSpot touchedSpot) {
                                      final textStyle = TextStyle(
                                        color: touchedSpot
                                                .bar.gradient?.colors[0] ??
                                            touchedSpot.bar.color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      );

                                      String stockDate =
                                          chartDataMax[touchedSpot.x.toInt()]
                                              .year
                                              .toString()
                                              .substring(0, 10);

                                      return LineTooltipItem(
                                          '${touchedSpot.y}\n$stockDate',
                                          textStyle);
                                    }).toList();
                                  },
                                )),
                          lineBarsData: [
                            LineChartBarData(
                              spots: getFLData
                                  .map((point) => FlSpot(point.x, point.y))
                                  .toList(),
                              color: Colors.white,
                              barWidth: 2,
                              dotData: FlDotData(show: false),
                            ),
                          ],
                          borderData: FlBorderData(
                              border: const Border(
                                  bottom: BorderSide(), left: BorderSide())),
                          backgroundColor: primaryColor,
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 25,
                                interval:
                                    calculateDateTitlesInterval(buttonIndex),
                                getTitlesWidget: (value, meta) {
                                  if (value == meta.min || value == meta.max) {
                                    return const Text("");
                                  }
                                  String date = chartDataMax[value.toInt()]
                                      .year
                                      .toString()
                                      .substring(0, 7);
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      date,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                        ),
                      ),
              ),
              if (drawLine)
                ...List.generate(
                    offsets.length,
                    (index) => CustomPaint(
                        painter: LinePainter(offsets[index].start,
                            offsets[index].end, offsets[index].color),
                        child: GestureDetector(onTap: () {
                          setState(() {
                            offsets.removeAt(index);
                          });
                        }))),
            ],
          ),
        ),
      ),
    );
  }

  showChart() {
    String todayPrice =
        flchartData1[flchartData1.length - 1].toString().replaceAll(")", "");
    int x = todayPrice.indexOf(" ");
    String todayPriceFinal = todayPrice.substring(x);

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
          style: BorderStyle.none,
          width: 2,
        ),
        color: primaryColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(),
              const Spacer(),
              Text(
                todayPriceFinal,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: 50,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      ImageCache().clear();
                      setState(() {
                        offsets = [];
                      });
                    },
                    child: const Icon(Icons.clear, color: Colors.white)),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 50,
                width: 50,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: currentColor),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: changeColor,
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Save'),
                                  onPressed: () {
                                    setState(() => currentColor = pickerColor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: const Icon(Icons.color_lens, color: Colors.white)),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 50,
                width: 50,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: drawLine ? currentColor : Colors.grey),
                    onPressed: () {
                      setState(() {
                        ImageCache().clear();
                        drawLine = !drawLine;
                        if (drawLine && imageFile == null) {
                          screenshotController
                              .capture(pixelRatio: 1)
                              .then((image) {
                            setState(() {
                              imageFile = image!;
                            });
                          });
                        }
                      });
                    },
                    child: const Icon(Icons.line_axis, color: Colors.white)),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: flc(),
          ),
          const SizedBox(
            height: 20,
          ),
          btn(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class DrawLineModel {
  Offset start;
  Offset end;
  Color color;
  DrawLineModel(
      {this.start = Offset.zero, this.end = Offset.zero, required this.color});
}

class LinePainter extends CustomPainter {
  final Offset startingPoint;
  final Offset endingPoint;
  final Color color;

  LinePainter(this.startingPoint, this.endingPoint, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;
    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
