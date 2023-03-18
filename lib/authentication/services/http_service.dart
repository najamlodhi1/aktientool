import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../../stockscreener/showCompanies.dart';

String scheme = 'https';
String baseurl = 'us-central1-aktientool-55.cloudfunctions.net';

Future<http.Response> getalldata() async {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";

  String token = '';

  if (stock != 'AAPL') {
    token = await FirebaseAuth.instance.currentUser!.getIdToken();
  }

  return await http.get(
      Uri(
          scheme: scheme,
          host: baseurl,
          path: 'Interceptor/getall',
          queryParameters: {'stock': stock}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      });
}
