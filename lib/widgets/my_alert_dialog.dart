import 'package:flutter/material.dart';
import 'package:mid_application/widgets/my_filled_button.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.cancel,
      required this.confirm});
  final String title;
  final String subtitle;
  final Icon icon;
  final VoidCallback cancel;
  final VoidCallback confirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            icon,
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      content: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          color: Colors.grey[600],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyFilledButton(
                color: const Color.fromARGB(255, 54, 166, 31),
                label: 'OK',
                onPressed: confirm,
              ),
              MyFilledButton(
                  color: Colors.amber, label: 'Cancel', onPressed: cancel),
            ],
          ),
        )
      ],
    );
  }
}
