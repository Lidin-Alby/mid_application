import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Screens/student_details_screen.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/widgets/profile_pic.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({super.key, required this.student});
  final Student student;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDetailsScreen(
              schoolCode: student.schoolCode,
              admNo: student.admNo,
              ready: (student.printStatus == "printing" ||
                  student.printStatus == "printed" ||
                  student.printStatus == "ready"),
            ),
          ),
        );
      },
      child: Container(
        // height: 128,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ProfilePicWidget(
                        size: 70,
                        profilePic: student.profilePic!,
                        schoolCode: student.schoolCode,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.fullName.toString(),
                            style:
                                GoogleFonts.inter(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Student',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 37,
                        child: Text(
                          'Father',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                        child: Text(
                          ':',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        student.fatherName.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 37,
                        child: Text(
                          'Mother',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                        child: Text(
                          ':',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        student.motherName.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 37,
                        child: Text(
                          'Mobile',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                        child: Text(
                          ':',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        student.fatherMobNo.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'DOB : ',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        student.dob.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    student.admNo,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      'Admission No.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(fontSize: 9),
                    ),
                  ),
                ],
              ),
              if (!(student.check ?? true))
                SizedBox(
                  width: 15,
                ),
              if (student.check ?? false)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
