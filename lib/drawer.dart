import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mid_application/password_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_page.dart';

class MidDrawer extends StatefulWidget {
  const MidDrawer({super.key});

  @override
  State<MidDrawer> createState() => _MidDrawerState();
}

class _MidDrawerState extends State<MidDrawer> {
  int? _selectedDrawer;

  deleteAuth() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('schoolCode');
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/logoImg.jpg'),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'MID Card',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider(),
        NavigationDrawerDestination(
          icon: Icon(Icons.groups_rounded),
          label: Text('Social Media'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.play_circle_outline),
          label: Text('How to use'),
        ),
        NavigationDrawerDestination(
            icon: FaIcon(FontAwesomeIcons.key), label: Text('Change Password')),
        NavigationDrawerDestination(
          icon: Icon(Icons.logout),
          label: Text('Logout'),
        ),
      ],
      selectedIndex: _selectedDrawer,
      onDestinationSelected: (value) {
        setState(() {
          _selectedDrawer = value;
          Navigator.of(context).pop();
        });
        if (_selectedDrawer == 1) {
          launchUrl(Uri.parse('https://www.youtube.com/@PrimeVideo/videos'));
        }
        if (_selectedDrawer == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangePassword(
                  schoolCode: '',
                  userName: '',
                ),
              ));
        }
        if (_selectedDrawer == 3) {
          deleteAuth();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        }
      },
    );
  }
}
