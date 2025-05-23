import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mid_application/Blocs/Class%20Model/class_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_event.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_bloc.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_event.dart';
import 'package:mid_application/Blocs/Login/login_bloc.dart';
import 'package:mid_application/Blocs/Login/login_state.dart';
import 'package:mid_application/Blocs/School%20details/school_details_bloc.dart';
import 'package:mid_application/Blocs/School%20details/school_details_event.dart';
import 'package:mid_application/Blocs/School%20details/school_details_state.dart';
import 'package:mid_application/Screens/add_class_screen.dart';
import 'package:mid_application/Screens/attendance_dashboard.dart';
import 'package:mid_application/Screens/form_settings_screen.dart';
import 'package:mid_application/Screens/school_dashboard.dart';
import 'package:mid_application/Screens/search_screen.dart';
import 'package:mid_application/Screens/staff_details_screen.dart';
import 'package:mid_application/Screens/student_details_screen.dart';
import 'package:mid_application/widgets/dialog_button.dart';
import 'package:mid_application/widgets/my_app_bar.dart';
import 'package:mid_application/widgets/my_drawer.dart';
import 'package:mid_application/widgets/my_navigation_button.dart';

class SchoolHomeScreen extends StatefulWidget {
  const SchoolHomeScreen(
      {super.key, required this.schoolCode, required this.isStaff});
  final String schoolCode;
  final bool isStaff;

  @override
  State<SchoolHomeScreen> createState() => _SchoolHomeScreenState();
}

class _SchoolHomeScreenState extends State<SchoolHomeScreen> {
  int _selectedIndex = 0;
  String? logo;

  @override
  void initState() {
    context.read<SchoolDetailsBloc>().add(GetSchoolDetails(widget.schoolCode));
    context.read<FormSettingsBloc>().add(LoadFormSettings(widget.schoolCode));
    context.read<ClassBloc>().add(LoadClasses(widget.schoolCode));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolDetailsBloc, SchoolDetailsState>(
        builder: (context, state) {
      return Scaffold(
        appBar: MyAppBar(
          schoolCode: widget.schoolCode,
          logo: state is SchoolDetailsLoaded
              ? state.school.schoolLogo.toString()
              : '',
          readonly: true,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(
                logo: logo.toString(),
                schoolCode: widget.schoolCode,
              ),
            ),
          ),
          onChanged: (value) {},
        ),
        body: _selectedIndex == 0
            ? SchoolDashboard(
                schoolCode: widget.schoolCode,
              )
            : AttendanceDashboard(
                schoolCode: widget.schoolCode,
              ),
        bottomNavigationBar: Container(
          height: 75,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 3,
                color: const Color.fromARGB(60, 0, 0, 0),
              )
            ],
          ),
          child: Material(
            color: const Color.fromARGB(255, 255, 252, 242),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyNavigationButton(
                  selectedIcon: Icons.dashboard,
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  selected: _selectedIndex == 0,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                MyNavigationButton(
                  icon: Icons.event_note_outlined,
                  selectedIcon: Icons.event_note,
                  label: 'Attendance',
                  selected: _selectedIndex == 1,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.add),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    double width = MediaQuery.of(context).size.width;
                    double padding = width - 310;

                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      insetPadding: EdgeInsets.symmetric(horizontal: padding),
                      // width: 100,
                      backgroundColor: Color.fromARGB(255, 37, 36, 34),
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoggedIn) {
                            String user = state.user;
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Wrap(
                                spacing: 30, runSpacing: 50,
                                alignment: WrapAlignment.center,
                                // crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  if (user == 'head' || user == 'agent')
                                    DialogButton(
                                      icon: Icons.settings_outlined,
                                      label: 'Form Settings',
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FormSettingsScreen(
                                            schoolCode: widget.schoolCode,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (user == 'head' || user == 'agent')
                                    DialogButton(
                                      icon: Icons.badge_outlined,
                                      label: 'Add Class',
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddClassScreen(
                                            schoolCode: widget.schoolCode,
                                          ),
                                        ),
                                      ),
                                    ),
                                  DialogButton(
                                    icon: Icons.person_outline,
                                    label: 'Add Student',
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentDetailsScreen(
                                          ready: false,
                                          schoolCode: widget.schoolCode,
                                          admNo: null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (user == 'head' || user == 'agent')
                                    DialogButton(
                                      icon: Symbols.person_edit,
                                      label: 'Add Teacher',
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StaffDetailsScreen(
                                            ready: false,
                                            schoolCode: widget.schoolCode,
                                            isTeacher: true,
                                            mob: null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (user == 'head' || user == 'agent')
                                    DialogButton(
                                      icon: Icons.manage_accounts_outlined,
                                      label: 'Add Staff',
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StaffDetailsScreen(
                                            ready: false,
                                            schoolCode: widget.schoolCode,
                                            isTeacher: false,
                                            mob: null,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    );
                  },
                ),
              )
            : null,
        drawer: widget.isStaff ? MyDrawer() : null,
      );
    });
  }
}
