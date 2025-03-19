import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Ink(
          // width: 50,
          padding: EdgeInsets.only(bottom: 5),
          decoration: selected
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.5,
                    ),
                  ),
                )
              : null,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? null : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
