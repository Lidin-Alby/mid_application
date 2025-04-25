import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNavigationButton extends StatelessWidget {
  const MyNavigationButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.selected,
      required this.selectedIcon,
      required this.onPressed});
  final IconData icon;
  final String label;
  final bool selected;
  final IconData selectedIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: onPressed,
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary : null,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          spacing: 5,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              color: selected ? Colors.white : null,
              size: selected ? null : 30,
            ),
            if (selected)
              Text(
                label,
                style: GoogleFonts.inter(color: Colors.white),
              )
          ],
        ),
      ),
    );
  }
}
