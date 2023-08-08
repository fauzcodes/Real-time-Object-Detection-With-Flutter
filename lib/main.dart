import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rod_app/splashScreen.dart';



late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const ObjectDetector());
}


class ObjectDetector extends StatelessWidget {
  const ObjectDetector({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real-time Object Detection',
      theme: ThemeData.dark(),
      home: Splash()
    );
  }
}
