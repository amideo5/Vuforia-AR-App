import 'package:flutter/material.dart';
import 'package:frontend/screens/login/loginscreen.dart';
import 'package:frontend/screens/signup/atoms/NaviLogin.dart';
import 'package:frontend/screens/signup/molecule/signupcontainer.dart';

// ignore: use_key_in_widget_constructors
class SignUp extends StatelessWidget {
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

          // Contents
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Builder(
                  builder: (BuildContext context) {
                    return NaviLogin(
                      onBackPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      context: context,
                    );
                  },
                ),
                SignUpContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
