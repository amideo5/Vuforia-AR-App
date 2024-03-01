import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/screens/login/loginscreen.dart';
import 'package:frontend/screens/signup/atoms/pagetitle.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class SignUpContainer extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SignUpContainerState createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  late Map<String, dynamic> requestBody;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  String usernameError = '';
  String passwordError = '';
  String nameError = '';
  String emailError = '';
  String confirmPasswordError = '';

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !emailRegex.hasMatch(email);
  }

  Future<void> validateAndCallAPI() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmpasswordController.text;
    String name = nameController.text;
    String email = emailController.text;

    if (username.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        username.isEmpty ||
        email.isEmpty) {
      _btnController2.reset();
      setState(() {
        confirmPasswordError = 'Fill all the fields';
      });
    } else if (password != confirmPassword) {
      _btnController2.reset();
      setState(() {
        confirmPasswordError = 'Passwords do not match';
      });
    } else if (isValidEmail(email)) {
      setState(() {
        emailError = 'Please include proper mail format';
      });
    } else {
      try {
        requestBody = {
          "userName": username,
          "name": name,
          "email": email,
          "password": password
        };
        final response = await signUp(requestBody);
        if (response.statusCode == 200) {
          confirmPasswordError = 'User Created';
          // ignore: use_build_context_synchronously
          Future.delayed(const Duration(seconds: 3), () {
            _btnController2.success();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          });
        } else {
          setState(() {
            confirmPasswordError = 'User already exists';
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

  Future<http.Response> signUp(Map<String, dynamic> requestBody) {
    return http.post(
      Uri.parse("http://localhost:8080/users/createUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
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
                hintText: 'Name',
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                errorText: nameError.isNotEmpty ? nameError : null,
                prefixIcon: const Icon(Icons.person),
              ),
              controller: nameController,
              onChanged: (text) {
                setState(() {
                  nameError = '';
                });
              },
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                hintText: 'Email',
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                errorText: emailError.isNotEmpty ? emailError : null,
                prefixIcon: const Icon(Icons.email),
              ),
              controller: emailController,
              onChanged: (text) {
                setState(() {
                  emailError = '';
                });
              },
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                hintText: 'Username',
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                errorText: usernameError.isNotEmpty ? usernameError : null,
                prefixIcon: const Icon(Icons.verified_user),
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
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                hintText: 'Confirm Password',
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                errorText: confirmPasswordError.isNotEmpty
                    ? confirmPasswordError
                    : null,
                prefixIcon: const Icon(Icons.lock),
              ),
              controller: confirmpasswordController,
              onChanged: (text) {
                setState(() {
                  confirmPasswordError = '';
                });
              },
            ),
            const SizedBox(height: 20),
            RoundedLoadingButton(
              color: Colors.indigo.shade900,
              successColor: Colors.indigo.shade900,
              controller: _btnController2,
              onPressed: () => validateAndCallAPI(),
              valueColor: Colors.white,
              borderRadius: 5,
              width: 110,
              height: 42,
              child: const Text('SIGN UP',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
