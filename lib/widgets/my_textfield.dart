import 'package:flutter/material.dart';
import 'package:mid_application/widgets/my_filled_button.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield(
      {super.key, required this.label, required this.controller, this.error});
  final String label;
  final String? error;
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
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        SizedBox(
          // height: 34,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              errorText: error,
              errorStyle: TextStyle(fontSize: 8),
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
