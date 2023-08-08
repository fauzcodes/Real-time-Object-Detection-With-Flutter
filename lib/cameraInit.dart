import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:rod_app/main.dart';

class CameraInit extends StatefulWidget {
  const CameraInit({super.key});

  @override
  State<CameraInit> createState() => _CameraInitState();
}

class _CameraInitState extends State<CameraInit> {
  bool isWorking = false;
  String result = "";

  late CameraController _cameraController;
  CameraImage? _cameraImage;
  List? recognitionList;

  initCamera() {
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        _cameraController.startImageStream((image) => {
              if (!isWorking)
                {
                  isWorking = true,
                  _cameraImage = image,
                  runModel(),
                }
            });
      });
    });
  }

  runModel() async {
    if (_cameraImage != null) {
      recognitionList = await Tflite.detectObjectOnFrame(
        bytesList: _cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        asynch: true,
        imageHeight: _cameraImage!.height,
        imageWidth: _cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResultsPerClass: 1,
        threshold: 0.4,
      );
    }

    setState(() {
      _cameraImage;
    });

    isWorking = false;
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    initCamera();
  }

  @override
  void dispose() async {
    super.dispose();
    _cameraController.stopImageStream();
    await Tflite.close();
  }

  List<Widget> dislayBoxesAroundRecognizedObjects(Size screen) {
    if (recognitionList == null) return [];

    double factorX = screen.width;
    double factorY = screen.height;

    Color colorPick = Colors.green;
    return recognitionList!.map((result) {
      return Positioned(
        left: result["rect"]['x'] * factorX,
        top: result["rect"]["y"] * factorY,
        width: result["rect"]["w"] * factorX,
        height: result["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.green, width: 2.0),
          ),
          child: Text(
            "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> list = [];
    list.add(Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height - 100,
        child: Container(
          height: size.height - 100,
          child: (!_cameraController.value.isInitialized)
              ? Container()
              : AspectRatio(
                  aspectRatio: _cameraController.value.aspectRatio,
                  child: CameraPreview(_cameraController),
                ),
        )));

    // ignore: unnecessary_null_comparison
    if (_cameraImage != null) {
      list.addAll(dislayBoxesAroundRecognizedObjects(size));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(top: 50),
          color: Colors.black,
          child: Stack(
            children: list,
          ),
        ),
      ),
    );
  }
}
