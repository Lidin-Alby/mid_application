import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/signup/signup_bloc.dart';
import 'package:mid_application/Blocs/signup/signup_event.dart';
import 'package:mid_application/Blocs/signup/signup_state.dart';
import 'package:mid_application/widgets/my_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController schoolName = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController name = TextEditingController();
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is SignupRequestSuccess) {
          schoolName.clear();
          contactNo.clear();
          name.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Request send successfully. Our Team will contact you soon'),
            ),
          );
        }
      },
      builder: (context, state) => Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 4,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Yet \nTo\nStart',
                      ),
                      TextSpan(
                        text: ' ?',
                        style: GoogleFonts.inter(
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 140,
                // width: 126,
                child: Image.asset('assets/images/login-img.png'),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          MyTextfield(
            label: 'Name',
            controller: name,
          ),
          MyTextfield(
            label: 'Contact Number',
            controller: contactNo,
          ),
          MyTextfield(
            label: 'School Name',
            controller: schoolName,
          ),
          if (showError)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'Please fill all fields',
                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          SizedBox(
            height: 5,
          ),
          state is SignupLoading
              ? CircularProgressIndicator()
              : Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          if (schoolName.text.trim().isEmpty ||
                              contactNo.text.trim().isEmpty ||
                              name.text.trim().isEmpty) {
                            setState(() {
                              showError = true;
                            });
                          } else {
                            context.read<SignupBloc>().add(
                                  SendSigup(
                                    schoolName: schoolName.text.trim(),
                                    contactNo: contactNo.text.trim(),
                                    name: name.text.trim(),
                                  ),
                                );
                          }
                        },
                        child: Text('SEND REQUEST'),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
