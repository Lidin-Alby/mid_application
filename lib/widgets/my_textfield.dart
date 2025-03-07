import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController controller;
  // final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 34,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
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
