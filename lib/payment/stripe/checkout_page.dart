// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutPage extends StatefulWidget {
  final String url;
  const CheckoutPage({Key? key, required this.url}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.disabled,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://aktientool.net/success')) {
            Navigator.of(context).pop();

            //Navigator.pop(context, 'success');
          } else if (request.url.startsWith('https://aktientool.net/cancel')) {
            log('checkout page cancel start ');
            Navigator.of(context).pop();

            //Navigator.pop(context, 'cancel');
          }

          return NavigationDecision.navigate;
        },
      )),
    );
  }
}
