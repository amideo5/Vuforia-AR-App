// ignore_for_file: file_names
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TextSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 80.0),
        child: Text(
          'AMIDEO AR WORLD',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
