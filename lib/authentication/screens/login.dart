// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'package:aktientool/authentication/screens/forgot_password.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../webpage/start.dart';
import '../services/auth_service.dart';
import 'create_account.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
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
              child: const Text('Forgot Password?'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await AuthService().login(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                if (message!.contains('Success')) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Start(),
                    ),
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signInWithGoogle().then((result) {
                  if (kDebugMode) {
                    print(result);
                  }
                  if (result != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => Start(),
                      ),
                    );
                  }
                }).catchError((error) {
                  if (kDebugMode) {
                    print('Registration Error: $error');
                  }
                });
              },
              child: const Text('Login with Google'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateAccount(),
                  ),
                );
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
