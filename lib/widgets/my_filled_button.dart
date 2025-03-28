import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  const MyFilledButton(
      {super.key, required this.label, required this.onPressed, this.color});
  final String label;
  final Function() onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      // height: 30,
      child: FilledButton(
        onPressed: onPressed,
        child: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
