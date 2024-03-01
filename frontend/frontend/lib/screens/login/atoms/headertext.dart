import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'AMIDEO AR WORLD',
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
