import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Pagetitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: const Text(
        'Log In to AR World',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF8898AA),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Pagetitle(),
        ),
      ),
    ),
  );
}
