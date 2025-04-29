import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/Login/login_bloc.dart';
import 'package:mid_application/Blocs/Login/login_event.dart';
import 'package:mid_application/Screens/change_password_screen.dart';
import 'package:mid_application/Screens/manual_screen.dart';
import 'package:mid_application/Screens/socials_screen.dart';
import 'package:mid_application/widgets/drawer_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int tapCount = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            Spacer(),
            GestureDetector(
              onTap: () {
                if (tapCount == 5) {
                  launchUrl(
                      Uri.parse('https://lidin-alby.github.io/portfolio/'));
                }

                tapCount++;
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'v2.0.0.0',
                      style: GoogleFonts.inter(
                          fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
