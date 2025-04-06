import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendanceActionDialog extends StatelessWidget {
  const AttendanceActionDialog(
      {super.key,
      required this.fatherNo,
      required this.motherNo,
      required this.type});
  final String? fatherNo;
  final String? motherNo;
  final String type;

  @override
  Widget build(BuildContext context) {
    String link = 'tel:';
    if (type == 'sms') {
      link = 'sms:';
    } else if (type == 'whatsapp') {
      link = 'whatsapp://send?phone=';
    }
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onLongPress: () async {
              await Clipboard.setData(ClipboardData(text: fatherNo.toString()));
            },
            onTap: () => launchUrl(Uri.parse('$link$fatherNo')),
            title: Text('Father : $fatherNo'),
          ),
          ListTile(
            onLongPress: () async {
              await Clipboard.setData(ClipboardData(text: motherNo.toString()));
            },
            onTap: () => launchUrl(Uri.parse('$link$motherNo')),
            title: Text('Mother : $motherNo'),
          ),
        ],
      ),
    );
  }
}
