import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/Add%20school/add_school_bloc.dart';
import 'package:mid_application/Blocs/Add%20school/add_school_event.dart';
import 'package:mid_application/Blocs/Add%20school/add_school_state.dart';

import '../widgets/my_filled_button.dart';
import '../widgets/my_textfield.dart';

class AddSchoolModel extends StatefulWidget {
  const AddSchoolModel({
    super.key,
  });
  // final SchoolListBloc schoolListBloc;

  @override
  State<AddSchoolModel> createState() => _AddSchoolModelState();
}

class _AddSchoolModelState extends State<AddSchoolModel> {
  final TextEditingController schoolCode = TextEditingController();

  final TextEditingController principalPhone = TextEditingController();

  final TextEditingController schoolPassword = TextEditingController();

  final TextEditingController schoolName = TextEditingController();

  final TextEditingController schoolMail = TextEditingController();
  // final addSchoolBloc = AddSchoolBloc(SchoolListBloc());

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
            child: BlocConsumer<AddSchoolBloc, AddSchoolState>(
              // bloc: ,
              listener: (context, state) {
                if (state is SchoolAdded) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) => Column(
                spacing: 15,
                children: [
                  Text(
                    'Add School',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold, fontSize: 20),
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
                  state is AddSchoolLoading
                      ? CircularProgressIndicator()
                      : Row(
                          children: [
                            Expanded(
                              child: MyFilledButton(
                                label: 'Add School',
                                onPressed: () {
                                  context.read<AddSchoolBloc>().add(
                                        AddSchoolPressed(
                                          schoolCode: schoolCode.text.trim(),
                                          principalPhone:
                                              principalPhone.text.trim(),
                                          schoolName: schoolName.text.trim(),
                                          schoolPassword:
                                              schoolPassword.text.trim(),
                                          schoolMail: schoolMail.text.trim(),
                                        ),
                                      );
                                },
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
      ),
    );
  }
}
