import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mid_application/Blocs/Attendance/attendance_bloc.dart';
import 'package:mid_application/Blocs/Attendance/attendance_event.dart';
import 'package:mid_application/Blocs/Attendance/attendance_state.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/widgets/attendance_app_bar.dart';

class ViewAttendanceCalendarScreen extends StatelessWidget {
  const ViewAttendanceCalendarScreen(
      {super.key, required this.classTitle, required this.student});
  final String classTitle;
  final Student student;

  @override
  Widget build(BuildContext context) {
    context.read<AttendanceBloc>().add(LoadIndividualAttendance(student));

    DateTime selectedDate = DateTime.now();
    List weeks = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final daysInMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    final firstDay =
        DateTime(DateTime.now().year, DateTime.now().month, 1).weekday;
    print(firstDay);
    print(DateTime.sunday);
    return Scaffold(
        appBar: AttendanceAppBar(classTitle: classTitle),
        body: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) => state is AttendanceLoading
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Color.fromRGBO(0, 0, 0, 0.25))
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    iconSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_back_ios),
                                  ),
                                  Text(
                                    DateFormat('MMMM').format(selectedDate),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    iconSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                  if (firstDay != 7)
                                    for (int i = 0; i < firstDay; i++)
                                      const SizedBox(),
                                  for (int date = 1;
                                      date < daysInMonth + 1;
                                      date++)
                                    Center(
                                      child: Text(
                                        date.toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [

                        //     Flexible(
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 20),
                        //         child: Column(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             // Row(
                        //             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //             //   children: [

                        //             //   ],
                        //             // ),
                        //             Flexible(
                        //               child:

                        //             ),
                        //             SizedBox(
                        //               height: 20,
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
