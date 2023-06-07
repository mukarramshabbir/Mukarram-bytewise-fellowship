import 'dart:async';
import 'dart:isolate';
import 'dart:js_interop';
import 'dart:js_util';

import 'package:edge_detection/edge_detection.dart';
import 'package:week08/edge_detection_result.dart';
// import 'package:simple_edge_detection/edge_detection.dart';

class EdgeDetector {
  static Future<void> startEdgeDetectionIsolate(
      EdgeDetectionInput edgeDetectionInput) async {
    EdgeDetectionResult result =
        await EdgeDetector().detectEdges(edgeDetectionInput.inputPath);
    edgeDetectionInput.sendPort.send(result);
  }

  static Future<void> processImageIsolate(
      ProcessImageInput processImageInput) async {
    EdgeDetector().processImage(
        processImageInput.inputPath, processImageInput.edgeDetectionResult);
    processImageInput.sendPort.send(true);
  }

  Future<EdgeDetectionResult> detectEdges(String filePath) async {
    final port = ReceivePort();

    _spawnIsolate<EdgeDetectionInput>(startEdgeDetectionIsolate,
        EdgeDetectionInput(inputPath: filePath, sendPort: port.sendPort), port);

    return await _subscribeToPort<EdgeDetectionResult>(port);
  }

  Future<bool> processImage(
      String filePath, EdgeDetectionResult edgeDetectionResult) async {
    final port = ReceivePort();

    _spawnIsolate<ProcessImageInput>(
        processImageIsolate,
        ProcessImageInput(
            inputPath: filePath,
            edgeDetectionResult: edgeDetectionResult,
            sendPort: port.sendPort),
        port);

    return await _subscribeToPort<bool>(port);
  }

  void _spawnIsolate<T>(Function function, dynamic input, ReceivePort port) {
    Isolate.spawn<T>(
        // debugName: '',
        // paused: bool.fromEnvironment('paused', defaultValue: false)
        // function,
        // port
        function as void Function(T message),
        input,
        onError: port.sendPort,
        onExit: port.sendPort);
  }

  Future<T> _subscribeToPort<T>(ReceivePort port) async {
    StreamSubscription sub;

    var completer = new Completer<T>();
    sub = subtract(port, completer);

    sub = port.listen((result) async {
      await sub.cancel();
      completer.complete(await result);
    });

    return completer.future;
  }
}

class EdgeDetectionInput {
  EdgeDetectionInput({required this.inputPath, required this.sendPort});

  String inputPath;
  SendPort sendPort;
}

class ProcessImageInput {
  ProcessImageInput(
      {required this.inputPath,
      required this.edgeDetectionResult,
      required this.sendPort});

  String inputPath;
  EdgeDetectionResult edgeDetectionResult;
  SendPort sendPort;
}
