// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:frontend/cam.dart';
import 'package:frontend/screens/profile/profileScreen.dart';
import 'package:frontend/screens/settings/atoms/naviLoginProf.dart';
import 'package:frontend/screens/settings/molecule/settingContainer.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _currentIndex = 4;
  OverlayEntry? overlayEntry;

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
                NaviLoginProf(),
                const SizedBox(height: 20),
                SettingContainer(),
                const SizedBox(
                  height: kBottomNavigationBarHeight,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.screenshot),
                  label: 'Screenshot',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.question_mark),
                  label: 'About',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
                switch (index) {
                  case 0:
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Action Not Allowed'),
                          content: const Text(
                              'Screenshot of this screen is not allowed'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    break;
                  case 1:
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ProfileScreen();
                    }), (r) {
                      return false;
                    });
                    break;
                  case 2:
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => ARScene()),
                        (r) {
                      return false;
                    });
                    break;
                  case 3:
                    if (overlayEntry != null) {
                      overlayEntry!.remove();
                      overlayEntry = null;
                    } else {
                      showOverlay(context);
                    }
                    break;
                  case 4:
                    break;
                }
              },
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => ARScene()), (r) {
            return false;
          });
        },
        child: Image.asset(
          "assets/logo.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'AMIDEO AR WORLD\n\nHi!! Stay tuned:)',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (overlayEntry != null) {
                          overlayEntry!.remove();
                          overlayEntry = null;
                        }
                      },
                      child: const Text('OK'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry!);
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingScreen(),
  ));
}
