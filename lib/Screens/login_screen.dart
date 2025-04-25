import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/Login/login_bloc.dart';
import 'package:mid_application/Blocs/Login/login_event.dart';
import 'package:mid_application/Blocs/Login/login_state.dart';

import 'package:mid_application/widgets/my_textfield.dart';

// class LoginScreen extends ConsumerWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final loginState = ref.watch(loginProvider);
//     final loginNotifier = ref.read(loginProvider.notifier);

//     return
//     Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 252, 242),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Card(
//             elevation: 5,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   spacing: 10,
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: RichText(
//                             text: TextSpan(
//                               style: GoogleFonts.inter(
//                                   fontSize: 27,
//                                   fontWeight: FontWeight.bold,
//                                   height: 1.5,
//                                   letterSpacing: 4,
//                                   color: Colors.black),
//                               children: [
//                                 TextSpan(
//                                   text: 'Let\'s\nGet\nStarted',
//                                 ),
//                                 TextSpan(
//                                   text: ' !',
//                                   style: GoogleFonts.inter(
//                                     color:
//                                         Theme.of(context).colorScheme.primary,
//                                     letterSpacing: 0.7,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 140,
//                           // width: 126,
//                           child: Image.asset('assets/images/login-img.png'),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     MyTextfield(
//                       label: 'UserID / Admission No.',
//                       onChanged: loginNotifier.updateUserId,
//                     ),
//                     MyTextfield(
//                       label: 'School Code',
//                       onChanged: loginNotifier.updateSchoolCode,
//                     ),
//                     MyTextfield(
//                       label: 'Password',
//                       onChanged: loginNotifier.updatePassword,
//                     ),
//                     if (loginState.error != null)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5),
//                         child: Text(
//                           loginState.error!,
//                           style: GoogleFonts.inter(
//                             color: Theme.of(context).colorScheme.error,
//                           ),
//                         ),
//                       ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: loginState.isLoading
//                               ? Center(child: CircularProgressIndicator())
//                               : FilledButton(
//                                   style: FilledButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                   onPressed: loginNotifier.login,
//                                   child: Text('LOGIN'),
//                                 ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userId = TextEditingController();

  final TextEditingController schoolCode = TextEditingController();

  final TextEditingController password = TextEditingController();
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 252, 242),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                  return Column(
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
                                    text: 'Let\'s\nGet\nStarted',
                                  ),
                                  TextSpan(
                                    text: ' !',
                                    style: GoogleFonts.inter(
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                        label: 'UserID / Admission No.',
                        controller: userId,
                      ),
                      MyTextfield(
                        label: 'School Code',
                        controller: schoolCode,
                      ),
                      MyTextfield(
                        label: 'Password',
                        controller: password,
                        obscureText: hide,
                        suffix: IconButton(
                          icon: Icon(
                              hide ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                        ),
                      ),
                      if (state is LoginFailure)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            state.error,
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      state is LoginLoading || state is LoggedIn
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
                                      BlocProvider.of<LoginBloc>(context).add(
                                        LoginPressed(
                                            userId: userId.text.trim(),
                                            schoolCode: schoolCode.text.trim(),
                                            password: password.text.trim()),
                                      );
                                    },
                                    child: Text('LOGIN'),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
