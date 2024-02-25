import 'package:flutter/material.dart';

class Signinbutton extends StatelessWidget {
  final VoidCallback onPressed;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  Signinbutton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF143E7F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(16),
        ),
        onPressed: onPressed,
        child: const Text(
          'SIGN IN',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
