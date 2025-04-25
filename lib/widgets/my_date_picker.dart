import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({
    super.key,
    required this.label,
    required this.onSelected,
    required this.value,
  });
  final String label;
  final String? value;
  final Function(String value) onSelected;

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
        InkWell(
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              firstDate: DateTime(1990),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              onSelected(DateFormat('dd-MM-yyyy').format(date));
            }
          },
          child: Container(
            height: 34,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: .5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value ?? ''),
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
