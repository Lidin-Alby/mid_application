import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/Student/student_bloc.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/widgets/my_app_bar.dart';
import 'package:mid_application/widgets/my_pop_up_radio_item.dart';
import 'package:mid_application/widgets/student_tile.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen(
      {super.key,
      required this.schoolCode,
      required this.classTitle,
      required this.listHead,
      required this.logo});
  final String schoolCode;
  final String classTitle;
  final String listHead;
  final String logo;

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  String searchText = '';
  String? sort = 'name';
  bool openSort = false;

  @override
  void initState() {
    BlocProvider.of<StudentBloc>(context)
        .add(LoadStudents(widget.classTitle, widget.schoolCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        schoolCode: widget.schoolCode,
        logo: widget.logo,
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
          });
        },
        onTap: () {},
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                child: Row(
                  children: [
                    Ink(
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
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Spacer(),
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
                    students.sort(
                      (a, b) {
                        switch (sort) {
                          case 'name':
                            return a.fullName.compareTo(b.fullName);

                          case 'admNo':
                            return a.admNo.compareTo(b.admNo);
                          default:
                            return a.modified!.compareTo(b.modified!);
                          // DateFormat('dd-MM-yyyy')
                          //     .parse(a.modified ?? '01-01-2024')
                          //     .compareTo(
                          //       DateFormat('dd-MM-yyyy')
                          //           .parse(b.modified ?? '01-01-2024'),
                          //     );
                        }
                        // if (sort == 'name') {
                        //
                        // } else {

                        // }
                      },
                    );
                    students = students
                        .where(
                          (element) => element.fullName
                              .toLowerCase()
                              .startsWith(searchText),
                        )
                        .toList();

                    if (widget.listHead == 'noPhoto') {
                      students = students.where((student) {
                        return student.profilePic.toString() == "" ||
                            student.profilePic.toString() == "null";
                      }).toList();
                    } else {
                      if (widget.listHead != 'all') {
                        students = students
                            .where(
                              (student) =>
                                  student.printStatus.toString() ==
                                  widget.listHead,
                            )
                            .toList();
                      }
                    }

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
                      value: 'admNo',
                      groupValue: sort,
                      onSelected: (value) {
                        setState(() {
                          sort = value;
                          openSort = false;
                        });
                      },
                      label: 'Adm. No.',
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
    );
  }
}
