import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pdfController.dart';
import 'package:flutter_application_1/previewpdf.dart';
import 'package:flutter_application_1/widget/titles_text.dart';
import 'package:get/get.dart';

class ListOfPDF extends StatefulWidget {
  Uint8List uint8list;
  ListOfPDF({super.key, required this.uint8list});

  @override
  State<ListOfPDF> createState() => _ListOfPDFState();
}

class _ListOfPDFState extends State<ListOfPDF> {
  var height, width;
  @override
  void initState() {
    Get.put(PDFController());
    PDFController.to.m.clear();
    PDFController.to.getImage(context, widget.uint8list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder<PDFController>(builder: (obj) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff080A1B),
          title: const Text('Image Scanner'),
        ),
        body: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              InkWell(
                onTap: () {
                  obj.generatelist(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PDFPREVIEW(),
                      ));
                },
                child: Container(
                    height: height * 0.06,
                    width: width * 0.35,
                    decoration: const BoxDecoration(
                      color: Color(0xff080A1B),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                        child: Titlee(text: 'Generate PDF', width: width))),
              ),
              Expanded(
                child: Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        height: height * 0.7,
                        width: width,
                        //     color: Colors.blue,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: GridView.builder(
                              itemCount: obj.m.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // m.remove(m[index]);
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Container(
                                        height: height * 0.25,
                                        width: width * 0.45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color(0xff080A1B),
                                            width: 2,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Image.memory(obj.m[index])),
                                  ),
                                );
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
