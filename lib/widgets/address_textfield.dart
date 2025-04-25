import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressTextfield extends StatelessWidget {
  const AddressTextfield(
      {super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: const Color.fromARGB(255, 96, 96, 96),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          child: TextField(
            minLines: 3,
            maxLines: null,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: .5)),
              isDense: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }
}
