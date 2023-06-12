import 'dart:math';
import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:pdf/widgets.dart' as pw;

class PDFController extends GetxController {
  static PDFController get to => Get.find();

  /// detection

  List<Uint8List> m = [];

  Future<void> getImage(BuildContext context, Uint8List uint8list) async {
    try {
      m.add(uint8list);
      update();
      generatelist(context);
    } catch (e) {
      print(e);
    }
  }

//// pdf
  List<pw.Widget> generatedbuildList = [];
  generatelist(BuildContext context) async {
    generatedbuildList.clear();
    for (int a = 0; a < m.length; a++) {
      final memoryimage = pw.MemoryImage(m[a]);
      generatedbuildList.add(
        pw.Expanded(
          child: pw.Container(
            height: 700,
            width: 500,
            child: pw.Center(
              child: pw.Image(
                fit: pw.BoxFit.contain,
                memoryimage,
                alignment: pw.Alignment.center,
              ),
            ),
          ),
        ),
      );
      update();
    }
  }

  Uint8List? data;
  Future<Uint8List> mcreatePDF() async {
    var pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => generatedbuildList,
      ),
    );
    data = await pdf.save();
    update();
    return pdf.save();
  }

// save pdf
  savePDF(Uint8List bytes, context) async {
    bool a = await Permission.storage.request() == PermissionStatus.granted;
    if (!a) {
      a = await Permission.storage.request() == PermissionStatus.granted;
    }
    if (a) {
      final rand = Random().nextInt(10000000);
      await FilePickerWritable().openFileForCreate(
        fileName: 'Document$rand.pdf',
        writer: (file) async {
          await file.writeAsBytes(bytes);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const PluginScreen(),
          //     ));
        },
      );
    }
  }
}
