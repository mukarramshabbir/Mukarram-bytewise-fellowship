import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/mobile_scanner_page.dart';
import 'package:flutter_application_1/plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PluginScreen(),
    );
  }
}

class PluginScreen extends StatefulWidget {
  const PluginScreen({super.key});

  @override
  State<PluginScreen> createState() => _PluginScreenState();
}

class _PluginScreenState extends State<PluginScreen> {
  Future<void> initHomePageState() async {
    if (licenseStatus == NOT_CHECKED) {
      int? ret = await flutterDocumentScanSdkPlugin.init(
          "DLS2eyJoYW5kc2hha2VDb2RlIjoiMTAxOTc5MDA5LVRYbE5iMkpwYkdWUWNtOXFYMlJrYmciLCJtYWluU2VydmVyVVJMIjoiaHR0cHM6Ly9tZGxzLmR5bmFtc29mdG9ubGluZS5jb20iLCJvcmdhbml6YXRpb25JRCI6IjEwMTk3OTAwOSIsImNoZWNrQ29kZSI6LTc3MjUxMzg0NX0=");
      if (ret != null) {
        setState(() {
          licenseStatus = ret;
        });
      }
    }
  }

  @override
  void initState() {
    initHomePageState().then((value) {
      if (licenseStatus == 0) {
        if (Platform.isAndroid || Platform.isIOS) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MobileScannerPage(
                title: 'Document Scanner',
              ),
            ),
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xff080A1B),
        body: Center(
            child: Text(
          "Loading...",
          style: TextStyle(
            color: Colors.white,
          ),
        )));
  }
}
