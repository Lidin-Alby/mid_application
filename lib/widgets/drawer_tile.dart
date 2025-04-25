import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap,
      this.iconSize = 22});
  final IconData icon;
  final double iconSize;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: 50,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: iconSize,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              label,
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
