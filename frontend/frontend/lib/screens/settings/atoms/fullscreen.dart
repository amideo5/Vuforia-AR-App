// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:io';
import 'package:frontend/screens/settings/settingscreen.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  int _currentIndex = 0;

  FullScreenImage({required this.imagePath});

  void deleteFile() {
    File file = File(imagePath);
    file.deleteSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(214, 164, 164, 255),
      body: Card(
        margin: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(214, 164, 164, 255),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 65, 59, 59),
        unselectedItemColor: Colors.white,
        onTap: (int index) {
          _currentIndex = index;
          switch (index) {
            case 0:
              deleteFile();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ),
              );
              break;
            case 1:
              Share.shareXFiles([XFile(imagePath)]);
              break;
          }
        },
      ),
    );
  }
}
