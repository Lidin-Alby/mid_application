import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mid_application/Blocs/Attendance/attendance_bloc.dart';
import 'package:mid_application/Blocs/Attendance/attendance_event.dart';
import 'package:mid_application/Blocs/Attendance/attendance_state.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/widgets/attendance_app_bar.dart';
import 'package:mid_application/widgets/attendance_notation.dart';

class ViewAttendanceCalendarScreen extends StatefulWidget {
  const ViewAttendanceCalendarScreen(
      {super.key, required this.classTitle, required this.student});
  final String classTitle;
  final Student student;

  @override
  State<ViewAttendanceCalendarScreen> createState() =>
      _ViewAttendanceCalendarScreenState();
}

class _ViewAttendanceCalendarScreenState
    extends State<ViewAttendanceCalendarScreen> {
  DateTime selectedMonth = DateTime.now();
  late DateTime selectedDate;
  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String? selectedDateStatus;
  Color? getColor(String? status, bool text) {
    Color? color;
    if (text) {
      if (status != 'present' && status != null) {
        return Colors.white;
      }
    }
    switch (status) {
      case 'absent':
        color = Theme.of(context).colorScheme.error;
        break;
      case 'half':
        color = Colors.brown;
        break;
      case 'leave':
        color = Colors.amber;
        break;
    }

    return color;
  }

  @override
  void initState() {
    selectedDate = today;

    selectedDateStatus = DateFormat('dd-MM-yyyy').format(selectedDate);
    context
        .read<AttendanceBloc>()
        .add(LoadIndividualAttendance(widget.student, selectedMonth));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List dates = [];

    List weeks = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final firstDay = DateTime(selectedMonth.year, selectedMonth.month, 1);

    final lastDay = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

    for (int i = firstDay.day - 1; i < lastDay.day; i++) {
      dates.add(firstDay.add(Duration(days: i)));
    }

    return Scaffold(
      appBar: AttendanceAppBar(classTitle: widget.classTitle),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is SaveAttendanceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Saved Successfully'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is IndividualAttendanceLoaded) {
            Map<String, dynamic> attendance = state.attendance;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(3)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 3,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy').format(selectedDate),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    // margin:
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.25))
                    ]),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  iconSize: 15,
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () {
                                    setState(() {
                                      selectedMonth = selectedMonth
                                          .subtract(Duration(days: 30));
                                    });
                                    context.read<AttendanceBloc>().add(
                                        LoadIndividualAttendance(
                                            widget.student, selectedMonth));
                                  },
                                  icon: Icon(Icons.arrow_back_ios),
                                ),
                                Text(
                                  DateFormat('MMMM').format(selectedMonth),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  iconSize: 15,
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () {
                                    setState(() {
                                      selectedMonth =
                                          selectedMonth.add(Duration(days: 30));
                                    });
                                    context.read<AttendanceBloc>().add(
                                        LoadIndividualAttendance(
                                            widget.student, selectedMonth));
                                  },
                                  icon: Icon(Icons.arrow_forward_ios),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 7,
                              children: [
                                for (String w in weeks)
                                  Center(
                                    child: Text(
                                      w,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                if (firstDay.weekday != 7)
                                  for (int i = 0; i < firstDay.weekday; i++)
                                    const SizedBox(),
                                for (DateTime date in dates)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedDate = date;
                                        selectedDateStatus =
                                            DateFormat('dd-MM-yyyy')
                                                .format(selectedDate);
                                      });
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          color: date == selectedDate
                                              ? Colors.black12
                                              : null,
                                          border: date == today
                                              ? Border.all(
                                                  color: Colors.black26)
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Container(
                                        margin: EdgeInsets.all(6),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              width: 4,
                                              color: attendance[DateFormat(
                                                              'dd-MM-yyyy')
                                                          .format(date)] ==
                                                      'present'
                                                  ? Colors.green
                                                  : Colors.transparent),
                                          color: getColor(
                                              attendance[
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date)],
                                              false),
                                        ),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: date.weekday == 7
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .error
                                                : getColor(
                                                    attendance[
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(date)],
                                                    true),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 252, 242, 1),
                      border: Border.all(
                        color: Color.fromRGBO(220, 220, 220, 1),
                      ),
                    ),
                    child: Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AttendanceNotation(
                              notation: 'P',
                              labelSize: 15,
                              notationSize: 26,
                              notationFontSize: 16,
                              notationLabelSpacing: 10,
                              groupValue: attendance[DateFormat('dd-MM-yyyy')
                                  .format(selectedDate)],
                              label: 'Present',
                              value: 'present',
                              color: Colors.green,
                              onChanged: (value) {
                                context.read<AttendanceBloc>().add(
                                      UpdateSingleStatus(
                                        attendance: attendance,
                                        date: DateFormat('dd-MM-yyyy')
                                            .format(selectedDate),
                                        status: value!,
                                        admNo: widget.student.admNo,
                                        schoolCode: widget.student.schoolCode,
                                      ),
                                    );
                              },
                            ),
                            AttendanceNotation(
                              labelSize: 15,
                              notationSize: 26,
                              notationFontSize: 16,
                              notationLabelSpacing: 10,
                              groupValue: attendance[DateFormat('dd-MM-yyyy')
                                  .format(selectedDate)],
                              notation: 'H',
                              label: 'Half Day',
                              value: 'half',
                              color: Colors.brown[600],
                              onChanged: (value) {
                                context.read<AttendanceBloc>().add(
                                      UpdateSingleStatus(
                                        attendance: attendance,
                                        date: DateFormat('dd-MM-yyyy')
                                            .format(selectedDate),
                                        status: value!,
                                        admNo: widget.student.admNo,
                                        schoolCode: widget.student.schoolCode,
                                      ),
                                    );
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AttendanceNotation(
                              labelSize: 15,
                              notationSize: 26,
                              notationFontSize: 16,
                              notationLabelSpacing: 10,
                              groupValue: attendance[DateFormat('dd-MM-yyyy')
                                  .format(selectedDate)],
                              notation: 'L',
                              label: 'Leave',
                              value: 'leave',
                              color: Colors.amber,
                              horizontalPadding: 10,
                              onChanged: (value) {
                                context.read<AttendanceBloc>().add(
                                      UpdateSingleStatus(
                                        attendance: attendance,
                                        date: DateFormat('dd-MM-yyyy')
                                            .format(selectedDate),
                                        status: value!,
                                        admNo: widget.student.admNo,
                                        schoolCode: widget.student.schoolCode,
                                      ),
                                    );
                              },
                            ),
                            AttendanceNotation(
                              labelSize: 15,
                              notationSize: 26,
                              notationFontSize: 16,
                              notationLabelSpacing: 10,
                              groupValue: attendance[DateFormat('dd-MM-yyyy')
                                  .format(selectedDate)],
                              notation: 'A',
                              label: 'Absent',
                              value: 'absent',
                              horizontalPadding: 10,
                              color: Theme.of(context).colorScheme.error,
                              onChanged: (value) {
                                context.read<AttendanceBloc>().add(
                                      UpdateSingleStatus(
                                        attendance: attendance,
                                        date: DateFormat('dd-MM-yyyy')
                                            .format(selectedDate),
                                        status: value!,
                                        admNo: widget.student.admNo,
                                        schoolCode: widget.student.schoolCode,
                                      ),
                                    );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is AttendanceLoadError) {
            return Text(state.error);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
