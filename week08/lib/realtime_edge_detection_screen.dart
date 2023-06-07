import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image_processing/flutter_image_processing.dart';
// import 'package:image/image.dart' as img;

class RealtimeEdgeDetectionScreen extends StatefulWidget {
  @override
  _RealtimeEdgeDetectionScreenState createState() =>
      _RealtimeEdgeDetectionScreenState();
}

class _RealtimeEdgeDetectionScreenState
    extends State<RealtimeEdgeDetectionScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late StreamSubscription<Uint8List> _edgeDetectionStreamSubscription;
  late Uint8List _edgeDetectionImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras[0],
      ResolutionPreset.high,
    );
    await _cameraController.initialize();
    _startEdgeDetection();
  }

  Future<void> _startEdgeDetection() async {
    if (!_cameraController.value.isInitialized) {
      return;
    }

    _edgeDetectionStreamSubscription =
    _cameraController.startImageStream((CameraImage image) async {
      if (_edgeDetectionImage != null) {
        return;
      }

      // final edgeDetectionResult =
      // detectEdgesFromImage(
      // image.planes[0].bytes,
      // image.width,
      // image.height,
      // );

      setState(() {
        // _edgeDetectionImage = edgeDetectionResult;
      });
    }) as StreamSubscription<Uint8List>;
  }

  Future<void> _stopEdgeDetection() async {
    if (_edgeDetectionStreamSubscription != null) {
      await _edgeDetectionStreamSubscription.cancel();
    }
    _edgeDetectionImage != null;
  }

  @override
  void dispose() {
    _stopEdgeDetection();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-time Edge Detection'),
      ),
      body: Stack(
        children: <Widget>[
          CameraPreview(_cameraController),
          if (_edgeDetectionImage != null)
            Positioned.fill(
              child: Image.memory(
                _edgeDetectionImage,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
