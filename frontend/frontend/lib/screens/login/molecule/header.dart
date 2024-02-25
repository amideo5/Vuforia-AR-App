import 'package:flutter/material.dart';
import 'package:frontend/screens/login/atoms/headerlogo.dart';
import 'package:frontend/screens/login/atoms/headertext.dart';

// ignore: use_key_in_widget_constructors
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.005),
          child: HeaderLogo(),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.40,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
          child: HeaderText(),
        ),
      ],
    );
  }
}
