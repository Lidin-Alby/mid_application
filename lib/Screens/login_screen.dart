import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mid_application/Screens/agent_home_screen.dart';
import 'package:mid_application/models/login.dart';
import 'package:mid_application/widgets/my_textfield.dart';

import '../providers/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    ref.listen<Login>(loginProvider, (previous, current) {
      if (current.token != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AgentHomeScreen(),
            ));
      }
    });
    if (loginState.token != null) {
      return AgentHomeScreen();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 252, 242),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
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
                              style: TextStyle(
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
                                  style: TextStyle(
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
                      onChanged: loginNotifier.updateUserId,
                    ),
                    MyTextfield(
                      label: 'School Code',
                      onChanged: loginNotifier.updateSchoolCode,
                    ),
                    MyTextfield(
                      label: 'Password',
                      onChanged: loginNotifier.updatePassword,
                    ),
                    if (loginState.error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          loginState.error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: loginState.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : FilledButton(
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onPressed: loginNotifier.login,
                                  child: Text('LOGIN'),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
