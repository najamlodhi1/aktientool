import 'package:aktientool/filter/industry.dart';
import 'package:aktientool/filter/marketcap.dart';
import 'package:aktientool/filter/searcharea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../authentication/services/request_service.dart';
import '../charts/allCharts.dart';
import '../charts/chart13/createchart.dart';
import '../settings/app_localizations.dart';
import 'country.dart';

class Filter extends ConsumerWidget {
  Filter({super.key});
  bool isShowCalender = false;
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    trans = AppLocalizations.of(context);

    return Scaffold(
        backgroundColor: Colors.black,
        appBar:
            AppBar(title: const Text('Filter'), backgroundColor: Colors.black),
        body: SingleChildScrollView(
            child: Column(children: [
          Marketcap(),
          SizedBox(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      trans.translate('Countries'),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Alle",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountrySelect()));
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      trans.translate('Industry'),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Alle",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndustrySelect(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                        title: Text(
                          trans.translate('IPO'),
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          trans.translate("Calender"),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          if (requestsLeft > 0) {
                            RequestService().updateRequests();
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const CreateChart13(null)))
                                .then((value) {
                              if (requestsLeft == 0) {
                                upgradepopup(context);
                              }
                            });
                          } else {
                            upgradepopup(context);
                          }
                        })
                  ])))
        ])));
  }
}
