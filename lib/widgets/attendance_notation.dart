import 'package:flutter/material.dart';

class AttendanceNotation extends StatelessWidget {
  const AttendanceNotation(
      {super.key,
      required this.notation,
      required this.label,
      required this.value,
      required this.onChanged,
      required this.color,
      this.horizontalPadding = 0,
      required this.groupValue,
      this.labelSize = 11,
      this.notationSize = 18,
      this.notationFontSize = 12,
      this.notationLabelSpacing = 2});
  final String notation;
  final String label;
  final String value;
  final Color? color;
  final double horizontalPadding;
  final String? groupValue;
  final double labelSize;
  final double notationSize;
  final double notationFontSize;
  final double notationLabelSpacing;

  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: notationSize,
          height: notationSize,
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
              fontSize: notationFontSize,
            ),
          ),
        ),
        SizedBox(
          width: notationLabelSpacing,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
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
          groupValue: groupValue,
          onChanged: (value) => onChanged(value),
        ),
      ],
    );
  }
}
