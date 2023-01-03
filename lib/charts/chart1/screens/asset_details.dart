import 'package:aktientool/charts/chart1/components/chart_filter.dart';
import 'package:aktientool/charts/chart1/components/portfolio_card.dart';
import 'package:aktientool/charts/chart1/components/price.dart';
import 'package:aktientool/charts/chart1/models/assets/asset.dart';
import 'package:aktientool/charts/chart1/utilities/colors.dart';
import 'package:aktientool/charts/chart1/utilities/device.dart';
import 'package:aktientool/charts/chart1/utilities/format.dart';
import 'package:flutter/material.dart';

class AssetDetails extends StatefulWidget {
  final Asset asset;

  const AssetDetails({required this.asset});

  @override
  _AssetDetailsState createState() => _AssetDetailsState();
}

class _AssetDetailsState extends State<AssetDetails> {
  @override
  Widget build(BuildContext context) {
    final color = CryptoColors.parse(widget.asset.symbol);
    final theme = Theme.of(context);
    final isDarkMode = Device.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? theme.primaryColor : color,
        title: Text(widget.asset.symbol.toUpperCase()),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Price(
                      amount: Format.toAmount(widget.asset.price),
                      percentChange: widget.asset.percentChange24h,
                      // color: Colors.white,
                    ),
                  ),
                  PortfolioCard(
                    asset: widget.asset,
                    lineColor: color,
                  ),
                  Container(
                    child: ChartFilter(
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: const Divider(
                          // color: Colors.black45,
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
