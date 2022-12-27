// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'package:flutter/material.dart';

import '../../stockscreener/home.dart';
import '../services/auth_service.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

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
