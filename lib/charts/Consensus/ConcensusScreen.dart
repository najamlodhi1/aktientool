import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import 'ConcensusModel.dart';
import 'ConcensusService.dart';

class ConcensusScreen extends StatefulWidget {
  const ConcensusScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<ConcensusScreen> createState() => _ConcensusScreenState();
}

class _ConcensusScreenState extends State<ConcensusScreen> {
  late Future<ConcensusModel?> getFuture;
  bool iseditable = true;
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    getFuture = ConcensusService().getData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);

    return FutureBuilder<ConcensusModel?>(
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

  Widget bodyWidget(ConcensusModel data) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text(trans.translate('Analyst Rating'),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white)),
          ),
          const Divider(height: 10, thickness: 1),
          Wrap(
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                customTextWidget('Strong Buy', data.strongBuy),
                const Divider(),
                customTextWidget('Moderate Buy', data.buy),
                const Divider(),
                customTextWidget('Hold', data.hold),
                const Divider(),
                customTextWidget('Moderate Sell', data.sell),
                const Divider(),
                customTextWidget('Strong Sell', data.strongSell),
                const Divider(),
              ]),
              customCellRow(data.consensus.toLowerCase())
            ],
          )
        ],
      ),
    );
  }

  Widget customTextWidget(String title, int value) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(trans.translate(title),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white)),
          Text(value.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white))
        ],
      ),
    );
  }

  Widget customCellRow(String consensus) {
    return Column(
      children: [
        /*
          Container(
            height: 120,
            margin: const EdgeInsets.all(15),
            color: consensus == 'strongSell'
                ? Colors.red
                : consensus == 'sell'
                    ? Colors.orange
                    : consensus == 'hold'
                        ? Colors.yellow
                        : consensus == 'buy'
                            ? Colors.lightGreen
                            : consensus == 'strongBuy'
                                ? Colors.green
                                : Colors.green,
            child: Center(
                child: Text(
                    consensus == 'strongSell'
                        ? 'Strong Sell'
                        : consensus == 'sell'
                            ? 'Moderate Sell'
                            : consensus == 'hold'
                                ? 'Hold'
                                : consensus == 'buy'
                                    ? 'Moderate Buy'
                                    : consensus == 'strongBuy'
                                        ? 'Strong buy'
                                        : '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.white))),
          ),

          */
        Container(
          height: 170,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCell('strongSell', consensus),
              customCell('sell', consensus),
              customCell('hold', consensus),
              customCell('buy', consensus),
              customCell('strongBuy', consensus)
            ],
          ),
        ),
      ],
    );
  }

  Widget customCell(String title, String concensus) {
    return Expanded(
        child: Column(
      children: [
        Expanded(
            child: title == concensus
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(trans.translate('Current'),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                      const Icon(
                        CupertinoIcons.arrowtriangle_down_fill,
                        size: 35,
                        color: Colors.white,
                      )
                    ],
                  )
                : Container()),
        Expanded(
          child: Container(
            color: title == 'strongSell'
                ? Colors.red
                : title == 'sell'
                    ? Colors.orange
                    : title == 'hold'
                        ? Colors.yellow
                        : title == 'buy'
                            ? Colors.lightGreen
                            : title == 'strongBuy'
                                ? Colors.green
                                : Colors.green,
            child: Center(
                child: Text(
                    trans.translate(title == 'strongSell'
                        ? 'Strong Sell'
                        : title == 'sell'
                            ? 'Moderate Sell'
                            : title == 'hold'
                                ? 'Hold'
                                : title == 'buy'
                                    ? 'Moderate Buy'
                                    : title == 'strongBuy'
                                        ? 'Strong Buy'
                                        : ''),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16))),
          ),
        ),
      ],
    ));
  }
}
