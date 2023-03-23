import 'package:aktientool/payment/stripe/show_loading.dart';
import 'package:aktientool/payment/stripe/stripe_checkout_web.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.paymenttype}) : super(key: key);
  final int paymenttype;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future getFuture;
  @override
  void initState() {
    getFuture = checkoutPackage(widget.paymenttype);
    super.initState();
  }

  void openUrlInSameTab(String url) {
    html.window.location.href = url;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            openUrlInSameTab(snapshot.data['url']);
          }
          return loading('Processing Payment');
        });
  }
}
