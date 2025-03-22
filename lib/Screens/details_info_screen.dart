import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Class/class_bloc.dart';
import 'package:mid_application/Blocs/Class/class_state.dart';
import 'package:mid_application/Blocs/Staff/staff_bloc.dart';
import 'package:mid_application/Blocs/Staff/staff_event.dart';
import 'package:mid_application/Blocs/Staff/staff_state.dart';

import 'package:mid_application/Screens/student_list_screen.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/teacher.dart';
import 'package:mid_application/widgets/class_tile.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/tab_button.dart';
import 'package:mid_application/widgets/teacher_or_staff_tile.dart';

class DetailsInfoScreen extends StatefulWidget {
  const DetailsInfoScreen({super.key, required this.schoolCode});

  final String schoolCode;

  @override
  State<DetailsInfoScreen> createState() => _DetailsInfoScreenState();
}

class _DetailsInfoScreenState extends State<DetailsInfoScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                TabButton(
                  label: 'Class',
                  selected: _currentIndex == 0,
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
                TabButton(
                  label: 'Teachers',
                  selected: _currentIndex == 1,
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
                TabButton(
                  label: 'Staff',
                  selected: _currentIndex == 2,
                  onTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
                Spacer(),
                if (_currentIndex != 0)
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.sort),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), elevation: 0),
                  )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          if (_currentIndex == 0)
            BlocBuilder<ClassBloc, ClassState>(builder: (context, state) {
              if (state is ClassError) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is ClassLoaded) {
                List<ClassModel> classes = state.classes;
                return Expanded(
                  child: ListView.builder(
                    itemCount: classes.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentListScreen(
                              schoolCode: widget.schoolCode,
                              classTitle: classes[index].classTitle,
                            ),
                          ),
                        ),
                        child: ClassTile(
                          classTitle: classes[index].classTitle,
                          totalStudents:
                              classes[index].totalStudents.toString(),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          if (_currentIndex == 1)
            Expanded(
              child: BlocBuilder<StaffBloc, StaffState>(
                builder: (context, state) {
                  if (state is StaffLoadError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error),
                        MyFilledButton(
                          label: 'Retry',
                          onPressed: () {
                            context
                                .read<StaffBloc>()
                                .add(LoadStaffs(widget.schoolCode));
                          },
                        )
                      ],
                    );
                  } else if (state is StaffsLoaded) {
                    List<Teacher> teachers = state.teachers;
                    if (teachers.isEmpty) {
                      return Center(
                        child: Text('No Teachers added'),
                      );
                    }
                    return ListView.builder(
                      itemCount: teachers.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TeacherOrStaffTile(staffUser: teachers[index]),
                      ),
                    );
                  } else {
                    context
                        .read<StaffBloc>()
                        .add(LoadStaffs(widget.schoolCode));
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          if (_currentIndex == 2)
            Expanded(
              child: BlocBuilder<StaffBloc, StaffState>(
                builder: (context, state) {
                  if (state is StaffLoadError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error),
                        MyFilledButton(
                          label: 'Retry',
                          onPressed: () {
                            context
                                .read<StaffBloc>()
                                .add(LoadStaffs(widget.schoolCode));
                          },
                        )
                      ],
                    );
                  } else if (state is StaffsLoaded) {
                    List<Staff> staffs = state.staffs;
                    if (staffs.isEmpty) {
                      return Center(
                        child: Text('No Staffs added'),
                      );
                    }
                    return ListView.builder(
                      itemCount: staffs.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TeacherOrStaffTile(staffUser: staffs[index]),
                      ),
                    );
                  } else {
                    context
                        .read<StaffBloc>()
                        .add(LoadStaffs(widget.schoolCode));
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
