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

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
            Align(
              alignment: Alignment.center,
              child: Text(
                'v2.0.0.0',
                style: GoogleFonts.inter(
                    fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
