import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({super.key, required this.label, required this.onChanged});
  final String label;
  final Function(String) onChanged;

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
            onChanged: onChanged,
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
