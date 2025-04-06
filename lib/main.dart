import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Attendance/attendance_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_bloc.dart';

import 'package:mid_application/Blocs/Add%20school/add_school_bloc.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_bloc.dart';
import 'package:mid_application/Blocs/Login/login_bloc.dart';
import 'package:mid_application/Blocs/Login/login_state.dart';
import 'package:mid_application/Blocs/Profile%20Pic/profile_pic_bloc.dart';
import 'package:mid_application/Blocs/School%20List/school_bloc.dart';
import 'package:mid_application/Blocs/School%20List/school_event.dart';
import 'package:mid_application/Blocs/School%20details/school_details_bloc.dart';
import 'package:mid_application/Blocs/Staff%20Details/staff_details_bloc.dart';
import 'package:mid_application/Blocs/Staff/staff_bloc.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_bloc.dart';
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
          create: (context) => StaffDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => StaffBloc(context.read<StaffDetailsBloc>()),
        ),
        BlocProvider(
          create: (context) => StudentDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => StudentBloc(context.read<StudentDetailsBloc>()),
        ),
        BlocProvider(
          create: (context) => FormSettingsBloc(),
        ),
        BlocProvider(
          create: (context) => ProfilePicBloc(
              context.read<StudentBloc>(),
              context.read<StudentDetailsBloc>(),
              context.read<StaffBloc>(),
              context.read<StaffDetailsBloc>()),
        ),
        BlocProvider(
          create: (context) => AttendanceBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Theme.of(context).colorScheme.onPrimary,
            ),
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
