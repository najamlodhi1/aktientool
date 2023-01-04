@JS()
library stripe;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js/js.dart';

import '../../constants/constants.dart';
import '../../authentication/screens/forgot_password.dart';

void redirectToCheckout(BuildContext context) async {
  final stripe = Stripe(apiKey);

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
