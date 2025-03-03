import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mid_application/Screens/login_screen.dart';
import 'package:mid_application/login_page.dart';
import 'package:mid_application/mid_agent_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // final loggedIn = prefs.containsKey('token');
  // final schoolCode = prefs.getString('schoolCode');
  // final user = prefs.getString('user');

  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
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
            accentColor: Colors.orangeAccent,
          ),
          useMaterial3: false,
        ),
        home: LoginScreen());
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
