import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 252, 242),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(),
          FilledButton(onPressed: () {}, child: Text('Login'))
        ],
      ),
    );
  }
}
