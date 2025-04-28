import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/Attendance%20School/school_attendance_bloc.dart';
import 'package:mid_application/Blocs/Attendance%20School/school_attendance_event.dart';
import 'package:mid_application/Blocs/Attendance%20School/school_attendance_state.dart';
import 'package:mid_application/Blocs/Class%20Model/class_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_event.dart';
import 'package:mid_application/Blocs/Class%20Model/class_state.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/models/school_attendance.dart';
import 'package:mid_application/widgets/attendance_class_tile.dart';
import 'package:mid_application/widgets/counts_column_attendance.dart';

class AttendanceDashboard extends StatelessWidget {
  const AttendanceDashboard({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  Widget build(BuildContext context) {
    context
        .read<SchoolAttendanceBloc>()
        .add(GetSchoolAttendance(schoolCode, DateTime.now()));
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Attendance',
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'School Strength',
                  style: GoogleFonts.inter(
                      fontSize: 10, fontWeight: FontWeight.w600),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1.5,
                  height: 5,
                ),
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<SchoolAttendanceBloc, SchoolAttendanceState>(
                    builder: (context, state) {
                  if (state is SchoolAttendanceLoadError) {
                    return Row(
                      children: [
                        Text(state.error),
                      ],
                    );
                  }
                  if (state is SchoolAttendanceLoaded) {
                    SchoolAttendance schoolAttendance = state.schoolAttendance;
                    if (schoolAttendance.totalCount == 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not taken yet'),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CountsColumnAttendance(
                          count: schoolAttendance.totalCount.toString(),
                          icon: Icons.person_outline_rounded,
                          label: 'Students',
                        ),
                        CountsColumnAttendance(
                          count: (schoolAttendance.absentCount +
                                  schoolAttendance.leaveCount)
                              .toString(),
                          icon: Icons.dangerous,
                          iconColor: Theme.of(context).colorScheme.error,
                          label: 'Absent',
                        ),
                        CountsColumnAttendance(
                          count: (schoolAttendance.presentCount +
                                  schoolAttendance.halfCount)
                              .toString(),
                          icon: Icons.check_box,
                          iconColor: Colors.green,
                          label: 'Present',
                        )
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          BlocBuilder<ClassBloc, ClassState>(
            builder: (context, state) {
              if (state is ClassInitial) {
                context.read<ClassBloc>().add(LoadClasses(schoolCode));
              }
              if (state is ClassLoaded) {
                List<ClassModel> classes = state.classes;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: classes.length,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                    child: AttendanceClassTile(
                      classTitle: classes[index].classTitle,
                      classTeacher: classes[index].classTeacher.toString(),
                      profilePic: classes[index].profilePic!,
                      schoolCode: classes[index].schoolCode!,
                      totalStudents: classes[index].totalStudents!,
                    ),
                  ),
                );
              } else if (state is ClassError) {
                return Text(state.error);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
