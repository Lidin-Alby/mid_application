import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      required this.label,
      required this.controller,
      this.isValidted = false,
      required this.isEdit})
      : super(key: key);
  final String label;
  final TextEditingController controller;

  final bool isValidted;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        validator: isValidted
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              }
            : null,
        readOnly: !isEdit,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          label: Text(label),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
