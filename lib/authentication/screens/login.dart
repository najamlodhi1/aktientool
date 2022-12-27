// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';

import '../../stockscreener/home.dart';
import '../services/auth_service.dart';
import 'forgot_password.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height
                //set minimum height equal to 100% of VH
                ),
        width: MediaQuery.of(context).size.width,
        //make width of outer wrapper to 100%
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 0, 255, 225),
              Color.fromARGB(255, 64, 255, 226),
              Color.fromARGB(255, 54, 244, 200),
              Color.fromARGB(255, 82, 255, 189),
            ],
          ),
        ), //show linear gradient background of page

        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          TextButton(
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UsePaypal(
                            sandboxMode: true,
                            clientId:
                                "AVm91QFLAO36yrOG4n82j0LCae-a7F4bbaIB-Mn7_ncjPJpKcT3tIVUsttuUWgdkn3Iv7aqxgJc9bFj2",
                            secretKey:
                                "EM9PQoyPWkVkm-JoI1pMuoHYVDEkFnMv5WxZWnvf0wZusEDPSSHG7lUlmo5cAL3H33IS44SZxC9y8nTR",
                            returnURL: "https://aktientool.com/return",
                            cancelURL: "https://aktientool.com/cancel",
                            transactions: const [
                              {
                                "amount": {
                                  "total": '10.12',
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": '10.12',
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "The payment transaction description.",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "A demo product",
                                      "quantity": 1,
                                      "price": '10.12',
                                      "currency": "USD"
                                    }
                                  ],

                                  // shipping address is not required though
                                  "shipping_address": {
                                    "recipient_name": "Jane Foster",
                                    "line1": "Travis County",
                                    "line2": "",
                                    "city": "Austin",
                                    "country_code": "US",
                                    "postal_code": "73301",
                                    "phone": "+00000000",
                                    "state": "Texas"
                                  },
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              print("onSuccess: $params");
                            },
                            onError: (error) {
                              print("onError: $error");
                            },
                            onCancel: (params) {
                              print('cancelled: $params');
                            }),
                      ),
                    )
                  },
              child: const Text("Make Payment")),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 250,
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Email'),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: 250,
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ForgotPassword(),
                ),
              );
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                final message = await AuthService().login(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                if (message!.contains('Success')) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: const Text('LOGIN', style: TextStyle(fontSize: 15)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          /*
          SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                await AuthService().signInWithGoogle().then((result) {
                  if (kDebugMode) {
                    print(result);
                  }
                  if (result != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const Home(),
                      ),
                    );
                  }
                }).catchError((error) {
                  if (kDebugMode) {
                    print('Registration Error: $error');
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: const Text('LOGIN WITH GOOGLE',
                  style: TextStyle(fontSize: 15)),
            ),
          ),*/
          const SizedBox(
            height: 30.0,
          ),
        ]),
      )),
    );
  }
}
