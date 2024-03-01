import 'package:flutter/material.dart';
import 'package:frontend/screens/login/loginscreen.dart';
import 'package:frontend/services/SessionManager.dart';

// ignore: use_key_in_widget_constructors
class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3.0),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          await SessionManager.setLoggedIn(false);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF8898AA),
          ),
        ),
      ),
    );
  }
}
