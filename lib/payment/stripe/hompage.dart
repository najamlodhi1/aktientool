// ignore_for_file: avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'package:aktientool/payment/stripe/fetch_product_details.dart';
import 'package:aktientool/payment/stripe/checkout_page.dart';
import 'package:aktientool/payment/stripe/show_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.paymenttype}) : super(key: key);
  final int paymenttype;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool loadingPayment = false;
  @override
  Widget build(BuildContext context) {
    if (loadingPayment) return loading("Processing payment...");

    return FutureBuilder<List<ProductDetials>>(
        future: featchProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductDetials> productDetails = snapshot.data!;
            buyStuff(
                productDetails[widget.paymenttype - 1],
                widget.paymenttype == 1
                    ? 30
                    : widget.paymenttype == 2
                        ? 100
                        : 200);
            return const Center(child: CircularProgressIndicator());
          }
          return loading('Loading product details');
        });
  }

  buyStuff(ProductDetials pd, int clicks) async {
    // setState(() {
    loadingPayment = true;
    // });
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    var docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('checkout_sessions')
        .add({
      'price': pd.priceId,
      'quantity': pd.quatity,
      'mode': 'payment',
      "payment_method_types": ["card", "sepa_debit"],
      'currency': 'eur',
      'success_url': 'https://aktientool.net/?ret=success&q=$clicks',
      'cancel_url': 'https://aktientool.net/?ret=cancel'
    });

    docRef.snapshots().listen((ds) async {
      if (ds.exists) {
        //check any error
        var error;

        try {
          error = ds.get('error');
        } catch (e) {
          error = null;
        }

        if (error != null) {
          //show a dialog for error message
          print(error);
        } else {
          String url = ds.get('url');

          if (kIsWeb) {
            //open url in new tab
            //html.window.open(url, "pay and close");
            html.window.open(url, "_self");
            //Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CheckoutPage(url: url)));
          } else {
            var res = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CheckoutPage(url: url)));
            if (res == 'success') {
              //payment successfull
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Payment Successfull'),
                      actions: [
                        TextButton(
                            child: const Text('ok'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).pop();
                            })
                      ],
                    );
                  });
            } else {
              //payment failed
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Payment failed'),
                      actions: [
                        TextButton(
                            child: const Text('ok'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).pop();
                            })
                      ],
                    );
                  });
            }
          }
        }

        setState(() {
          loadingPayment = false;
        });
      }
    });
  }
}
