import 'dart:convert';
import 'package:aktientool/env/env.dart';
import 'package:http/http.dart' as http;
import '../../authentication/services/http_service.dart';

Future<dynamic> checkoutPackage(int type) async {
  return await http.post(
      Uri(
        scheme: scheme,
        host: baseurl,
        path: 'StripePayment/payment',
      ),
      body: jsonEncode({
        'priceString': type == 1
            ? Env.priceId20
            : type == 2
                ? Env.priceId50
                : Env.priceId100,
        'price': type == 1
            ? 30
            : type == 2
                ? 100
                : 200
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*'
      }).then((value) {
    return jsonDecode(value.body);
  });
}
