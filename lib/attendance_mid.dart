import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import 'ip_address.dart';
import 'attendance_details.dart';

class AttendanceMid extends StatefulWidget {
  const AttendanceMid({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<AttendanceMid> createState() => _AttendanceMidState();
}

class _AttendanceMidState extends State<AttendanceMid> {
  late Future _getClasses;

  getClass() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getMidClasses/${widget.schoolCode}');
    var res = await http.get(url);
    Map data = jsonDecode(res.body);

    return data;
  }

  @override
  void initState() {
    _getClasses = getClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark Attendance'),
      ),
      body: FutureBuilder(
        future: _getClasses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List classes = snapshot.data['classes'];
            return ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) => Card(
                  child: ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EachClassPage(
                    schoolCode: widget.schoolCode,
                    classTitle: classes[index]['title'],
                  ),
                )),
                title: Text(classes[index]['title']),
              )),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class EachClassPage extends StatefulWidget {
  const EachClassPage(
      {super.key, required this.schoolCode, required this.classTitle});
  final String schoolCode;
  final String classTitle;

  @override
  State<EachClassPage> createState() => _EachClassPageState();
}

class _EachClassPageState extends State<EachClassPage> {
  late Future _getStudents;

  getStudentsEachClass() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse(
        '$ipv4/eachClassMid/${widget.schoolCode}/${widget.classTitle}');
    var res = await http.get(url);

    print('done');
    print(res.body);
    List data = jsonDecode(res.body);

    return data;
  }

  @override
  void initState() {
    _getStudents = getStudentsEachClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.classTitle),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QRScanner(
                        schoolCode: widget.schoolCode,
                      ),
                    )),
                icon: Icon(Icons.qr_code_scanner))
          ],
        ),
        body: FutureBuilder(
          future: _getStudents,
          builder: (context, snapshot) {
            List students = [];
            if (snapshot.hasData) {
              students = snapshot.data;
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 40,
                    ),
                    title: Text(students[index]['fullName']),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AttendanceDetails(
                                schoolCode: widget.schoolCode,
                                admNo: students[index]['admNo'],
                              )),
                    ),
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

class QRScanner extends StatefulWidget {
  const QRScanner({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool scanned = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print(scanData.code);
      if (scanned) {
        return;
      } else {
        sendRequest(scanData.code);
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => Scaffold(
        //     appBar: AppBar(),
        //     body: Text(
        //       'Attendance Marked',
        //       style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ));
      }
      setState(() {
        scanned = true;
      });

      // Handle scanned data (QR code content)
      // _handleDeepLink(scanData.code);
    });
  }

  sendRequest(String? data) async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/markMidAttendance');
    var res = await http
        .post(url, body: {'admNo': data, 'schoolCode': widget.schoolCode});
    print(res.body);
    String message = '';
    if (res.body == 'W') {
      message = 'Wrong QR Code';
    } else if (res.body == 'A') {
      message = 'Already Marked';
    } else {
      message = 'Attendance Marked';
    }
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: res.body == 'W'
              ? Colors.red[600]
              : res.body == 'A'
                  ? Colors.yellow[900]
                  : Colors.green[600],
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Text(
                message,
              ),
              Icon(
                res.body == 'true' ? Icons.check_circle : Icons.error,
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // encrpt();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  // encrpt() {
  //   final String plain = 'hello';
  //   final key = enpt.Key.fromUtf8('qwertyuioplkjhgfdsazxcvbnmpoiuyt');
  //   final iv = enpt.IV.fromLength(16);
  //   final encrypter = enpt.Encrypter(enpt.AES(key));
  //   final encrypted = encrypter.encrypt(plain, iv: iv);
  //   final decrypted = encrypter.decrypt(encrypted, iv: iv);

  //   print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  //   print(encrypted.base64);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Center(
        child: SizedBox(
          width: 700,
          height: 400,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            cameraFacing: CameraFacing.front,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300),
          ),
        ),
      ),
    );
  }
}
