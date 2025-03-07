import 'package:flutter/material.dart';

import '../widgets/my_filled_button.dart';
import '../widgets/my_textfield.dart';

class AddSchoolModel extends StatelessWidget {
  AddSchoolModel({super.key});
  final TextEditingController schoolCode = TextEditingController();
  final TextEditingController principalPhone = TextEditingController();
  final TextEditingController schoolPassword = TextEditingController();
  final TextEditingController schoolName = TextEditingController();
  final TextEditingController schoolMail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: FractionallySizedBox(
        heightFactor: 0.7,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 15,
              children: [
                Text(
                  'Add School',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                MyTextfield(
                  label: 'School Code',
                  controller: schoolCode,
                ),
                MyTextfield(
                  label: 'Principal Phone',
                  controller: principalPhone,
                ),
                MyTextfield(
                  label: 'School Password',
                  controller: schoolPassword,
                ),
                MyTextfield(
                  label: 'School Name',
                  controller: schoolName,
                ),
                MyTextfield(
                  label: 'School Mail',
                  controller: schoolMail,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyFilledButton(
                        label: 'Add School',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
