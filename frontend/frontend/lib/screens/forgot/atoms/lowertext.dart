import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LowerText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 60), // Add bottom padding
      child: Text(
        "Please enter the Email address used to register.",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center, // Center text horizontally
      ),
    );
  }
}
