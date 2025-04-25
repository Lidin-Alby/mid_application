import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassTile extends StatelessWidget {
  const ClassTile(
      {super.key, required this.classTitle, required this.totalStudents});
  final String classTitle;
  final String totalStudents;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            classTitle,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Total Students :',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            totalStudents,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
