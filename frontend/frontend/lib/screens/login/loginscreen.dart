import 'package:flutter/material.dart';
import 'package:frontend/screens/login/molecule/logincontainer.dart';
import 'package:frontend/screens/login/molecule/naviLoginProf.dart';

// ignore: use_key_in_widget_constructors
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BG.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                NaviLoginProf(),
                LoginContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
