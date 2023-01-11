import 'package:flutter/material.dart';

loading(String msg) {
  return Scaffold(
    body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(msg),
        const SizedBox(
          height: 10,
        ),
        const Center(child: CircularProgressIndicator())
      ],
    )),
  );
}
