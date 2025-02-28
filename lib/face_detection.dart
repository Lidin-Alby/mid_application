import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:mid_application/ip_address.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:image/image.dart ' as imgPac;

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  PlatformFile? plFile;
  Uint8List? img;
  Uint8List? cimg;

  FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(
    minFaceSize: 0.5,
  ));
  @override
  Widget build(BuildContext context) {
    // var canvas = ui.Canvas();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          ElevatedButton(
            child: Text('Pick'),
            onPressed: () async {
              var url = Uri.parse('$ipv4/img/101/5155_100_Pooja Yadav_.jpg');
              //5155_10_Divyansh Patel_.jpg
              //5155_1_Arju verma_.jpg
              //5155_100_Pooja Yadav_.jpg
              var res = await http.get(url);

              setState(() {
                img = res.bodyBytes;
              });
            },
          ),
          if (img != null) SizedBox(height: 300, child: Image.memory(img!)),
          ElevatedButton(
              onPressed: () async {
                final tempDir = await getTemporaryDirectory();
                File file =
                    await File('${tempDir.path}/img').writeAsBytes(img!);

                final finalImg = InputImage.fromFile(file);
                List<Face> faces = await faceDetector.processImage(finalImg);
                final boundingBox = faces[0].boundingBox;

                //494 302
                final ogImg = imgPac.decodeImage(img!);
                final croppedImg = imgPac.copyCrop(ogImg!,
                    x: boundingBox.left.toInt() - 110,
                    y: boundingBox.top.toInt() - 100,
                    width: 500,
                    height: boundingBox.bottom.toInt() + 50);
                final resized = imgPac.copyResize(croppedImg, height: 150);

                setState(() {
                  //  imgPac.encodePng(croppedImg);

                  cimg = imgPac.encodePng(croppedImg);
                });

                // File('croppedImg.png').writeAsBytesSync(imgPac.encodePng(croppedImg));
              },
              child: Text('Process')),
          if (cimg != null) Image.memory(cimg!),
          SizedBox(
            height: 50,
          )
        ]),
      ),
    );
  }
}
