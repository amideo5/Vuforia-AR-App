import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(
        'assets/logo.png',
        width: 200,
        height: 120,
      ),
      const SizedBox(width: 20),
    ]);
  }
}
