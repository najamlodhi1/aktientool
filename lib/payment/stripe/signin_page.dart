import 'package:aktientool/payment/stripe/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            //homepage
            return HomePage(
              uid: snapshot.data!.uid,
            );
          }

          return Scaffold(
            backgroundColor: c2,
            appBar: AppBar(
              title: const Text('Signin Page',
                  style: TextStyle(color: Colors.black)),
              backgroundColor: c2,
              elevation: 0,
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: 'Email'),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: 'Password'),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: c1),
                        onPressed: () {
                          registerWithEmailAndPassword();
                        },
                        child: const Text('Register')),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future registerWithEmailAndPassword() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        User user = userCredential.user!;
        print(user.email);

        FirebaseFirestore firestore = FirebaseFirestore.instance;

        firestore
            .collection('users')
            .doc(user.uid)
            .set({'email': user.email, 'username': 'Ashish'});
      }
    } catch (e) {}
  }
}
