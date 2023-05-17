import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraCamera(
        onFile: (file) {
          Navigator.pop(context, file);
        },
      ),
    );
  }
}
