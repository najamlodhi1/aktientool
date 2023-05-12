import 'package:flutter/material.dart';
import '../chart3/BarChartBalanceScreen.dart';
import 'IncomeReportModel.dart';

class WaterfallIncomeScreen extends StatelessWidget {
  const WaterfallIncomeScreen(this.tableData, {super.key});
  final List<IncomeReportModel> tableData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  customtile('Revenue',
                      numberToKFormat(gettotalAmount(tableData, "Revenue"))),
                  const Divider(color: Colors.white24, height: 0),
                  customtile(
                      'Cost of Revenue',
                      numberToKFormat(
                          gettotalAmount(tableData, "Cost of Revenue"))),
                  const Divider(color: Colors.white24, height: 0),
                  customtile(
                      'Gross Profit',
                      numberToKFormat(
                          gettotalAmount(tableData, "Gross Profit"))),
                  const Divider(color: Colors.white24, height: 0),
                  customtile(
                      'Operating Expenses',
                      numberToKFormat(
                          gettotalAmount(tableData, "Operating Expenses"))),
                  const Divider(color: Colors.white24, height: 0),
                  customtile(
                      'Operating Income',
                      numberToKFormat(
                          gettotalAmount(tableData, "Interest Expense"))),
                  const Divider(color: Colors.white24, height: 0),
                  customtile(
                      'Other Expenses',
                      numberToKFormat(
                          gettotalAmount(tableData, "Other Expenses"))),
                  const Divider(color: Colors.white24, height: 0),
                  const Divider(color: Colors.white24, height: 0),
                  customtile('Net Income',
                      numberToKFormat(gettotalAmount(tableData, "Net Income"))),
                ],
              )),
          const SizedBox(width: 20),
          // Expanded(
          //     flex: 3,
          //     child: SizedBox(
          //         height: 250, child: WaterfallChart.withSampleData())),
          //Expanded(
          //    flex: 3, child: SizedBox(height: 250, child: WaterfallChart())),
        ],
      ),
    );
  }

  double gettotalAmount(List<IncomeReportModel> data, String title) {
    double amount = 0;
    int selectedReportIndex =
        data[0].reports.indexWhere((element) => element.title == title);

    for (var report in data) {
      amount += report.reports[selectedReportIndex].value;
    }
    return amount;
  }

  Widget customtile(String title, String amount) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        trailing: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '$amount ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
          const TextSpan(text: 'USD', style: TextStyle(color: Colors.white))
        ])));
  }
}
//--------------------------------------------------------------------
// class WaterfallChart extends StatelessWidget {
//   final List<charts.Series<WaterfallSegment, String>> seriesList;
//   final bool animate;

//   WaterfallChart(this.seriesList, {super.key, this.animate = true});

//   factory WaterfallChart.withSampleData() {
//     return WaterfallChart(
//       _createSampleData(),
//       animate: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return charts.BarChart(
//       seriesList,
//       animate: animate,
//       barRendererDecorator: charts.BarLabelDecorator<String>(),
//       domainAxis: const charts.OrdinalAxisSpec(),
//       behaviors: [
//         charts.ChartTitle('Waterfall Chart',
//             behaviorPosition: charts.BehaviorPosition.top,
//             titleOutsideJustification: charts.OutsideJustification.start),
//         charts.ChartTitle('Category',
//             behaviorPosition: charts.BehaviorPosition.bottom,
//             titleOutsideJustification:
//                 charts.OutsideJustification.middleDrawArea),
//         charts.ChartTitle('Value',
//             behaviorPosition: charts.BehaviorPosition.end,
//             titleOutsideJustification:
//                 charts.OutsideJustification.startDrawArea),
//       ],
//     );
//   }

//   static List<charts.Series<WaterfallSegment, String>> _createSampleData() {
//     final data = [
//       WaterfallSegment('Start', 100),
//       WaterfallSegment('Segment A', -20),
//       WaterfallSegment('Segment B', -10),
//       WaterfallSegment('Segment C', 30),
//       WaterfallSegment('End', 400),
//     ];

//     return [
//       charts.Series<WaterfallSegment, String>(
//         id: 'Waterfall',
//         colorFn: (WaterfallSegment segment, _) => segment.value > 0
//             ? charts.MaterialPalette.green.shadeDefault
//             : charts.MaterialPalette.red.shadeDefault,
//         domainFn: (WaterfallSegment segment, _) => segment.category,
//         measureFn: (WaterfallSegment segment, _) => segment.value.abs(),
//         data: data,
//         insideLabelStyleAccessorFn: (WaterfallSegment segment, _) =>
//             const charts.TextStyleSpec(color: charts.MaterialPalette.white),
//         outsideLabelStyleAccessorFn: (WaterfallSegment segment, _) =>
//             charts.TextStyleSpec(color: charts.MaterialPalette.gray.shade700),
//         labelAccessorFn: (WaterfallSegment segment, _) =>
//             segment.value.toString(),
//       )
//     ];
//   }
// }

// class WaterfallSegment {
//   final String category;
//   final int value;

//   WaterfallSegment(this.category, this.value);
// }
