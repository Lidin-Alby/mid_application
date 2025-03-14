import 'package:flutter/material.dart';

class CountsColumn extends StatelessWidget {
  const CountsColumn(
      {super.key,
      required this.count,
      required this.icon,
      required this.label});
  final String count;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          height: 45,
          width: 45,
          margin: EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 252, 242),
              borderRadius: BorderRadius.circular(16)),
          child: Icon(
            fill: 1,
            icon,
            size: 30,
            weight: 10,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
