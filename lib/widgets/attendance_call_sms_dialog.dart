import 'package:flutter/material.dart';
import 'package:mid_application/widgets/my_filled_button.dart';

class AttendanceCallSmsDialog extends StatefulWidget {
  const AttendanceCallSmsDialog({super.key, required this.onConfirm});
  final Function(
    bool smsAbsent,
    bool smsPresent,
    bool callAbsent,
    bool callPresent,
  ) onConfirm;

  @override
  State<AttendanceCallSmsDialog> createState() =>
      _AttendanceCallSmsDialogState();
}

class _AttendanceCallSmsDialogState extends State<AttendanceCallSmsDialog> {
  bool smsAbsent = false;
  bool smsPresent = false;
  bool callAbsent = false;
  bool callPresent = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SMS',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              endIndent: 30,
              thickness: 1,
              height: 0,
              color: Theme.of(context).colorScheme.primary,
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    visualDensity: VisualDensity(vertical: -3),
                    value: smsAbsent,
                    onChanged: (value) {
                      setState(() {
                        smsAbsent = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 58, child: Text('Absent')),
                Icon(
                  Icons.dangerous,
                  size: 16,
                  color: Theme.of(context).colorScheme.error,
                )
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    visualDensity: VisualDensity(vertical: -4),
                    value: smsPresent,
                    onChanged: (value) {
                      setState(() {
                        smsPresent = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 58, child: Text('Present')),
                Icon(
                  Icons.check_box,
                  size: 16,
                  color: Colors.green,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Call',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              endIndent: 30,
              thickness: 1,
              height: 0,
              color: Theme.of(context).colorScheme.primary,
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    visualDensity: VisualDensity(vertical: -3),
                    value: callAbsent,
                    onChanged: (value) {
                      setState(() {
                        callAbsent = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 58, child: Text('Absent')),
                Icon(
                  Icons.dangerous,
                  size: 16,
                  color: Theme.of(context).colorScheme.error,
                )
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    visualDensity: VisualDensity(vertical: -4),
                    value: callPresent,
                    onChanged: (value) {
                      setState(() {
                        callPresent = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 58, child: Text('Present')),
                Icon(
                  Icons.check_box,
                  size: 16,
                  color: Colors.green,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyFilledButton(
                    label: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  MyFilledButton(
                    label: 'Confirm',
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onConfirm(
                          smsAbsent, smsPresent, callAbsent, callPresent);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
