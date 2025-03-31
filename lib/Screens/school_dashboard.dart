import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mid_application/Blocs/Class%20Model/class_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_event.dart';
import 'package:mid_application/Blocs/School%20details/school_details_bloc.dart';
import 'package:mid_application/Blocs/School%20details/school_details_event.dart';
import 'package:mid_application/Blocs/School%20details/school_details_state.dart';
import 'package:mid_application/Screens/details_info_screen.dart';
import 'package:mid_application/models/school.dart';
import 'package:mid_application/widgets/counts_column.dart';
import 'package:mid_application/widgets/menu_tile.dart';

class SchoolDashboard extends StatelessWidget {
  const SchoolDashboard({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  Widget build(BuildContext context) {
    context.read<ClassBloc>().add(LoadClasses(schoolCode));
    BlocProvider.of<SchoolDetailsBloc>(context)
        .add(GetSchoolDetails(schoolCode));

    return Stack(
      children: [
        Column(
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.vertical(
                    //   top: Radius.circular(10),
                    // ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 25,
                        spreadRadius: 2,
                        color: const Color.fromARGB(60, 0, 0, 0),
                      ),
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 252, 242),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: BlocBuilder<SchoolDetailsBloc, SchoolDetailsState>(
              builder: (context, state) {
            if (state is SchoolDetailsError) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is SchoolDetailsLoaded) {
              School school = state.school;
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Details',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 25,
                          spreadRadius: 2,
                          color: const Color.fromARGB(60, 0, 0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/logoImg.jpg'),
                                ),
                                Spacer(),
                                Text(
                                  school.schoolName.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  school.principalPhone.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            // height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10),
                              ),
                              color: const Color.fromARGB(255, 245, 243, 244),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CountsColumn(
                                  count: school.studentCount.toString(),
                                  icon: Icons.person_outline_rounded,
                                  label: 'Students',
                                ),
                                CountsColumn(
                                    count: school.teacherCount.toString(),
                                    icon: Symbols.person_edit,
                                    label: 'Class Teachers'),
                                CountsColumn(
                                    count: school.totalStaffCount.toString(),
                                    icon: Icons.groups_outlined,
                                    label: 'Total Staff')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      spacing: 20,
                      children: [
                        Row(
                          spacing: 20,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 25,
                                      spreadRadius: 2,
                                      color: const Color.fromARGB(60, 0, 0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Material(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsInfoScreen(
                                          schoolCode: schoolCode,
                                          listHead: 'all',
                                        ),
                                      ),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      height: 130,
                                      width: 130,
                                      // alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        spacing: 8,
                                        children: [
                                          Icon(
                                            Icons.list_alt,
                                            size: 28,
                                          ),
                                          Text(
                                            'List',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            MenuTile(
                              icon: Icons.cancel_outlined,
                              label: 'Unchecked',
                              cardColor: Colors.black87,
                              color: Colors.white,
                              count: school.uncheckedCount.toString(),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsInfoScreen(
                                    schoolCode: schoolCode,
                                    listHead: 'null',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          spacing: 20,
                          children: [
                            MenuTile(
                              icon: Icons.no_photography_outlined,
                              label: 'No Photos',
                              cardColor: Colors.black87,
                              color: Colors.white,
                              count: school.noPhotosCount.toString(),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsInfoScreen(
                                    schoolCode: schoolCode,
                                    listHead: 'noPhoto',
                                  ),
                                ),
                              ),
                            ),
                            MenuTile(
                              icon: Icons.print_outlined,
                              label: 'Ready to Print',
                              cardColor: Colors.white,
                              count: school.readyPrintCount.toString(),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsInfoScreen(
                                    schoolCode: schoolCode,
                                    listHead: 'ready',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          spacing: 20,
                          children: [
                            MenuTile(
                              icon: Icons.restart_alt,
                              label: 'Printing',
                              cardColor: Colors.white,
                              count: school.printingCount.toString(),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsInfoScreen(
                                    schoolCode: schoolCode,
                                    listHead: 'printing',
                                  ),
                                ),
                              ),
                            ),
                            MenuTile(
                              icon: Icons.done_all_rounded,
                              label: 'Delivered',
                              cardColor: Colors.black87,
                              color: Colors.white,
                              count: school.deliveredCount.toString(),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsInfoScreen(
                                    schoolCode: schoolCode,
                                    listHead: 'printed',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          spacing: 20,
                          children: [
                            MenuTile(
                              icon: Icons.login_rounded,
                              label: 'Login Pending',
                              cardColor: Colors.black87,
                              color: Colors.white,
                              count: school.loginPendingCount.toString(),
                              onTap: () {},
                            ),
                            MenuTile(
                              icon: Icons.badge_outlined,
                              label: 'Card Designs',
                              cardColor: Colors.white,
                              count: '',
                              onTap: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}
