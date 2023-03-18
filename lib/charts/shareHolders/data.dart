// import 'package:aktientool/charts/shareHolders/post.dart';


// var data, costOfRevenue = <Data>[];
// class RemoteService {
//   getData(dynamic result) async {

//           final List l = result.split('date');
//       int lengthJson = l.length - 2;

//       data = [];
//       costOfRevenue = [];

//       dynamic posts = postFromJson(result);

//       while (lengthJson >= 0) {
//         String years = posts[lengthJson].date.toString().substring(0, 4);
//         String yearsMonth = posts[lengthJson].date.toString().substring(5, 7);
//         String yearsDay = posts[lengthJson].date.toString().substring(8, 11);

//         double revenueData =
//             double.parse((posts[lengthJson]).revenue.toStringAsFixed(2)) / 1000;

//         double costOfRevenueData =
//             double.parse((posts[lengthJson]).costOfRevenue.toStringAsFixed(2)) /
//                 1000;

//         data.add(Data(
//           DateTime(
//               int.parse(years), int.parse(yearsMonth), int.parse(yearsDay)),
//           revenueData,
//           costOfRevenueData,
//         ));
//         lengthJson--;
//       }
//       return data;
//   }
// }

// class Data {
//   Data(this.year, this.revenue, this.costOfRevenueData);
//   final DateTime year;
//   final double revenue;
//   final double costOfRevenueData;
// }

// List get allData {
//   return data
//       .mapIndexed(((index, element) =>
//           Data(element.year, element.revenue, element.costOfRevenueData)))
//       .toList();
// }
