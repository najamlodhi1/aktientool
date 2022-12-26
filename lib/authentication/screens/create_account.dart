// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:aktientool/datenschutz/agb.dart';
import 'package:aktientool/datenschutz/datenschutzerklaerung.dart';
import 'package:flutter/material.dart';
import '../../stockscreener/home.dart';
import '../services/auth_service.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({Key? key}) : super(key: key);

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

          //padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SizedBox(
                  child: Column(
                children: const [
                  Text(
                    "Werde JETZT kostenlos Mitglied.",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )),
              const SizedBox(
                height: 20,
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
                height: 30.0,
              ),
              Center(
                child: SizedBox(
                  width: 400,
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        const TextButton(
                            onPressed: null,
                            child:
                                Text('Durch das Klicken auf MITGLIED WERDEN')),
                        const TextButton(
                            onPressed: null, child: Text('stimmen Sie den')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const AGB(),
                                ),
                              );
                            },
                            child: const Text('AGB')),
                        const TextButton(onPressed: null, child: Text('und')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Datenschutzerklaerung(),
                                ),
                              );
                            },
                            child: const Text('Datenschutzrichtlinien')),
                        const TextButton(
                            onPressed: null, child: Text('von Aktientool zu!')),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    final message = await AuthService().registration(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (message!.contains('Success')) {
                      Navigator.of(context).pushReplacement(
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
                  child: const Text('MITGLIED WERDEN'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
