// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var sp_marketcap_start = StateProvider((ref) {
  return 0;
});
var sp_marketcap_end = StateProvider((ref) {
  return 2500;
});
var sp_marketcap_start_temp = StateProvider((ref) {
  return 0;
});
var sp_marketcap_end_temp = StateProvider((ref) {
  return 2500;
});
var chk_marketcap = StateProvider((ref) {
  return true;
});

// ignore: must_be_immutable
class Marketcap extends ConsumerWidget {
  List<Map> generatedCountrieFromList = [];
  var icon = Icons.search;
  Timer? timerMarketCap;

  Marketcap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var intMarketcapStart = ref.watch(sp_marketcap_start);
    var intMarketcapEnd = ref.watch(sp_marketcap_end);
    var intMarketcapStartTemp = ref.watch(sp_marketcap_start_temp);
    var intMarketcapEndTemp = ref.watch(sp_marketcap_end_temp);
    var chkMarketcap = ref.watch(chk_marketcap);

    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ExpansionTile(
              title: const Text("Marketcap in Billion:",
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                "${(intMarketcapStart / 1).toStringAsFixed(0)}B   to ${(intMarketcapEnd / 1).toStringAsFixed(0)}B",
                style: const TextStyle(color: Colors.blue),
              ),
              childrenPadding: const EdgeInsets.only(left: 16, right: 16),
              // Contents
              children: [
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      side: const BorderSide(width: 2, color: Colors.white),
                      value: chkMarketcap,
                      onChanged: (bool? value) {
                        ref.read(chk_marketcap.state).state = value!;
                        if (value) {
                          ref.read(sp_marketcap_start.state).state = 0;
                          ref.read(sp_marketcap_end.state).state = 2500;
                        } else {
                          ref.read(sp_marketcap_start.state).state = 0;
                          ref.read(sp_marketcap_end.state).state = 2500;
                        }
                      },
                    ),
                    const Text(
                      "Market Cap",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                chkMarketcap
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "0",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "250B",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "500B",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "750B",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "2500B",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RangeSlider(
                            min: 0, //2449068320102
                            max: 2500, //2500000000000
                            values: RangeValues(
                                intMarketcapStartTemp.toDouble(),
                                intMarketcapEndTemp.toDouble()),
                            onChanged: (values) {
                              ref.read(sp_marketcap_start_temp.state).state =
                                  values.start.toInt();
                              ref.read(sp_marketcap_end_temp.state).state =
                                  values.end.toInt();

                              if (timerMarketCap != null) {
                                timerMarketCap!.cancel();
                              }

                              timerMarketCap =
                                  Timer(const Duration(milliseconds: 100), () {
                                ref.read(sp_marketcap_start.state).state =
                                    values.start.toInt();
                                ref.read(sp_marketcap_end.state).state =
                                    values.end.toInt();
                              });
                            },
                          )
                        ],
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
