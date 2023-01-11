import 'package:aktientool/payment/stripe/fetch_product_details.dart';
import 'package:aktientool/payment/stripe/checkout_page.dart';
import 'package:aktientool/payment/stripe/show_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

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
          while (snapshot.hasData == false) {
            return loading('Loading product details');
          }

          List<ProductDetials> productDetails = snapshot.data!;
          ProductDetials currentProduct = productDetails.elementAt(0);
          buyStuff(currentProduct);

          return const Center(child: CircularProgressIndicator());
        });
  }

  buyStuff(ProductDetials pd) async {
    setState(() {
      loadingPayment = true;
    });
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    var docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('checkout_sessions')
        .add({
      'price': pd.priceId,
      'quantity': pd.quatity,
      'mode': 'payment',
      'success_url': 'https://success.com',
      'cancel_url': 'https://cancel.com'
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
            html.window.open(url, "pay and close");
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
