import 'package:flutter/material.dart';
import 'staff_form_mid.dart';

import 'student_form_settings.dart';
import 'teacher_form.dart';

class FormSettingsPage extends StatefulWidget {
  const FormSettingsPage({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<FormSettingsPage> createState() => _FormSettingsPageState();
}

class _FormSettingsPageState extends State<FormSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Form Settings'),
          bottom: TabBar(tabs: [
            Tab(
              child: Text('Student Form'),
            ),
            Tab(
              child: Text('Teachers Form'),
            ),
            Tab(
              child: Text('Staff Form'),
            ),
          ]),
        ),
        body: TabBarView(children: [
          StudentFormMid(
            schoolCode: widget.schoolCode,
          ),
          TeacherFormMid(schoolCode: widget.schoolCode),
          StaffFormMid(schoolCode: widget.schoolCode),
        ]),
      ),
    );
  }
}
