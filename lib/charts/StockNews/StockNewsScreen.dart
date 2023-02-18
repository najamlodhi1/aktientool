import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'StockNewsModel.dart';
import 'StockNewsService.dart';

class StockNewsScreen extends StatefulWidget {
  const StockNewsScreen({super.key});

  @override
  State<StockNewsScreen> createState() => _StockNewsScreenState();
}

class _StockNewsScreenState extends State<StockNewsScreen> {
  late Future<List<StockNewsModel>> getFuture;
  bool iseditable = true;

  @override
  void initState() {
    super.initState();
    getFuture = StockNewsService().getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StockNewsModel>>(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return bodyWidget(snapshot.data!);
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
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) => buildCard(data[index]),
        ));
  }

  buildCard(StockNewsModel data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          _launchUrl(Uri.parse(data.url));
        },
        child: PhysicalModel(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 15)),
                const SizedBox(height: 10),
                Row(
                  children: [const Spacer(), Text(data.publishedDate)],
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
