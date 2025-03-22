import 'package:flutter/material.dart';
import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/teacher.dart';

class TeacherOrStaffTile extends StatelessWidget {
  const TeacherOrStaffTile({super.key, required this.staffUser});
  // final bool isTeacher;
  final Staff staffUser;

  @override
  Widget build(BuildContext context) {
    dynamic staff = staffUser;
    if (staffUser is Teacher) {
      staff = staffUser as Teacher;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/logoImg.jpg'),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    staff.fullName,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Text(
                        'Joined :',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        staff.joiningDate.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Text(
                        'Mobile :',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        staff.mob,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              staff is Teacher
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Text(
                          staff.classes!.length.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Classes',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          'Designation : ',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          staff.designation,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
              SizedBox(
                width: 10,
              ),
              staff.check ?? false
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 26,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
