  import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/document_page.dart';
import 'package:flutter_application_1/image_painter.dart';
import 'package:flutter_application_1/models/document_data.dart';
import 'dart:ui' as ui;

import 'package:flutter_document_scan_sdk/document_result.dart';
import 'package:flutter_document_scan_sdk/flutter_document_scan_sdk_platform_interface.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

import 'package:camera/camera.dart';
import 'plugin.dart';

class MobileScannerPage extends StatefulWidget {
  const MobileScannerPage({super.key, required this.title});
  final String title;

  @override
  State<MobileScannerPage> createState() => _MobileScannerPageState();
}

class _MobileScannerPageState extends State<MobileScannerPage>
    with WidgetsBindingObserver {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  final List<String> _cameraNames = [''];
  List<DocumentResult>? _detectionResults = [];
  Size? _previewSize;
  DocumentData? _documentData;
  bool _enableCapture = false;
  bool _isScanAvailable = true;

  @override
  void initState() {
    super.initState();
    stopVideo();
    WidgetsBinding.instance.addObserver(this);
    initCamera();
  }

  Future<void> toggleCamera(int index) async {
    if (_controller != null) _controller!.dispose();

    _controller = CameraController(_cameras[index], ResolutionPreset.max);
    _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }

      _previewSize = _controller!.value.previewSize;
      setState(() {});

      startVideo();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  Future<void> initCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      toggleCamera(0);
    } on CameraException catch (e) {
      print(e);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      toggleCamera(0);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopVideo();
    super.dispose();
  }

  Widget getCameraWidget() {
    if (!_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    } else {
      // https://stackoverflow.com/questions/49946153/flutter-camera-appears-stretched
      final size = MediaQuery.of(context).size;
      var scale = size.aspectRatio * _controller!.value.aspectRatio;

      if (scale < 1) scale = 1 / scale;

      return Transform.scale(
        scale: scale,
        child: Center(
          child: CameraPreview(_controller!),
        ),
      );
    }
  }

  List<DocumentResult> rotate90(List<DocumentResult>? input) {
    if (input == null) {
      return [];
    }

    List<DocumentResult> output = [];
    for (DocumentResult result in input) {
      double x1 = result.points[0].dx;
      double x2 = result.points[1].dx;
      double x3 = result.points[2].dx;
      double x4 = result.points[3].dx;
      double y1 = result.points[0].dy;
      double y2 = result.points[1].dy;
      double y3 = result.points[2].dy;
      double y4 = result.points[3].dy;

      List<Offset> points = [
        Offset(_previewSize!.height.toInt() - y1, x1),
        Offset(_previewSize!.height.toInt() - y2, x2),
        Offset(_previewSize!.height.toInt() - y3, x3),
        Offset(_previewSize!.height.toInt() - y4, x4)
      ];
      DocumentResult newResult = DocumentResult(result.confidence, points, []);

      output.add(newResult);
    }

    return output;
  }

  void stopVideo() async {
    if (_controller == null) return;
    await _controller!.stopImageStream();
    _controller!.dispose();
    _controller = null;
  }

  void startVideo() async {
    await _controller!.startImageStream((CameraImage availableImage) async {
      assert(defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);
      int format = ImagePixelFormat.IPF_NV21.index;

      switch (availableImage.format.group) {
        case ImageFormatGroup.yuv420:
          format = ImagePixelFormat.IPF_NV21.index;
          break;
        case ImageFormatGroup.bgra8888:
          format = ImagePixelFormat.IPF_ARGB_8888.index;
          break;
        default:
          format = ImagePixelFormat.IPF_RGB_888.index;
      }

      if (!_isScanAvailable) {
        return;
      }

      _isScanAvailable = false;

      flutterDocumentScanSdkPlugin
          .detectBuffer(
              availableImage.planes[0].bytes,
              availableImage.width,
              availableImage.height,
              availableImage.planes[0].bytesPerRow,
              format)
          .then((results) {
        if (MediaQuery.of(context).size.width <
            MediaQuery.of(context).size.height) {
          if (Platform.isAndroid) {
            results = rotate90(results);
          }
        }
        setState(() {
          _detectionResults = results;
        });

        _isScanAvailable = true;

        if (_enableCapture &&
            _detectionResults != null &&
            _detectionResults!.isNotEmpty) {
          _enableCapture = false;
          _controller!.stopImageStream();
          _controller!.takePicture().then((XFile file) async {
            File rotatedImage =
                await FlutterExifRotation.rotateImage(path: file.path);
            XFile rotatedFile = XFile(rotatedImage.path);
            final coordinates =
                await flutterDocumentScanSdkPlugin.detectFile(rotatedFile.path);
            final data = await rotatedFile.readAsBytes();
            decodeImageFromList(data).then((ui.Image value) {
              _documentData = DocumentData(
                image: value,
                detectionResults: coordinates,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentPage(
                    sourceImage: _documentData!.image!,
                    detectionResults: _documentData!.detectionResults!,
                  ),
                ),
              ).then((value) => startVideo());
            });
          });
        }
      }).catchError((error) {
        _isScanAvailable = true;
      });
    });
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
        // override the pop action
        onWillPop: () async {
          // stopVideo();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff080A1B),
            leading: Center(
              child: Container(
                height: height * 0.045,
                width: width * 0.09,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white.withOpacity(0.3)),
                child: const Center(
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Stack(
                      children: [
                        _controller == null || _previewSize == null
                            ? Image.asset(
                                'images/default.png',
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width <
                                        MediaQuery.of(context).size.height
                                    ? _previewSize!.height
                                    : _previewSize!.width,
                                height: MediaQuery.of(context).size.width <
                                        MediaQuery.of(context).size.height
                                    ? _previewSize!.width
                                    : _previewSize!.height,
                                child: CameraPreview(_controller!)),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: _detectionResults == null ||
                                  _detectionResults!.isEmpty
                              ? Container(
                                  color: Colors.black.withOpacity(0.1),
                                  child: const Center(
                                    child: Text(
                                      'No document detected',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ))
                              : CustomPaint(
                                  painter:
                                      ImagePainter(null, _detectionResults!),
                                ),
                        ),
                      ],
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: height * 0.25,
                  width: width,
                  color: const Color(0xff080A1B),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width * 0.05,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'SINGLE',
                              style: TextStyle(
                                  fontSize: width * 0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'BATCH',
                              style: TextStyle(
                                  fontSize: width * 0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width * 0.12,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.description_outlined,
                                color: Colors.white,
                                size: width * 0.06,
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.015),
                          InkWell(
                            onTap: () async {
                              _enableCapture = true;
                            },
                            child: Container(
                              width: width * 0.14,
                              height: height * 0.07,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: width * 0.12,
                                  height: height * 0.06,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.25,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
