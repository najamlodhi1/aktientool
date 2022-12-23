import 'package:aktientool/filter/marketcap.dart';
import 'package:aktientool/filter/country_industry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Filter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Filter'), backgroundColor: Colors.black),
      // Implement the ExpansionTile
      body: SingleChildScrollView(
        child: Column(
          children: [
            Marketcap(),
            CountryIndustry(),
          ],
        ),
      ),
    );
  }
}
