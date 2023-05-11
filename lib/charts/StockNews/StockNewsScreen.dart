// ignore_for_file: file_names

import 'package:aktientool/charts/allCharts.dart';
import 'package:aktientool/charts/chart0/createchart.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/responsive.dart';
import 'StockNewsModel.dart';
import 'StockNewsService.dart';

class StockNewsScreen extends StatefulWidget {
  const StockNewsScreen(this.data, {super.key});
  final dynamic data;
  @override
  State<StockNewsScreen> createState() => _StockNewsScreenState();
}

class _StockNewsScreenState extends State<StockNewsScreen> {
  late Future<List<StockNewsModel>> getFuture;
  bool iseditable = true;
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    getFuture = StockNewsService().getData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StockNewsModel>>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            newsData = snapshot.data!;
            return bodyWidget(snapshot.data!);
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const SizedBox();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget bodyWidget(List<StockNewsModel> data) {
    data.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
    return Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
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
          children: [
            const Text("News",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white)),
            const SizedBox(
              height: 10,
            ),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    data.length, (index) => buildCard(data[index], index))),
          ],
        ));
  }

  Widget buildCard(StockNewsModel data, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          if (index == selectedIndex) {
            _launchUrl(Uri.parse(data.url));
          } else {
            setState(() {
              selectedIndex = index;
            });
          }
        },
        child: PhysicalModel(
          borderRadius: BorderRadius.circular(10),
          color: index == selectedIndex ? kPrimaryColor : primaryColor,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
                Text(data.text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.white)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      data.publishedDate,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
