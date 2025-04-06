import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_state.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/widgets/attendance_class_tile.dart';
import 'package:mid_application/widgets/counts_column_attendance.dart';

class AttendanceDashboard extends StatelessWidget {
  const AttendanceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Attendance',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
                Divider(
                  color: Colors.black,
                  // indent: 10,
                  // endIndent: 10,
                  thickness: 1.5,
                  height: 5,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CountsColumnAttendance(
                      count: '10',
                      icon: Icons.person_outline_rounded,
                      label: 'Students',
                      // iconSize: 20,
                    ),
                    CountsColumnAttendance(
                      count: '5',
                      icon: Icons.dangerous,
                      iconColor: Theme.of(context).colorScheme.error,
                      label: 'Absent',
                    ),
                    CountsColumnAttendance(
                      count: '4',
                      icon: Icons.check_box,
                      iconColor: Colors.green,
                      label: 'Present',
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          BlocBuilder<ClassBloc, ClassState>(
            builder: (context, state) {
              if (state is ClassLoading) {
                return CircularProgressIndicator();
              } else if (state is ClassLoaded) {
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
              } else {
                return Text((state as ClassError).error);
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
