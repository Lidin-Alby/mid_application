import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Screens/download_attendance_report_screen.dart';
import 'package:mid_application/Screens/manual_attendance_screen.dart';
import 'package:mid_application/Screens/qr_attendance_screen.dart';
import 'package:mid_application/Screens/view_attendance_screen.dart';
import 'package:mid_application/widgets/my_popup_menu_button.dart';
import 'package:mid_application/widgets/profile_pic.dart';

class AttendanceClassTile extends StatelessWidget {
  const AttendanceClassTile(
      {super.key,
      required this.classTitle,
      required this.classTeacher,
      required this.profilePic,
      required this.schoolCode,
      required this.totalStudents});

  final String classTitle;
  final String classTeacher;
  final String profilePic;
  final String schoolCode;
  final int totalStudents;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 243, 244),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            // height: 100,
            // padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            width: 90, padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(6)),
              border: Border.all(
                color: Colors.black12,
              ),
            ),
            child: Text(
              classTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ProfilePicWidget(
                        profilePic: profilePic,
                        schoolCode: schoolCode,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              classTeacher,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Class Teacher',
                              style: GoogleFonts.inter(
                                  fontSize: 11, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Students : ',
                          style: GoogleFonts.inter(
                              fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: totalStudents.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              color: Theme.of(context).colorScheme.primary,
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrAttendanceScreen(
                        schoolCode: schoolCode,
                        classTitle: classTitle,
                        totalStudents: totalStudents,
                      ),
                    ),
                  ),
                  child: MyPopupMenuButton(
                    label: 'Mark Attendance',
                    icon: Icons.check,
                  ),
                ),
                PopupMenuItem(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManualAttendanceScreen(
                          schoolCode: schoolCode,
                          classTitle: classTitle,
                        ),
                      )),
                  child: MyPopupMenuButton(
                    label: 'Manual Attendance',
                    icon: Icons.book_outlined,
                  ),
                ),
                PopupMenuItem(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewAttendanceScreen(
                        classTitle: classTitle,
                        schoolCode: schoolCode,
                      ),
                    ),
                  ),
                  child: MyPopupMenuButton(
                    label: 'View Attendance',
                    icon: Icons.view_column,
                  ),
                ),
                PopupMenuItem(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => DownloadAttendanceReportScreen(
                      schoolCode: schoolCode,
                      classTitle: classTitle,
                    ),
                  ),
                  child: MyPopupMenuButton(
                    label: 'Download Report',
                    icon: Icons.download_outlined,
                  ),
                ),
              ],
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(7),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
