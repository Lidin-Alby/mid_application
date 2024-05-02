import 'package:flutter/material.dart';
import 'package:mid_application/login_page.dart';
import 'package:mid_application/mid_agent_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.containsKey('token');
  final schoolCode = prefs.getString('schoolCode');
  final user = prefs.getString('user');

  runApp(MyApp(
      isLoggedIn: loggedIn, schoolCode: schoolCode, user: user.toString()));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.isLoggedIn,
      required this.schoolCode,
      required this.user});

  final bool isLoggedIn;
  final String? schoolCode;
  final String user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: schoolCode == null
          ? LoginPage()
          : schoolCode == 'mid'
              ? MidAgentHome()
              : RightMenu(schoolCode: schoolCode!, user: user),
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
