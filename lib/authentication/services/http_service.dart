import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../stockscreener/showCompanies.dart';

String scheme = 'https';
String baseurl = 'us-central1-aktientool-55.cloudfunctions.net';

Future<http.Response> getsinglerequest({required String path}) async {
  // String token = await FirebaseAuth.instance.currentUser!.getIdToken();
  return await http.post(
      Uri(scheme: scheme, host: baseurl, path: 'Interceptor/sendrequest'),
      body: jsonEncode({'path': path}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*'
        // 'Authorization': 'Bearer $token'
      });
}

Future<http.Response> getalldata() async {
  String stock = ShowCompanies.companysymbol.isNotEmpty
      ? ShowCompanies.companysymbol
      : "AAPL";
  return await http.get(
      Uri(
          scheme: scheme,
          host: baseurl,
          path: 'Interceptor/getall',
          queryParameters: {'stock': stock}),
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'});
}
