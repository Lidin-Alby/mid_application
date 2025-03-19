import 'package:flutter/material.dart';
import 'package:mid_application/Screens/student_details_screen.dart';
import 'package:mid_application/Screens/student_list_screen.dart';
import 'package:mid_application/widgets/class_tile.dart';
import 'package:mid_application/widgets/tab_button.dart';
import 'package:mid_application/widgets/teacher_or_staff_tile.dart';

class DetailsInfoScreen extends StatefulWidget {
  const DetailsInfoScreen({super.key});

  @override
  State<DetailsInfoScreen> createState() => _DetailsInfoScreenState();
}

class _DetailsInfoScreenState extends State<DetailsInfoScreen> {
  int _currentIndex = 0;
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
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentListScreen(),
                          ),
                        ),
                        child: ClassTile(
                          classTitle: '10th-H',
                          totalStudents: '52',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            if (_currentIndex == 1)
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TeacherOrStaffTile(isTeacher: true)
                  ],
                ),
              ),
            if (_currentIndex == 2)
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TeacherOrStaffTile(isTeacher: false)
                  ],
                ),
              ),
          ],
        ));
  }
}
