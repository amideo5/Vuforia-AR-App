// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, file_names, prefer_iterable_wheretype

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/screens/settings/atoms/fullscreen.dart';
import 'package:path_provider/path_provider.dart';

class SettingContainer extends StatefulWidget {
  @override
  _SettingContainerState createState() => _SettingContainerState();
}

class _SettingContainerState extends State<SettingContainer> {
  String arMediaFolderPath = '';

  @override
  void initState() {
    create();
    super.initState();
  }

  Future<void> create() async {
    Future.delayed(const Duration(seconds: 0), () {
      if (mounted) {
        setState(() {});
      }
    });
    String directory = (await getExternalStorageDirectory())!.path;
    arMediaFolderPath = '$directory/Gallery';
    Directory arMediaFolder = Directory(arMediaFolderPath);
    if (!await arMediaFolder.exists()) {
      await arMediaFolder.create(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<FileSystemEntity> fileList = Directory(arMediaFolderPath).listSync();
    List<FileSystemEntity> imageFiles = fileList.where((file) {
      return file is File;
    }).toList();

    List<Widget> imageWidgets = imageFiles.map((file) {
      return Column(
        children: [
          Expanded(
            child: Image.file(
              File(file.path),
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.4),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "Image Gallery",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemCount: imageWidgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImage(
                              imagePath: imageFiles[index].path,
                            ),
                          ),
                        );
                      },
                      child: imageWidgets[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: SettingContainer(),
    ),
  ));
}
