import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield(
      {super.key,
      required this.label,
      required this.controller,
      this.error,
      this.obscureText = false,
      this.suffix});
  final String label;
  final String? error;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController controller;
  // final Function(String value) onChanged;

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
        SizedBox(
          // height: 34,
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              suffixIconConstraints:
                  BoxConstraints(maxWidth: 34, maxHeight: 34),
              suffixIcon: suffix,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38, width: .5)),
              errorText: error,
              errorStyle: GoogleFonts.inter(fontSize: 8),
              // constraints: BoxConstraints(maxHeight: 34),
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
