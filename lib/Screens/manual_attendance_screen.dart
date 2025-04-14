import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mid_application/Blocs/Attendance/attendance_bloc.dart';
import 'package:mid_application/Blocs/Attendance/attendance_event.dart';
import 'package:mid_application/Blocs/Attendance/attendance_state.dart';
import 'package:mid_application/models/attendance.dart';
import 'package:mid_application/widgets/attendance_action_dialog.dart';
import 'package:mid_application/widgets/attendance_app_bar.dart';
import 'package:mid_application/widgets/attendance_call_sms_dialog.dart';
import 'package:mid_application/widgets/attendance_notation.dart';
import 'package:mid_application/widgets/counts_column_attendance.dart';
import 'package:mid_application/widgets/profile_pic.dart';

class ManualAttendanceScreen extends StatefulWidget {
  const ManualAttendanceScreen(
      {super.key, required this.classTitle, required this.schoolCode});
  final String classTitle;
  final String schoolCode;

  @override
  State<ManualAttendanceScreen> createState() => _ManualAttendanceScreenState();
}

class _ManualAttendanceScreenState extends State<ManualAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  int? _selectedShare;
  List<Attendance> attendances = [];

  @override
  void initState() {
    context.read<AttendanceBloc>().add(
          LoadAttendance(
            schoolCode: widget.schoolCode,
            classTitle: widget.classTitle,
            date: DateFormat('dd-MM-yyyy').format(_selectedDate),
          ),
        );
    super.initState();
  }

  Color getColor(String? status) {
    Color color = Colors.green;
    switch (status) {
      case 'absent':
        color = Theme.of(context).colorScheme.error;
        break;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AttendanceAppBar(classTitle: widget.classTitle),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AttendanceLoadError) {
              return FilledButton(
                onPressed: () {
                  context.read<AttendanceBloc>().add(
                        LoadAttendance(
                            schoolCode: widget.schoolCode,
                            classTitle: widget.classTitle,
                            date: DateFormat('ddMM-yyy').format(_selectedDate)),
                      );
                },
                child: Text('Retry'),
              );
            } else {
              if (state is AttendanceLoaded) {
                attendances = state.students;
              }

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
                  SizedBox(
                    height: 20,
                  ),
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
                          count: attendances.length.toString(),
                          icon: Icons.person_outline_rounded,
                          label: 'Students', textColor: Colors.white,
                          // iconSize: 20,
                        ),
                        CountsColumnAttendance(
                          count: absentCount.toString(),
                          icon: Icons.dangerous,
                          iconColor: Theme.of(context).colorScheme.error,
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
                    child: ListView.builder(
                        itemCount: attendances.length,
                        itemBuilder: (context, index) {
                          Attendance student = attendances[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 120,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(245, 243, 244, 1),
                                border: Border.all(
                                    color: getColor(student.status))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    ProfilePicWidget(
                                      profilePic: student.profilePic.toString(),
                                      schoolCode: widget.schoolCode,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          student.fullName,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Student',
                                          style: TextStyle(
                                            fontSize: 10,
                                            // fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          if (_selectedShare == index)
                                            Row(
                                              spacing: 3,
                                              children: [
                                                SizedBox(),
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: TextButton(
                                                    onPressed: () => showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AttendanceActionDialog(
                                                        fatherNo:
                                                            student.fatherMobNo,
                                                        motherNo:
                                                            student.motherMobNo,
                                                        type: 'tel',
                                                      ),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                        shape: CircleBorder(),
                                                        padding:
                                                            EdgeInsets.zero),
                                                    child: Icon(
                                                      Icons.call_outlined,
                                                      color: Colors.blue,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: TextButton(
                                                    onPressed: () => showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AttendanceActionDialog(
                                                        fatherNo:
                                                            student.fatherMobNo,
                                                        motherNo:
                                                            student.motherMobNo,
                                                        type: 'sms',
                                                      ),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                        shape: CircleBorder(),
                                                        padding:
                                                            EdgeInsets.zero),
                                                    child: Icon(
                                                      Icons.message_outlined,
                                                      color: Colors.indigo,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: TextButton(
                                                    onPressed: () => showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AttendanceActionDialog(
                                                        fatherNo: student
                                                            .fatherWhatsApp,
                                                        motherNo: student
                                                            .motherWhatsApp,
                                                        type: 'whatsapp',
                                                      ),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                        shape: CircleBorder(),
                                                        padding:
                                                            EdgeInsets.zero),
                                                    child: Icon(
                                                      FontAwesomeIcons.whatsapp,
                                                      color: Colors.green,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(),
                                              ],
                                            ),
                                          SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: FilledButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_selectedShare == index) {
                                                    _selectedShare = null;
                                                  } else {
                                                    _selectedShare = index;
                                                  }
                                                });
                                              },
                                              style: FilledButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                shape: CircleBorder(),
                                              ),
                                              child: Icon(
                                                color: _selectedShare == index
                                                    ? Colors.white
                                                    : Colors.black,
                                                FontAwesomeIcons.share,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 42,
                                              child: Text(
                                                'Father',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                              child: Text(
                                                ':',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              student.fatherName.toString(),
                                              style: TextStyle(
                                                fontSize: 9,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 42,
                                              child: Text(
                                                'Mother',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                              child: Text(
                                                ':',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              student.motherName.toString(),
                                              style: TextStyle(
                                                fontSize: 9,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 60,
                                      padding: EdgeInsets.only(left: 8, top: 2),
                                      color: Colors.white,
                                      child: 
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              AttendanceNotation(
                                                notation: 'P',
                                                groupValue: student.status!,
                                                label: 'Present',
                                                value: 'present',
                                                color: Colors.green,
                                                onChanged: (value) {
                                                  student.status = value;
                                                  context
                                                      .read<AttendanceBloc>()
                                                      .add(UpdateStatus(
                                                          attendances));
                                                },
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              AttendanceNotation(
                                                groupValue: student.status!,
                                                notation: 'H',
                                                label: 'Half Day',
                                                value: 'half',
                                                color: Colors.brown[600],
                                                onChanged: (value) {
                                                  student.status = value;
                                                  context
                                                      .read<AttendanceBloc>()
                                                      .add(UpdateStatus(
                                                          attendances));
                                                },
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              AttendanceNotation(
                                                groupValue: student.status!,
                                                notation: 'L',
                                                label: 'Leave',
                                                value: 'leave',
                                                color: Colors.amber,
                                                horizontalPadding: 8,
                                                onChanged: (value) {
                                                  student.status = value;
                                                  context
                                                      .read<AttendanceBloc>()
                                                      .add(UpdateStatus(
                                                          attendances));
                                                },
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              AttendanceNotation(
                                                groupValue: student.status!,
                                                notation: 'A',
                                                label: 'Absent',
                                                value: 'absent',
                                                horizontalPadding: 8,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error,
                                                onChanged: (value) {
                                                  student.status = value;
                                                  context
                                                      .read<AttendanceBloc>()
                                                      .add(UpdateStatus(
                                                          attendances));
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  // Spacer(),
                  SizedBox(
                    height: 15,
                  ),
                  state is SaveAttendanceLoading
                      ? Center(child: CircularProgressIndicator())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => AttendanceCallSmsDialog(
                                    onConfirm: (
                                      smsAbsent,
                                      smsPresent,
                                      callAbsent,
                                      callPresent,
                                    ) {
                                      context.read<AttendanceBloc>().add(
                                          SaveClassAttendance(attendances));
                                    },
                                  ),
                                ),
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
          },
        ),
      ),
    );
  }
}
