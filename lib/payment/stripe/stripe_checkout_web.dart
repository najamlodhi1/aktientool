@JS()
library stripe;

import 'package:aktientool/payment/stripe/shared/checkout_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';

import '../../constants/constants.dart';

void redirectToCheckout(BuildContext context) async {
  final stripe = Stripe(apiKey);

  String userUid = FirebaseAuth.instance.currentUser!.uid;
  var docRef = await FirebaseFirestore.instance
      .collection('users')
      .doc(userUid)
      .collection('checkout_sessions')
      .add({
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

        var res = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => CheckoutPage(url: url)));

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
                        })
                  ],
                );
              });
        }
      }
    }
  });

/*
  try {
    final checkoutSession = await stripe.redirectToCheckout(
      CheckoutOptions(
        lineItems: [
          LineItem(price: nikesPriceId, quantity: 1),
        ],
        mode: 'payment',
        successUrl: 'https://aktientool.net/',
        cancelUrl: 'https://aktientool.net/',
      ),
    );

    // Der Checkout-Vorgang war erfolgreich und Sie können die checkoutSession verwenden
  } on PlatformException catch (e) {
    // Eine Exception wurde ausgelöst, der Checkout-Vorgang ist fehlgeschlagen
    print(e);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ForgotPassword(),
      ),
    );
  }

  */
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
