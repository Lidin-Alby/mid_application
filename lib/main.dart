import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Class/class_bloc.dart';

import 'package:mid_application/Blocs/Add%20school/add_school_bloc.dart';
import 'package:mid_application/Blocs/Login/login_bloc.dart';
import 'package:mid_application/Blocs/Login/login_state.dart';
import 'package:mid_application/Blocs/School%20List/school_bloc.dart';
import 'package:mid_application/Blocs/School%20List/school_event.dart';
import 'package:mid_application/Blocs/School%20details/school_details_bloc.dart';
import 'package:mid_application/Blocs/Student/student_bloc.dart';
import 'package:mid_application/Screens/agent_home_screen.dart';

import 'package:mid_application/Screens/login_screen.dart';
import 'package:mid_application/login_page.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => SchoolListBloc()..add(LoadschoolList()),
        ),
        BlocProvider(
          create: (context) => AddSchoolBloc(context.read<SchoolListBloc>()),
        ),
        BlocProvider(
          create: (context) => SchoolDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => ClassBloc(),
        ),
        BlocProvider(
          create: (context) => StudentBloc(),
        )
      ],
      child: MaterialApp(
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
          fontFamily: 'Inter',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepOrange,
          ),
          useMaterial3: false,
        ),
        home: BlocBuilder<LoginBloc, LoginState>(
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
