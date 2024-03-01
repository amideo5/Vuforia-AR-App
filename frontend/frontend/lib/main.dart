import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/cam.dart';
import 'package:frontend/services/SessionManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLoggedIn = await isUserLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> isUserLoggedIn() async {
  return await SessionManager.isLoggedIn();
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: const Color.fromARGB(255, 164, 164, 164)));

    return MaterialApp(
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 164, 164, 164),
          primaryColorDark: const Color.fromARGB(255, 164, 164, 164),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color.fromARGB(255, 164, 164, 164))),
      debugShowCheckedModeBanner: false,
      home: ARScene(),
    );
  }
}
