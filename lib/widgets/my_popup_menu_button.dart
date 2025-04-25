import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPopupMenuButton extends StatelessWidget {
  const MyPopupMenuButton({super.key, required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Icon(
            icon,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.white),
        ),
      ],
    );
  }
}
