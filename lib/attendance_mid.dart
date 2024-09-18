import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'package:intl/intl.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:wakelock_plus/wakelock_plus.dart';

import 'attendance_report.dart';
import 'ip_address.dart';
import 'view_attendance.dart';
import 'manual_attendance.dart';

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
                title: Text(
                  classes[index]['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Total Students: ${classes[index]['count']}'),
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
  List students = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.classTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton.tonalIcon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QRScanner(
                    schoolCode: widget.schoolCode,
                    classTitle: widget.classTitle,
                  ),
                )),
                label: Text('Mark Attendance'),
                icon: Icon(Icons.task_alt_rounded),
              ),
              FilledButton.tonalIcon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManualAttendance(
                      schoolCode: widget.schoolCode,
                      classTitle: widget.classTitle),
                )),
                label: Text('Manual Attendance'),
                icon: Icon(Icons.edit_square),
              ),
              FilledButton.tonalIcon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewAttendance(
                      schoolCode: widget.schoolCode,
                      classTitle: widget.classTitle),
                )),
                label: Text('View Attendance'),
                icon: Icon(Icons.view_list_rounded),
              ),
              FilledButton.tonalIcon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AttendanceReport(
                          schoolCode: widget.schoolCode,
                          classTitle: widget.classTitle,
                        ))),
                label: Text('Download Report'),
                icon: Icon(Icons.download_rounded),
              )
            ],
          ),
        ));
  }
}

class QRScanner extends StatefulWidget {
  const QRScanner({
    super.key,
    required this.schoolCode,
    required this.classTitle,
  });
  final String schoolCode;
  final String classTitle;

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool scanned = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String _selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late Future _getClassAttendance;
  List allStudents = [];
  List presentStudents = [];
  final ScrollController _scrollController = ScrollController();
  bool sendSms = false;
  bool sendCall = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      {
        // sendRequest(scanData.code);
        // String info = '';
        for (Map i in allStudents) {
          // info = '';
          if (i['admNo'] == scanData.code) {
            i['status'] = 'present';

            // if (!allStudents
            //     .any((element) => element['admNo'] == scanData.code)) {
            //   info = 'W';
            // }

            // if (info == 'W') {
            //   message = 'Wrong QR Code';
            // } else if (info == 'A') {
            //   message = 'Already Marked';
            // } else if (info == 'P') {
            //   message = 'Attendance Marked';
            // }

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     backgroundColor: info == 'W'
            //         ? Colors.red[600]
            //         : info == 'A'
            //             ? Colors.yellow[900]
            //             : Colors.green[600],
            //     behavior: SnackBarBehavior.floating,
            //     content: Row(
            //       children: [
            //         Text(
            //           message,
            //         ),
            //         Icon(
            //           info == 'true' ? Icons.check_circle : Icons.error,
            //           color: Colors.white,
            //         )
            //       ],
            //     ),
            //   ),
            // );
            // info = '';

            setState(() {
              presentStudents = allStudents
                  .where((element) => element['status'] == 'present')
                  .toList();
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent);
            });
            break;
          }
        }
      }
    });
  }

  getClassDetailsMid() async {
    var url = Uri.parse(
        '$ipv4/getAttendanceClassMid/$_selectedDate/?scCode=${Uri.encodeQueryComponent(widget.schoolCode)}&classTitle=${Uri.encodeQueryComponent(widget.classTitle)}');
    var res = await http.get(url);
    print(res.body);
    return jsonDecode(res.body);
  }

  saveAttendance() async {
    var url1 = Uri.parse('$ipv4/getApiSettings/${widget.schoolCode}');
    var res1 = await http.get(url1);
    var details = jsonDecode(res1.body);

    if (sendSms) {
      String smsText = details['smsText'];
      smsText = smsText.replaceAll("{schoolName}", details['schoolName']);
      for (Map student in allStudents) {
        String message = smsText
            .replaceAll("{studentName}", student['fullName'])
            .replaceAll("{studentStatus}", student['status']);

        sendSMS(
          message: message,
          recipients: [student['fatherMobNo'].toString()],
          sendDirect: true,
        );
      }
    }
    if (sendCall) {
      List absentStudents = allStudents
          .takeWhile((student) => student['status'] == 'absent')
          .toList();
      var res = await http.post(Uri.parse('$ipv4/midAttendanceCall'), body: {
        'schoolCode': widget.schoolCode,
        'presentStudents': jsonEncode(presentStudents),
        'absentStudents': jsonEncode(absentStudents)
      });
      if (res.body == 'false') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            content: const Row(
              children: [
                Text('No Access to call API. Contact Admin.'),
                Icon(
                  Icons.error,
                  color: Colors.white,
                )
              ],
            ),
          ),
        );
      }
    }
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/saveClassAttendanceMid');
    var res = await http.post(url, body: {
      'students': jsonEncode(allStudents),
      'date': _selectedDate,
      'schoolCode': widget.schoolCode
    });
    print(res.body);
  }

  @override
  void initState() {
    _getClassAttendance = getClassDetailsMid();
    WakelockPlus.enable();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    WakelockPlus.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: FutureBuilder(
        future: _getClassAttendance,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            allStudents = snapshot.data;
            for (Map element in allStudents) {
              element.putIfAbsent('status', () => 'absent');
            }

            presentStudents = allStudents
                .where((element) => element['status'] == 'present')
                .toList();
            int presentCount = presentStudents.length;
            // students
            //     .where((element) => element['status'] == 'present')
            //     .length;
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Students: ${snapshot.data.length}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            'Present: $presentCount',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[600]),
                          ),
                          Text(
                            'Absent: ${snapshot.data.length - presentCount}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    FilledButton.icon(
                      icon: Icon(Icons.edit_calendar_outlined),
                      onPressed: () async {
                        DateTime? datetime = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now());
                        setState(() {
                          _selectedDate =
                              DateFormat('dd-MM-yyyy').format(datetime!);
                          _getClassAttendance = getClassDetailsMid();
                        });
                      },
                      label: Text(_selectedDate),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 700,
                      height: 300,
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                        cameraFacing: CameraFacing.back,
                        overlay: QrScannerOverlayShape(
                            borderColor: Colors.red,
                            borderRadius: 10,
                            borderLength: 30,
                            borderWidth: 10,
                            cutOutSize: 250),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: presentCount,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              bottom: index == presentCount - 1 ? 50 : 0),
                          child: Card(
                            color: presentStudents[index]['status'] == 'present'
                                ? Colors.green[100]
                                : Colors.red[200],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Text(presentStudents[index]['fullName']),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FilledButton(
                    onPressed: saveAttendance,
                    style: FilledButton.styleFrom(
                      shape: LinearBorder(),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Checkbox(
                          fillColor: MaterialStateProperty.all(Colors.white),
                          checkColor: Theme.of(context).colorScheme.primary,
                          value: sendSms,
                          onChanged: (value) {
                            setState(() {
                              sendSms = value!;
                            });
                          },
                        ),
                        Text('Send Sms'),
                        Checkbox(
                          fillColor: MaterialStateProperty.all(Colors.white),
                          checkColor: Theme.of(context).colorScheme.primary,
                          value: sendCall,
                          onChanged: (value) {
                            setState(() {
                              sendCall = value!;
                            });
                          },
                        ),
                        Text('Send Call'),
                        Flexible(
                          child: SizedBox(
                            width: 50,
                          ),
                        ),
                        Text('Submit'),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
