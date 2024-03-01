// ignore_for_file: file_names
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      width: 200,
      height: 200,
    );
  }
}
