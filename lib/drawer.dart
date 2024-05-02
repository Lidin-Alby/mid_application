import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        NavigationDrawerDestination(
          icon: Icon(Icons.logout),
          label: Text('Logout'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.logout),
          label: Text('hello'),
        ),
      ],
      selectedIndex: _selectedDrawer,
      onDestinationSelected: (value) {
        setState(() {
          _selectedDrawer = value;
          Navigator.of(context).pop();
        });
        if (_selectedDrawer == 0) {
          deleteAuth();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        }
      },
    );
  }
}
