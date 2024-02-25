import 'package:flutter/material.dart';
import 'package:frontend/cam.dart';
import 'package:frontend/screens/login/loginscreen.dart';
import 'package:frontend/screens/splash/atoms/LogoImage.dart';
import 'atoms/Textsplash.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;

  const SplashScreen({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget.isLoggedIn ? ARScene() : Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/BG.jpg', fit: BoxFit.cover),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                LogoImage(),
                const SizedBox(height: 30),
                TextSplash(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
