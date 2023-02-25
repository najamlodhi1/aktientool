// ignore_for_file: depend_on_referenced_packages, unused_import, unused_local_variable, avoid_print

@JS()
library stripe;

import 'package:aktientool/env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js/js.dart';

import '../../constants/constants.dart';
import '../../authentication/screens/forgot_password.dart';

void redirectToCheckout(BuildContext context) async {
  final stripe = Stripe(Env.apiKey);

  try {
    final checkoutSession = await stripe.redirectToCheckout(
      CheckoutOptions(
        lineItems: [
          LineItem(price: Env.nikesPriceId, quantity: 1),
        ],
        mode: 'payment',
        successUrl: 'https://aktientool.net/?ret=success',
        cancelUrl: 'https://aktientool.net/?ret=cancel',
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
