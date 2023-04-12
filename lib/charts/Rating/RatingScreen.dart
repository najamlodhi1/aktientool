import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:aktientool/models/RatingModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../settings/app_localizations.dart';
import 'RatingService.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late Future<RatingModel?> getFuture;
  bool iseditable = true;
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    getFuture = RatingService().getData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    trans = AppLocalizations.of(context);

    return FutureBuilder<RatingModel?>(
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

  Widget bodyWidget(RatingModel data) {
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
            child: Text(trans.translate('Databased Rating'),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white)),
          ),
          const Divider(height: 10, thickness: 1),
          Wrap(
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                customTextWidget('ROE', data.ratingDetailsROERecommendation),
                const Divider(),
                customTextWidget('ROA', data.ratingDetailsROARecommendation),
                const Divider(),
                customTextWidget(
                    'Operating Margin', data.ratingDetailsDCFRecommendation),
                const Divider(),
                customTextWidget(
                    'Debt / Equity', data.ratingDetailsDERecommendation),
                const Divider(),
                customTextWidget('P/E', data.ratingDetailsPERecommendation),
                const Divider(),
                customTextWidget('P/B', data.ratingDetailsPBRecommendation),
                const Divider()
              ]),
              customCellRow(data.ratingRecommendation)
            ],
          )
        ],
      ),
    );
  }

  Widget customTextWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white)),
          Text(value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: (value == 'Strong Sell'
                    ? Colors.red
                    : value == 'Sell'
                        ? Colors.orange
                        : value == 'Neutral'
                            ? Colors.yellow
                            : value == 'Buy'
                                ? Colors.lightGreen
                                : value == 'Strong Buy'
                                    ? Colors.green
                                    : Colors.white),
              ))
        ],
      ),
    );
  }

  Widget customCellRow(String consensus) {
    return Column(
      children: [
        Container(
          height: 170,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCell('Strong Sell', consensus),
              customCell('Sell', consensus),
              customCell('Neutral', consensus),
              customCell('Buy', consensus),
              customCell('Strong Buy', consensus)
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
            color: title == 'Strong Sell'
                ? Colors.red
                : title == 'Sell'
                    ? Colors.orange
                    : title == 'Neutral'
                        ? Colors.yellow
                        : title == 'Buy'
                            ? Colors.lightGreen
                            : title == 'Strong Buy'
                                ? Colors.green
                                : Colors.green,
            child: Center(
                child: Text(trans.translate(title),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16))),
          ),
        ),
      ],
    ));
  }
}
