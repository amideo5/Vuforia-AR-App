import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/screens/forgot/atoms/headercontainertext.dart';
import 'package:frontend/screens/forgot/atoms/lowertext.dart';
import 'package:frontend/screens/login/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

// ignore: use_key_in_widget_constructors
class HeaderContainer extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HeaderContainerState createState() => _HeaderContainerState();
}

class _HeaderContainerState extends State<HeaderContainer> {
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  bool verify = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String userNameForAPI = '';
  late Map<String, dynamic> requestBody;

  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String responseMsg = '';

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !emailRegex.hasMatch(email);
  }

  Future<void> validateEmail() async {
    String email = emailController.text;

    if (email.isEmpty) {
      setState(() {
        emailError = 'Email cannot be blank';
      });
    } else if (isValidEmail(email)) {
      setState(() {
        emailError = 'Please include proper mail format';
      });
    } else {
      try {
        final response = await emailCheck(email);
        Map<String, dynamic> json = jsonDecode(response.body);
        userNameForAPI = json['userName'];
        requestBody = {
          "userName": json['userName'],
          "name": json['name'],
          "email": json['email'],
          "password": json['password']
        };
        if (response.statusCode == 200) {
          setState(() {
            verify = true;
          });
        } else {
          setState(() {
            emailError = 'Email not valid. Please try again.';
          });
        }
      } catch (e) {
        log('Exception Catch Block: ${e.toString()}');
        setState(() {
          responseMsg = 'Unexpected exception occurred: ${e.toString()}';
        });
      }
    }
  }

  Future<http.Response> emailCheck(String email) {
    return http.get(
      Uri.parse("http://localhost:8080/users/getUserByEmail/$email"),
    );
  }

  Future<void> validatePassword() async {
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (password.isEmpty && confirmPassword.isEmpty) {
      _btnController2.reset();
      setState(() {
        passwordError = 'Password cannot be blank';
        confirmPasswordError = 'Confirm Password cannot be blank';
      });
    } else if (password.isEmpty) {
      _btnController2.reset();
      setState(() {
        passwordError = 'Password cannot be blank';
        confirmPasswordError = '';
      });
    } else if (confirmPassword.isEmpty) {
      _btnController2.reset();
      setState(() {
        passwordError = '';
        confirmPasswordError = 'Confirm Password cannot be blank';
      });
    } else if (password != confirmPassword) {
      _btnController2.reset();
      setState(() {
        passwordError = '';
        confirmPasswordError = 'Passwords do not match';
      });
    } else {
      try {
        requestBody["password"] = password;
        final response = await changePassword(userNameForAPI, requestBody);
        if (response.statusCode == 200) {
          setState(() {
            confirmPasswordError = 'Password changed';
            passwordError = '';
          });
          Future.delayed(const Duration(seconds: 3), () {
            _btnController2.success();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          });
        } else {
          _btnController2.reset();
          setState(() {
            emailError = 'Error please try again after some time.';
          });
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          });
        }
      } catch (e) {
        log('Exception Catch Block: ${e.toString()}');
        _btnController2.reset();
        setState(() {
          responseMsg = 'Unexpected exception occurred: ${e.toString()}';
        });
      }
    }
  }

  Future<http.Response> changePassword(
      String username, Map<String, dynamic> requestBody) {
    return http.put(
      Uri.parse("http://localhost:8080/users/updateUser/$username"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: verify
          ? Container(
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F9FF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  HeaderContainerText(),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Text(
                      "Please enter the new password.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      hintText: 'Enter New Password',
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      errorText: passwordError == '' ? null : passwordError,
                      prefixIcon: const Icon(Icons.key),
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Password Again',
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      errorText: confirmPasswordError.isNotEmpty
                          ? confirmPasswordError
                          : null,
                      prefixIcon: const Icon(Icons.key),
                    ),
                    controller: confirmPasswordController,
                    onChanged: (text) {
                      setState(() {
                        confirmPasswordError = '';
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  RoundedLoadingButton(
                    color: Colors.indigo.shade900,
                    successColor: Colors.indigo.shade900,
                    controller: _btnController2,
                    onPressed: () => validatePassword(),
                    valueColor: Colors.white,
                    borderRadius: 5,
                    width: 110,
                    height: 42,
                    child: const Text('UPDATE',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F9FF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  HeaderContainerText(),
                  LowerText(),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Email',
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
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: validateEmail,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.indigo.shade900,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
