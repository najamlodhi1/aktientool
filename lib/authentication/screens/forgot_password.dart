// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../webpage/start.dart';
import '../services/auth_service.dart';
import '../services/auth_status.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        title: const Text('Reset Password'),
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
            ElevatedButton(
              onPressed: () async {
                final status = await AuthService()
                    .resetPassword(email: _emailController.text.trim());
                if (status == AuthStatus.successful) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Start(),
                    ),
                  );
                }
              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
