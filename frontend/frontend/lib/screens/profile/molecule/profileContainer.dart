// ignore_for_file: use_key_in_widget_constructors, file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/atoms/logout.dart';
import 'package:frontend/screens/profile/profileScreen.dart';
import 'package:frontend/services/SessionManager.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfileContainer extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProfileContainerState createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  late Map<String, dynamic> requestBody;
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool toChange = false;
  String name = '';
  String email = '';
  String username = '';

  String emailError = '';
  String nameError = '';
  String usernameError = '';
  String passwordError = '';
  String confirmPasswordError = '';

  @override
  void initState() {
    callProfileLoadAPI();
    super.initState();
  }

  Future<void> callProfileLoadAPI() async {
    try {
      String id = (await SessionManager.getUserId())!;
      final response = await profileLoad(id);
      Map<String, dynamic> json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          username = json['userName'];
          email = json['email'];
          name = json['name'];
        });
      } else {
        setState(() {});
      }
    } catch (e) {
      log('Exception Catch Block: ${e.toString()}');
      setState(() {});
    }
  }

  Future<http.Response> profileLoad(String id) {
    return http.get(
      Uri.parse("http://localhost:8080/users/getUser/$id"),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !emailRegex.hasMatch(email);
  }

  Future<void> updateUser() async {
    String? id = await SessionManager.getUserId();
    final String name = nameController.text;
    final String email = emailController.text;
    final String username = usernameController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmpasswordController.text;

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
      _btnController2.reset();
      setState(() {
        usernameError = '';
      });
    } else {
      try {
        requestBody = {
          "userName": username,
          "name": name,
          "email": email,
          "password": password
        };
        final response = await updateUserCall(id!, requestBody);
        if (response.statusCode == 200) {
          setState(() {
            confirmPasswordError = 'Password changed';
          });
          await SessionManager.setUserId(username);
          Future.delayed(const Duration(seconds: 3), () {
            _btnController2.success();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          });
        } else {
          _btnController2.reset();
          setState(() {
            confirmPasswordError = 'Error please try again after some time.';
          });
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          });
        }
      } catch (e) {
        log('Exception Catch Block: ${e.toString()}');
        _btnController2.reset();
        setState(() {
          confirmPasswordError = 'Unknown error occured';
        });
      }
    }
  }

  Future<http.Response> updateUserCall(
      String id, Map<String, dynamic> requestBody) {
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
    return toChange
        ? SingleChildScrollView(
            child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F9FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Update User',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF8898AA),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Text(
                    "Please enter the new user details.\nIf some details are not to be changed please enter the previous details.",
                    style: TextStyle(
                      fontSize: 14,
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
                    hintText: name,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8),
                    errorText: nameError == '' ? null : nameError,
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
                    hintText: email,
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
                    hintText: username,
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
                    hintText: '',
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
                    hintText: '',
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
                const SizedBox(height: 40),
                RoundedLoadingButton(
                  color: Colors.indigo.shade900,
                  successColor: Colors.indigo.shade900,
                  controller: _btnController2,
                  onPressed: () => updateUser(),
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
          ))
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F9FF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'User Profile',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF8898AA),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: name,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: email,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: username,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      prefixIcon: const Icon(Icons.verified_user),
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.only(top: 3.0),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () async {
                        setState(() {
                          toChange = true;
                        });
                      },
                      child: const Text(
                        'Change User Details',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 18, 62, 112),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Logout(),
                ],
              ),
            ),
          );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ProfileContainer(),
    ),
  ));
}
