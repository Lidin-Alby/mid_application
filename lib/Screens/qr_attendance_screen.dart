import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mid_application/Blocs/Attendance/attendance_bloc.dart';
import 'package:mid_application/Blocs/Attendance/attendance_event.dart';
import 'package:mid_application/Blocs/Attendance/attendance_state.dart';
import 'package:mid_application/models/attendance.dart';
import 'package:mid_application/widgets/attendance_app_bar.dart';
import 'package:mid_application/widgets/counts_column_attendance.dart';
import 'package:mid_application/widgets/profile_pic.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

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
  List<Attendance> attendances = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WakelockPlus.enable();

    context.read<AttendanceBloc>().add(
          LoadAttendance(
            schoolCode: widget.schoolCode,
            classTitle: widget.classTitle,
            date: DateFormat('dd-MM-yyyy').format(_selectedDate),
          ),
        );
    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  update(Barcode scanData) {
    for (Attendance student in attendances) {
      if (student.admNo == scanData.code) {
        Attendance s = student;
        s.status = 'present';
        attendances.remove(student);
        attendances.add(s);

        context.read<AttendanceBloc>().add(UpdateStatus(attendances));
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AttendanceAppBar(
          classTitle: widget.classTitle,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              width: 400,
              child: QRView(
                key: GlobalKey(debugLabel: 'Qr'),
                overlay: QrScannerOverlayShape(
                    cutOutSize: 160,
                    borderWidth: 6,
                    borderColor: Theme.of(context).colorScheme.primary),
                onQRViewCreated: (qrViewController) {
                  qrViewController.scannedDataStream.listen(
                    (scanData) {
                      update(scanData);
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                    if (state is AttendanceLoaded) {
                      attendances = state.students;
                      int presentCount = 0;
                      int absentCount = 0;
                      for (Attendance student in attendances) {
                        if (student.status == 'present') {
                          presentCount++;
                        } else {
                          absentCount++;
                        }
                      }

                      return Column(
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
                                  count: absentCount.toString(),
                                  icon: Icons.dangerous,
                                  iconColor:
                                      Theme.of(context).colorScheme.error,
                                  label: 'Absent',
                                  textColor: Colors.white,
                                ),
                                CountsColumnAttendance(
                                  count: presentCount.toString(),
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
                              onPressed: () async {
                                DateTime? date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  setState(() {
                                    _selectedDate = date;
                                  });
                                }
                              },
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
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 252, 242, 1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Color.fromRGBO(220, 220, 220, 1),
                                ),
                              ),
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    for (Attendance student in attendances)
                                      if (student.status == 'present')
                                        Container(
                                          height: 60,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color.fromRGBO(
                                                  220, 220, 220, 1),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              ProfilePicWidget(
                                                profilePic: student.profilePic
                                                    .toString(),
                                                schoolCode: widget.schoolCode,
                                                size: 40,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    student.fullName,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Admission No. - ${student.admNo}',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          55, 55, 55, 1),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                    SizedBox(
                                      height: 10,
                                    )
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
                                  onPressed: () {
                                    // print(state.students[0].status);
                                    // setState(() {
                                    //   state.students[0].status = 'present';
                                    // });
                                    // print(state.students[0].status);
                                  },
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
                      );
                    }
                    if (state is AttendanceLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is AttendanceLoadError) {
                      return FilledButton(
                        onPressed: () {
                          context.read<AttendanceBloc>().add(
                                LoadAttendance(
                                    schoolCode: widget.schoolCode,
                                    classTitle: widget.classTitle,
                                    date: DateFormat('ddMM-yyy')
                                        .format(_selectedDate)),
                              );
                        },
                        child: Text('Retry'),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            )
          ],
        ));
  }
}
