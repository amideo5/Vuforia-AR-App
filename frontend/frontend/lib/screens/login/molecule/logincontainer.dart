import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/cam.dart';
import 'package:frontend/screens/login/atoms/linktext.dart';
import 'package:frontend/screens/login/atoms/pagetitle.dart';
import 'package:frontend/screens/signup/signup.dart';
import 'package:frontend/services/SessionManager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class LoginContainer extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  String usernameError = '';
  String passwordError = '';

  Future<void> validateAndCallAPI() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty && password.isEmpty) {
      _btnController2.reset();
      setState(() {
        usernameError = 'Username is required';
        passwordError = 'Password is required';
      });
    } else if (username.isEmpty) {
      _btnController2.reset();
      setState(() {
        usernameError = 'Username is required';
        passwordError = '';
      });
    } else if (password.isEmpty) {
      _btnController2.reset();
      setState(() {
        usernameError = '';
        passwordError = 'Password is required';
      });
    } else {
      try {
        final response = await signIn(username, password);
        if (response.statusCode == 200) {
          _btnController2.success();
          await SessionManager.setLoggedIn(true);
          await SessionManager.setUserId(username);
          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ARScene()));
        } else {
          setState(() {
            usernameError = '';
            passwordError = 'Username or Password is incorrect';
            _btnController2.reset();
          });
        }
      } catch (e) {
        log('Exception Catch Block: ${e.toString()}');
        setState(() {
          usernameError = '';
          passwordError = 'Unexpected exception occured please try again!';
          _btnController2.reset();
        });
      }
    }
  }

  Future<http.Response> signIn(String username, String password) {
    return http.post(
      Uri.parse("http://localhost:8080/users/signin/$username/$password"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F9FF),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Pagetitle(),
            const SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                hintText: 'Username',
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                errorText: usernameError.isNotEmpty ? usernameError : null,
                prefixIcon: const Icon(Icons.email),
              ),
              controller: usernameController,
              onChanged: (text) {
                setState(() {
                  usernameError = '';
                });
              },
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                hintText: 'Password',
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                errorText: passwordError.isNotEmpty ? passwordError : null,
                prefixIcon: const Icon(Icons.lock),
              ),
              controller: passwordController,
              onChanged: (text) {
                setState(() {
                  passwordError = '';
                });
              },
            ),
            const SizedBox(height: 15),
            RoundedLoadingButton(
              color: Colors.indigo.shade900,
              successColor: Colors.indigo.shade900,
              controller: _btnController2,
              onPressed: () => validateAndCallAPI(),
              valueColor: Colors.white,
              borderRadius: 5,
              width: 110,
              height: 42,
              child: const Text('SIGN IN',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
            const SizedBox(height: 15),
            Linktext(),
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('or'),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text('New User?'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: const Text('SIGN UP'),
            ),
          ],
        ),
      ),
    );
  }
}
