import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

String scheme = 'https';
String baseurl = 'us-central1-aktientool-55.cloudfunctions.net';

Future<http.Response> httpgethelper({required String path}) async {
  String token = await FirebaseAuth.instance.currentUser!.getIdToken();
  return await http.post(
      Uri(scheme: scheme, host: baseurl, path: 'Interceptor/sendrequest'),
      body: jsonEncode({'path': path}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      }).then((value) {
    print(value.body);
    return value;
  });
}
