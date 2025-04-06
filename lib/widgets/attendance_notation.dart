import 'package:flutter/material.dart';

class AttendanceNotation extends StatelessWidget {
  const AttendanceNotation(
      {super.key,
      required this.notation,
      required this.label,
      required this.value,
      required this.onChanged,
      required this.color,
      this.horizontalPadding = 0});
  final String notation;
  final String label;
  final String value;
  final Color? color;
  final double horizontalPadding;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            notation,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: horizontalPadding,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity(vertical: -3),
          value: value,
          groupValue: 'status',
          onChanged: (value) => onChanged(value),
        ),
      ],
    );
  }
}
