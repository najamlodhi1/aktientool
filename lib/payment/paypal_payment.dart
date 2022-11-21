// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class PaypalPayment extends StatelessWidget {
  PaypalPayment({
    Key? key,
    required this.amount,
    required this.currency,
  }) : super(key: key);
  final double amount;
  final String currency;

  late WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          /*
      WebBrowser(
        initialUrl:
            'http://localhost:3000/createpaypalpayment?amount=$amount&currency=$currency',
        javascriptEnabled: true,
      ),
       */

          WebViewX(
        initialContent:
            'http://localhost:3000/createpaypalpayment?amount=$amount&currency=$currency',
        initialSourceType: SourceType.url,
        onWebViewCreated: (controller) => webviewController = controller,
        onPageStarted: (src) =>
            debugPrint('A new page has started loading: $src\n'),
        onPageFinished: (value) {
          if (kDebugMode) {
            print(value);
          }
        },
        jsContent: const {
          EmbeddedJsContent(
            js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
          ),
          EmbeddedJsContent(
            webJs:
                "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
            mobileJs:
                "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
          ),
        },
        dartCallBacks: {},
        webSpecificParams: const WebSpecificParams(
          printDebugInfo: true,
        ),
        mobileSpecificParams: const MobileSpecificParams(
          androidEnableHybridComposition: true,
        ),
        navigationDelegate: (NavigationRequest request) async {
          if (request.content.source
              .contains('http://return_url/?status=success')) {}
          if (request.content.source.contains('http://cancel_url')) {
            Navigator.pop(context);
          }
          return NavigationDecision.navigate;
        },
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),

      /*
      WebView(
        initialUrl:
            'http://localhost:3000/createpaypalpayment?amount=$amount&currency=$currency',
        gestureRecognizers: Set()
          ..add(
            Factory<DragGestureRecognizer>(
              () => VerticalDragGestureRecognizer(),
            ),
          ),
        onPageFinished: (value) {
          if (kDebugMode) {
            print(value);
          }
        },
        navigationDelegate: (NavigationRequest request) async {
          if (request.url.contains('http://return_url/?status=success')) {}
          if (request.url.contains('http://cancel_url')) {
            Navigator.pop(context);
          }
          return NavigationDecision.navigate;
        },
      ),
       */
    );
  }
}
