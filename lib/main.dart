import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mid_application/Blocs/login_bloc.dart';
import 'package:mid_application/Blocs/login_state.dart';
import 'package:mid_application/Screens/agent_home_screen.dart';

import 'package:mid_application/Screens/login_screen.dart';
import 'package:mid_application/login_page.dart';

import 'package:mid_application/providers/login_provider.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginNotifier.checkAuth();
    });
    if (loginState.token != null) {
      return AgentHomeScreen();
    } else {
      return LoginScreen();
    }
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // final loggedIn = prefs.containsKey('token');
  // final schoolCode = prefs.getString('schoolCode');
  // final user = prefs.getString('user');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 245, 243, 244),
          foregroundColor: Colors.black,
          elevation: 0,
          shape: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
        ),
        useMaterial3: false,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoggedIn) {
              return AgentHomeScreen();
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => AgentHomeScreen(),
              //     ));
            } else {
              return LoginScreen();
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => LoginScreen(),
              //     ));
            }
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
