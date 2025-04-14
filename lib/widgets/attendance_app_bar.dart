import 'package:flutter/material.dart';

class AttendanceAppBar extends StatelessWidget implements PreferredSize {
  const AttendanceAppBar(
      {super.key, required this.classTitle, this.title = 'Attendance'});
  final String title;
  final String classTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        Container(
          alignment: Alignment.center,
          width: 43,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all()),
          child: Text(
            classTitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}
