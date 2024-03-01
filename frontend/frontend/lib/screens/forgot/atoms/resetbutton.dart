// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final Function() onPress;

  // ignore: use_key_in_widget_constructors
  ResetButton({required this.onPress, required void Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF143E7F),
            minimumSize: const Size(150, 50),
          ),
          child: const Text(
            "RESET PASSWORD",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 120),
      ],
    );
  }
}
