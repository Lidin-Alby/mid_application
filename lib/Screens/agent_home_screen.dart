import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mid_application/Blocs/Login/login_bloc.dart';
import 'package:mid_application/Blocs/Login/login_event.dart';

import 'package:mid_application/Blocs/School%20List/school_bloc.dart';
import 'package:mid_application/Blocs/School%20List/school_event.dart';
import 'package:mid_application/Blocs/School%20List/school_state.dart';
import 'package:mid_application/Screens/add_school_model.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mid_application/Screens/change_password_screen.dart';
import 'package:mid_application/Screens/manual_screen.dart';
import 'package:mid_application/Screens/school_details_screen.dart';

import 'package:mid_application/Screens/school_home_screen.dart';
import 'package:mid_application/Screens/socials_screen.dart';
import 'package:mid_application/models/school.dart';
import 'package:mid_application/widgets/drawer_tile.dart';
import 'package:mid_application/widgets/profile_pic.dart';

// class AgentHomeScreen extends ConsumerWidget {
//   const AgentHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final loginNotifier = ref.read(loginProvider.notifier);
//     final schoolListAsyncValue = ref.read(schoolListProvider);

//     return

//   }
// }

// import 'package:flutter/material.dart';

class AgentHomeScreen extends StatefulWidget {
  const AgentHomeScreen({super.key});

  @override
  State<AgentHomeScreen> createState() => _AgentHomeScreenState();
}

class _AgentHomeScreenState extends State<AgentHomeScreen> {
  String searchText = '';
  bool onSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: onSearch
            ? Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SizedBox(
                  height: 34,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Theme.of(context).colorScheme.primary,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              )
            : Text('Dashboard'),
        actions: [
          if (!onSearch)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      onSearch = true;
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
        ],
      ),
      body: BlocBuilder<SchoolListBloc, SchoolListState>(
          // listener: (context, state) {},
          // bloc: schoolListBloc,
          builder: (context, state) {
        if (state is SchoolListError) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is SchoolListLoaded) {
          List<School> schools = state.schools;

          schools = schools
              .where(
                (element) =>
                    element.schoolName.toLowerCase().startsWith(searchText),
              )
              .toList();
          return schools.isEmpty
              ? Center(
                  child: Text('No schools added'),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<SchoolListBloc>().add(LoadschoolList());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ListView.builder(
                      itemCount: schools.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: Slidable(
                          startActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                                icon: Icons.edit_outlined,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(6)),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                onPressed: (context) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SchoolDetailsScreen(
                                        school: schools[index],
                                      ),
                                    ),
                                  );
                                })
                          ]),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                onSearch = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SchoolHomeScreen(
                                    logo: schools[index].schoolLogo.toString(),
                                    schoolCode: schools[index].schoolCode,
                                  ),
                                ),
                              );
                            },
                            child: Ink(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  ProfilePicWidget(
                                      size: 52,
                                      profilePic:
                                          schools[index].schoolLogo.toString(),
                                      schoolCode: schools[index].schoolCode),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        schools[index].schoolName.toString(),
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        schools[index]
                                            .principalPhone
                                            .toString(),
                                        style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            isScrollControlled: true,
            showDragHandle: true,
            context: context,
            builder: (context) => AddSchoolModel(
                // schoolListBloc: schoolListBloc,
                )),
      ),
      drawer: Drawer(
        width: 210,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  'MID Card',
                  style: GoogleFonts.inter(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
              ),
              DrawerTile(
                icon: FontAwesomeIcons.instagram,
                label: 'Socials',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SocialsScreen(),
                  ),
                ),
              ),
              DrawerTile(
                icon: FontAwesomeIcons.book,
                label: 'Manual',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManualScreen(),
                  ),
                ),
              ),
              DrawerTile(
                icon: FontAwesomeIcons.key,
                iconSize: 16,
                label: 'Change Password',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(),
                  ),
                ),
              ),
              DrawerTile(
                onTap: () {
                  BlocProvider.of<LoginBloc>(context).add(LogoutPressed());
                },
                icon: Icons.logout,
                label: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
