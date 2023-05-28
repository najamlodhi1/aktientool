import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../../stockscreener/showCompanies.dart';

String scheme = 'https';
String baseurl = 'us-central1-aktientool-55.cloudfunctions.net';

Future getdata(dynamic data, String path) async {
  String stock =
      selectedcompanysymbol.isNotEmpty ? selectedcompanysymbol : "AAPL";

  String token = '';

  if (data == null) {
    if (stock != 'AAPL') {
      token = await FirebaseAuth.instance.currentUser!.getIdToken();
    }
    return await http.get(
        Uri(
            scheme: scheme,
            host: baseurl,
            path: 'Interceptor/$path',
            queryParameters: {'stock': stock}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': '*/*'
        }).then((value) => value.body);
  } else {
    return data;
  }
}
