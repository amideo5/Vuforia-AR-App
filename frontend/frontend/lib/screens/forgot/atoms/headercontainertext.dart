import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HeaderContainerText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20), // Add bottom padding
      child: Text(
        "Forgot Password",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF143E7F),
        ),
      ),
    );
  }
}
