import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPopUpRadioItem extends StatelessWidget {
  const MyPopUpRadioItem(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onSelected,
      required this.label});
  final String label;
  final String value;
  final String? groupValue;
  final Function(String value) onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(value),
      child: SizedBox(
        width: 100,
        height: 40,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CupertinoRadio(
                fillColor: Theme.of(context).colorScheme.primary,
                activeColor: Colors.white,
                value: value,
                groupValue: groupValue,
                onChanged: (value) {},
              ),
            ),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
