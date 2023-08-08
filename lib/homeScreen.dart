import 'package:flutter/material.dart';
import 'cameraInit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Real-time Object Detection"),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_camera_rounded,
                color: Color.fromARGB(255, 186, 194, 201),
                size: 81.0,
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CameraInit();
                    },
                  ));
                },
                child: Text("Detect object", style: TextStyle(fontSize: 16),),
                style: ElevatedButton.styleFrom(
                fixedSize: Size(160, 45),
                backgroundColor: Color.fromARGB(255, 70, 72, 73),
                ),
              )
            ],
          ),
        ));
  }
}