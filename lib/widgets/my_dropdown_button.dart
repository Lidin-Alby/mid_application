import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton(
      {super.key,
      required this.label,
      required this.onChanged,
      required this.items,
      required this.value});
  final String label;
  final dynamic value;
  final Function(dynamic value) onChanged;
  final List<DropdownMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: const Color.fromARGB(255, 96, 96, 96),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 34,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: .5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton(
            value: value,
            padding: EdgeInsets.symmetric(horizontal: 5),
            underline: Text(''),
            isExpanded: true,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
