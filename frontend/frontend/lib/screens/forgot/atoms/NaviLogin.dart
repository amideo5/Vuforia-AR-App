// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NaviLogin extends StatelessWidget {
  final VoidCallback onBackPress;
  final BuildContext context;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  NaviLogin({required this.onBackPress, required this.context});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackPress,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  size: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: onBackPress,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: SizedBox(
                    width: 80,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Text(
                    "AMIDEO AR WORLD",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
