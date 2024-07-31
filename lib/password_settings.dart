import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'helper_widgets.dart';
import 'ip_address.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword(
      {super.key, required this.schoolCode, required this.userName});
  final String schoolCode;
  final String userName;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool allow = false;
  final _formKey = GlobalKey<FormState>();

  savePassword() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('$ipv4/updateStaffInfoMid');
      var res = await http.post(url, body: {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!allow)
                Column(
                  children: [
                    MidTextField(
                      isEdit: true,
                      label: 'Current Password',
                      controller: currentPassword,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          allow = true;
                        });
                      },
                      child: Text('Confirm'),
                    ),
                  ],
                ),
              if (allow)
                Form(
                  child: Column(
                    children: [
                      MidTextField(
                        isEdit: true,
                        label: 'New Password',
                        controller: newPassword,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MidTextField(
                        isEdit: true,
                        label: 'Confirm Password',
                        controller: confirmPassword,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FilledButton(onPressed: () {}, child: Text('Save')),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
