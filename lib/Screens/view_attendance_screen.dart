import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Student/student_bloc.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/Screens/view_attendance_calendar_screen.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/widgets/attendance_app_bar.dart';
import 'package:mid_application/widgets/profile_pic.dart';

class ViewAttendanceScreen extends StatefulWidget {
  const ViewAttendanceScreen(
      {super.key, required this.classTitle, required this.schoolCode});
  final String classTitle;
  final String schoolCode;

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  @override
  void initState() {
    context
        .read<StudentBloc>()
        .add(LoadStudents(widget.classTitle, widget.schoolCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 252, 242, 1),
        appBar:
            AttendanceAppBar(title: 'Students', classTitle: widget.classTitle),
        body: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            if (state is StudentLoadError) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is StudentsLoaded) {
              List<Student> students = state.students;

              return students.isEmpty
                  ? Center(child: Text('No Students added'))
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        Student student = students[index];

                        return Padding(
                          padding: EdgeInsets.only(
                              top: index == 0 ? 20 : 0,
                              bottom: index == students.length ? 20 : 0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewAttendanceCalendarScreen(
                                    classTitle: widget.classTitle,
                                    student: student,
                                  ),
                                ),
                              ),
                              child: Ink(
                                height: 60,
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
                                      profilePic: student.profilePic.toString(),
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
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Admission No. - ${student.admNo}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                Color.fromRGBO(55, 55, 55, 1),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
