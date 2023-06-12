import 'package:flutter/material.dart';
import 'package:flutter_application_1/pdfController.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';

import 'package:printing/printing.dart';

class PDFPREVIEW extends StatefulWidget {
  const PDFPREVIEW({super.key});

  @override
  State<PDFPREVIEW> createState() => _PDFPREVIEWState();
}

class _PDFPREVIEWState extends State<PDFPREVIEW> {
  PrintingInfo? printingInfo;
  Future ini() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  void initState() {
    ini();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PDFController>(
      initState: (state) {
        Get.put(PDFController());
      },
      builder: (obj) {
        return PdfPreview(
          actions: [
            PdfPreviewAction(
              icon: const Icon(Icons.save_alt_rounded),
              onPressed: (context, build, pageFormat) {
                print("bjkgkg");
                obj.savePDF(obj.data!, context);
              },
            ),
          ],
          initialPageFormat: PdfPageFormat.a4,
          allowPrinting: false,
          allowSharing: true,
          canChangePageFormat: false,
          canChangeOrientation: false,
          build: (format) => obj.mcreatePDF(),
        );
      },
    );
  }
}
