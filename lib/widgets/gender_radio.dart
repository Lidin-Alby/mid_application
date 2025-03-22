import 'package:flutter/material.dart';

class GenderRadio extends StatelessWidget {
  const GenderRadio({super.key, required this.gender, required this.onChanged});
  final String? gender;
  final Function(dynamic value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: const Color.fromARGB(255, 96, 96, 96),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 25,
              height: 35,
              child: Radio(
                value: 'Male',
                groupValue: gender,
                onChanged: onChanged,
              ),
            ),
            Text('Male'),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 25,
              height: 35,
              child: Radio(
                value: 'Female',
                groupValue: gender,
                onChanged: onChanged,
              ),
            ),
            Text('Female')
          ],
        ),
      ],
    );
  }
}
