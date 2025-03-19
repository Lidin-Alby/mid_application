import 'package:flutter/material.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton(
      {super.key,
      required this.label,
      required this.onChanged,
      required this.items});
  final String label;
  final Function(dynamic value) onChanged;
  final List<DropdownMenuItem> items;

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
        Container(
          height: 34,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton(
            padding: EdgeInsets.symmetric(horizontal: 5),
            underline: Text(''),
            isExpanded: true,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
