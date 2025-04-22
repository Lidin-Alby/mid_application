import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mid_application/Screens/add_class_screen.dart';
import 'package:mid_application/Screens/attendance_dashboard.dart';
import 'package:mid_application/Screens/form_settings_screen.dart';
import 'package:mid_application/Screens/school_dashboard.dart';
import 'package:mid_application/Screens/search_screen.dart';
import 'package:mid_application/Screens/staff_details_screen.dart';
import 'package:mid_application/Screens/student_details_screen.dart';
import 'package:mid_application/widgets/dialog_button.dart';
import 'package:mid_application/widgets/my_app_bar.dart';
import 'package:mid_application/widgets/my_navigation_button.dart';

class SchoolHomeScreen extends StatefulWidget {
  const SchoolHomeScreen(
      {super.key, required this.schoolCode, required this.logo});
  final String schoolCode;
  final String logo;

  @override
  State<SchoolHomeScreen> createState() => _SchoolHomeScreenState();
}

class _SchoolHomeScreenState extends State<SchoolHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        schoolCode: widget.schoolCode,
        logo: widget.logo,
        readonly: true,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(
              logo: widget.logo,
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
          : AttendanceDashboard(),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 30, runSpacing: 50,
                        alignment: WrapAlignment.center,
                        // crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          DialogButton(
                            icon: Icons.settings_outlined,
                            label: 'Form Settings',
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormSettingsScreen(
                                  schoolCode: widget.schoolCode,
                                ),
                              ),
                            ),
                          ),
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
                                builder: (context) => StudentDetailsScreen(
                                  schoolCode: widget.schoolCode,
                                  admNo: null,
                                ),
                              ),
                            ),
                          ),
                          DialogButton(
                            icon: Symbols.person_edit,
                            label: 'Add Teacher',
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StaffDetailsScreen(
                                  schoolCode: widget.schoolCode,
                                  isTeacher: true,
                                  mob: null,
                                ),
                              ),
                            ),
                          ),
                          DialogButton(
                            icon: Icons.manage_accounts_outlined,
                            label: 'Add Staff',
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StaffDetailsScreen(
                                  schoolCode: widget.schoolCode,
                                  isTeacher: false,
                                  mob: null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : null,
    );
  }
}
