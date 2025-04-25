import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Change%20password/change_password_bloc.dart';
import 'package:mid_application/Blocs/Change%20password/change_password_event.dart';
import 'package:mid_application/Blocs/Change%20password/change_password_state.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool hide1 = true;
  bool hide2 = true;
  bool hide3 = true;
  String? error;
  String? emptyError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 15,
          children: [
            MyTextfield(
              error: emptyError,
              label: 'Current Password',
              controller: currentPassword,
              obscureText: hide1,
              suffix: IconButton(
                icon: Icon(hide1 ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    hide1 = !hide1;
                  });
                },
              ),
            ),
            MyTextfield(
              error: emptyError,
              label: 'New Password',
              obscureText: hide2,
              controller: newPassword,
              suffix: IconButton(
                icon: Icon(hide2 ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    hide2 = !hide2;
                  });
                },
              ),
            ),
            MyTextfield(
              error: error,
              label: 'Re-enter Password',
              obscureText: hide3,
              controller: confirmPassword,
              suffix: IconButton(
                icon: Icon(hide3 ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    hide3 = !hide3;
                  });
                },
              ),
            ),
            SizedBox(),
            BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saved Successfully'),
                    ),
                  );
                }
                if (state is ChangePasswordSaveError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) => state is ChangePasswordSaving
                  ? CircularProgressIndicator()
                  : Row(
                      children: [
                        Expanded(
                          child: MyFilledButton(
                            label: 'Confirm',
                            onPressed: () {
                              if (currentPassword.text.trim().isEmpty ||
                                  newPassword.text.trim().isEmpty) {
                                setState(() {
                                  emptyError = 'This field cannot be empty';
                                });
                              } else {
                                if (newPassword.text.trim() ==
                                    confirmPassword.text.trim()) {
                                  context.read<ChangePasswordBloc>().add(
                                      ChangePassword(
                                          currentPassword.text.trim(),
                                          newPassword.text.trim()));
                                } else {
                                  setState(() {
                                    error = 'Password does not match';
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
