import 'package:flutter/material.dart';
import 'package:frontend/screens/forgot/forgotscreen.dart';

// ignore: use_key_in_widget_constructors
class Linktext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPassword()),
            );
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF143E7F),
            ),
          ),
        ),
      ],
    );
  }
}
