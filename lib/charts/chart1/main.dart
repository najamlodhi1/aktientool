import 'package:aktientool/charts/chart1/manager/network_manager.dart';
import 'package:aktientool/charts/chart1/screens/asset_details.dart';
import 'package:aktientool/charts/chart1/utilities/colors.dart';
import 'package:aktientool/charts/chart1/utilities/config.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/assets/assets.dart';

class ABC extends StatefulWidget {
  const ABC({super.key});

  @override
  _ABCState createState() => _ABCState();
}

class _ABCState extends State<ABC> {
  final _assets = NetworkManager.instance.getAssets();
  final _assets2 = NetworkManager.instance.getData("AAPL");
  @override
  void initState() {
    super.initState();

    themeNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: themeNotifier.currentTheme(),
      title: 'Basecoin',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: AppColors.marinerBlue,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        primaryColor: AppColors.marinerBlue,
        backgroundColor: AppColors.lilyWhite,
        textTheme: ThemeData.light().textTheme.copyWith(),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.black),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: AppColors.deepBlack,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.white),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
        ),
        primaryColor: AppColors.deepBlack,
        backgroundColor: AppColors.deepBlack,
        canvasColor: AppColors.bunkerBlack,
        scaffoldBackgroundColor: AppColors.deepBlack,
      ),
      home: FutureBuilder<Assets>(
        future: _assets,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return Container();

          final assets = snapshot.data!.assets!;

          return AssetDetails(
            asset: assets[0],
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
