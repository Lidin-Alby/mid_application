import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mid_application/Blocs/Class%20Model/class_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_state.dart';
import 'package:mid_application/Blocs/Staff/staff_bloc.dart';
import 'package:mid_application/Blocs/Staff/staff_event.dart';
import 'package:mid_application/Blocs/Staff/staff_state.dart';

import 'package:mid_application/Screens/student_list_screen.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/teacher.dart';
import 'package:mid_application/widgets/class_tile.dart';
import 'package:mid_application/widgets/my_app_bar.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_pop_up_radio_item.dart';
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
  String? sort = 'name';
  bool openSort = false;
  String searchText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
          });
        },
      ),
      body: PopScope(
        canPop: !openSort,
        onPopInvokedWithResult: (didPop, result) {
          setState(() {
            openSort = false;
          });
        },
        child: Stack(
          children: [
            Column(
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
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                openSort = true;
                              });
                            },
                            child: Icon(Icons.sort),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                              shape: CircleBorder(),
                              elevation: 0,
                            ),
                          ),
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
                          teachers.sort(
                            (a, b) {
                              if (sort == 'name') {
                                return a.fullName.compareTo(b.fullName);
                              } else {
                                return DateFormat('dd-MM-yyyy')
                                    .parse(a.joiningDate ?? '01-01-2024')
                                    .compareTo(
                                      DateFormat('dd-MM-yyyy')
                                          .parse(b.joiningDate ?? '01-01-2024'),
                                    );
                              }
                            },
                          );

                          teachers = teachers
                              .where(
                                (element) => element.fullName
                                    .toLowerCase()
                                    .startsWith(searchText),
                              )
                              .toList();

                          if (teachers.isEmpty) {
                            return Center(
                              child: Text('No Teachers added'),
                            );
                          }
                          return ListView.builder(
                            itemCount: teachers.length,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: TeacherOrStaffTile(
                                staffUser: teachers[index],
                                schoolCode: widget.schoolCode,
                              ),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: TeacherOrStaffTile(
                                staffUser: staffs[index],
                                schoolCode: widget.schoolCode,
                              ),
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
            if (openSort)
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (openSort) {
                      openSort = false;
                    }
                  });
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            if (openSort)
              Positioned(
                top: 15,
                right: 11,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyPopUpRadioItem(
                        value: 'name',
                        groupValue: sort,
                        onSelected: (value) {
                          setState(() {
                            sort = value;
                            openSort = false;
                          });
                        },
                        label: 'Name',
                      ),
                      MyPopUpRadioItem(
                        value: 'joining',
                        groupValue: sort,
                        onSelected: (value) {
                          setState(() {
                            sort = value;
                            openSort = false;
                          });
                        },
                        label: 'Joining',
                      ),
                      MyPopUpRadioItem(
                        value: 'modified',
                        groupValue: sort,
                        onSelected: (value) {
                          setState(() {
                            sort = value;
                            openSort = false;
                          });
                        },
                        label: 'Modified',
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
