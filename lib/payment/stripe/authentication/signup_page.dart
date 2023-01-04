import 'package:aktientool/payment/stripe/authentication/login_page.dart';
import 'package:aktientool/payment/stripe/shared/show_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late String name;
  late String email;
  late String password;

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    if (showLoading) {
      return loading('Loading...');
    }
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'SHOES STORE',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Name',
                          fillColor: Colors.grey.shade300,
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18))),
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Email',
                          fillColor: Colors.grey.shade300,
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18))),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: Colors.grey.shade300,
                          prefixIcon: const Icon(Icons.lock),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18))),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        registerUser();
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(18)),
                        alignment: Alignment.center,
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Login'))
        ],
      )),
    );
  }

  registerUser() async {
    setState(() {
      showLoading = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (userCredential.user != null) {
      User user = userCredential.user!;
      print(user.email);
      //save user data in db
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore
          .collection('users')
          .doc(user.uid)
          .set({'name': name, 'email': email});

      setState(() {
        showLoading = false;
      });
    }
  }
}
