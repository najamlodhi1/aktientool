// ignore_for_file: must_be_immutable

import 'package:aktientool/payment/paypal/paypal_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import 'dart:core';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;

  const PaypalPayment({super.key, required this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  late String executeUrl;
  late String accessToken;
  PaypalServices services = PaypalServices();

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'https://aktientool.net/';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = (await services.getAccessToken())!;

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"]!;
            executeUrl = res["executeUrl"]!;
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('exception: $e');
        }
      }
    });
  }

  // item name, price and quantity
  String itemName = 'Item';
  String itemPrice = '1.99';
  int quantity = 1;
  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "EUR",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "EUR"
  };

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String totalAmount = '1.99';
    //String subTotalAmount = '1.99';
    //String shippingCost = '0';
    //int shippingDiscountCost = 0;
    String userFirstName = 'John';
    String userLastName = 'Doe';
    String addressCity = 'Gotham City';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'New York';
    String addressState = 'New York';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            /*
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
             */
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": "$userFirstName $userLastName",
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(checkoutUrl);
    }

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebViewX(
          initialContent: checkoutUrl!,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.content.source.contains(returnURL)) {
              final uri = Uri.parse(request.content.source);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.content.source.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

/*
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
 */
