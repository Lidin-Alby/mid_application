import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountsColumn extends StatelessWidget {
  const CountsColumn(
      {super.key,
      required this.count,
      required this.icon,
      required this.label,
      this.iconColor,
      this.iconSize = 30});
  final String count;
  final IconData icon;
  final String label;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 45,
          width: 45,
          margin: EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 252, 242),
              borderRadius: BorderRadius.circular(16)),
          child: Icon(
            color: iconColor,
            fill: 1,
            icon,
            size: iconSize,
            weight: 10,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10),
        ),
      ],
    );
  }
}
