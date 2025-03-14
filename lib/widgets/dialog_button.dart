import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.icon,
    required this.label,
    this.color = const Color.fromARGB(255, 255, 252, 242),
  });
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            padding: EdgeInsets.all(30),
            shape: CircleBorder(),
            backgroundColor: color,
          ),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 148, 148, 148),
          ),
        )
      ],
    );
  }
}
