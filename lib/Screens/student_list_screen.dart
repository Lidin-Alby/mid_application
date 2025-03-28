import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Student/student_bloc.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/widgets/student_tile.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen(
      {super.key, required this.schoolCode, required this.classTitle});
  final String schoolCode;
  final String classTitle;

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  void initState() {
    BlocProvider.of<StudentBloc>(context)
        .add(LoadStudents(widget.classTitle, widget.schoolCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
            child: Ink(
              // width: 50,
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.5,
                  ),
                ),
              ),

              child: Text(
                widget.classTitle,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<StudentBloc, StudentState>(
            builder: (context, state) {
              if (state is StudentLoadError) {
                return Expanded(
                  child: Center(
                    child: Text(state.error),
                  ),
                );
              } else if (state is StudentsLoaded) {
                List<Student> students = state.students;
                return Expanded(
                  child: students.isEmpty
                      ? Center(child: Text('No Students added'))
                      : ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: StudentTile(
                              student: students[index],
                            ),
                          ),
                        ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
