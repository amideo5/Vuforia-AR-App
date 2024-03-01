// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, unused_field

import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:frontend/screens/profile/profileScreen.dart';
import 'package:frontend/screens/settings/settingscreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

// ignore: use_key_in_widget_constructors
class ARScene extends StatefulWidget {
  @override
  ARSceneState createState() => ARSceneState();
}

class ARSceneState extends State<ARScene> {
  late UnityWidgetController _unityWidgetController;
  OverlayEntry? overlayEntry;
  ScreenshotController screenshotController = ScreenshotController();
  bool cam = true;
  late CameraController _cameraController;
  late List<CameraDescription> cameras;
  // UnityWidgetController? _unityWidgetController;

  int _currentIndex = 2;

  @override
  void initState() {
    initializeCamera();
    requestPermission();
    super.initState();
  }

  Future<void> getCamera() async {
    cameras = await availableCameras();
  }

  void initializeCamera() async {
    await getCamera();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    try {
      await _cameraController.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      // Handle camera initialization error
      print('Error initializing camera: $e');
    }
  }

  Future<void> requestPermission() async {
    const permission = Permission.camera;

    if (await permission.isDenied) {
      await permission.request();
    }

    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> saveImage(Uint8List _imageFile) async {
    String directory = (await getExternalStorageDirectory())!.path;
    String arMediaFolderPath = '$directory/Gallery';
    Directory arMediaFolder = Directory(arMediaFolderPath);
    if (!await arMediaFolder.exists()) {
      await arMediaFolder.create(recursive: true);
    }
    String fileName =
        '${DateTime.now().microsecondsSinceEpoch}${Random().nextInt(10000)}.jpg';
    String path = arMediaFolderPath;
    try {
      String filePath = '$path/$fileName';
      final imagePath = await File(filePath).create();
      await imagePath.writeAsBytes(_imageFile);
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  void onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    if (scene != null) {
      print('Received scene loaded from unity: ${scene.name}');
      print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
    } else {
      print('Received scene loaded from unity: null');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget unity() {
      return UnityWidget(
        onUnityCreated: onUnityCreated,
        onUnityMessage: onUnityMessage,
        onUnitySceneLoaded: onUnitySceneLoaded,
        useAndroidViewSurface: false,
        borderRadius: const BorderRadius.all(Radius.circular(70)),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent.withOpacity(0.5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png",
                  fit: BoxFit.scaleDown,
                  width: 40,
                  height: kBottomNavigationBarHeight),
              const SizedBox(width: 10),
              const Text(
                "AMIDEO AR WORLD",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false),
      body: Card(
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: cam
                  ? SizedBox(
                      height: double.infinity,
                      child: CameraPreview(_cameraController),
                    )
                  : Screenshot(
                      controller: screenshotController, child: unity()),
            ),
            Positioned(
              bottom: kBottomNavigationBarHeight + 10,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            cam = !cam;
                            if (cam == true) {
                              initializeCamera();
                            }
                          });

                          // _unityWidgetController?.postMessage(
                          //   "Button",
                          //   "MyUnityFunction",
                          //   "Hello from Flutter!",
                          // );
                        },
                        child: Text(cam ? 'Start Scan' : 'Stop Scan'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
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
                      screenshotController
                          .capture()
                          .then((capturedImage) async {
                        Uint8List? _imageFile = capturedImage;
                        saveImage(_imageFile!);
                      }).catchError((onError) {
                        if (kDebugMode) {
                          print(onError);
                        }
                      });

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
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SettingScreen();
                      }), (r) {
                        return false;
                      });
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _currentIndex = 2;
        },
        backgroundColor: Colors.transparent,
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
