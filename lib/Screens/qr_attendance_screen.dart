import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mid_application/widgets/counts_column_attendance.dart';
import 'package:mid_application/widgets/profile_pic.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrAttendanceScreen extends StatefulWidget {
  const QrAttendanceScreen(
      {super.key,
      required this.classTitle,
      required this.totalStudents,
      required this.schoolCode});
  final String classTitle;
  final int totalStudents;
  final String schoolCode;

  @override
  State<QrAttendanceScreen> createState() => _QrAttendanceScreenState();
}

class _QrAttendanceScreenState extends State<QrAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            width: 43,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all()),
            child: Text(
              widget.classTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: 400,
            // child: QRView(
            //   key: GlobalKey(debugLabel: 'Qr'),
            //   overlay: QrScannerOverlayShape(
            //       cutOutSize: 160,
            //       borderWidth: 6,
            //       borderColor: Theme.of(context).colorScheme.primary),
            //   onQRViewCreated: (p0) {},
            // ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 130,
                    // margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(37, 36, 34, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CountsColumnAttendance(
                          count: widget.totalStudents.toString(),
                          icon: Icons.person_outline_rounded,
                          label: 'Students', textColor: Colors.white,
                          // iconSize: 20,
                        ),
                        CountsColumnAttendance(
                          count: '258',
                          icon: Icons.dangerous,
                          iconColor: Theme.of(context).colorScheme.error,
                          label: 'Absent',
                          textColor: Colors.white,
                        ),
                        CountsColumnAttendance(
                          count: '258',
                          icon: Icons.check_box,
                          iconColor: Colors.green,
                          label: 'Present',
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 27,
                    child: FilledButton.icon(
                      onPressed: () {},
                      label: Text(
                        DateFormat('dd-MM-yyyy').format(_selectedDate),
                        style: TextStyle(fontSize: 11),
                      ),
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      icon: Icon(Icons.calendar_month_outlined),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 252, 242, 1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Color.fromRGBO(220, 220, 220, 1),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 60,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                border: Border.all(
                                  color: Color.fromRGBO(220, 220, 220, 1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  ProfilePicWidget(
                                    profilePic: 'profilePic',
                                    schoolCode: widget.schoolCode,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Abinanth Shukla',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Admission No. - 1520',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                Color.fromRGBO(55, 55, 55, 1)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Save'),
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Cancel'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
