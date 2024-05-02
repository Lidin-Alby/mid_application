import 'package:flutter/material.dart';

import 'class_tab.dart';
import 'staff_tab.dart';
import 'teacher_tab.dart';

class ListAll extends StatelessWidget {
  const ListAll({super.key, required this.schoolCode, required this.user});
  final String schoolCode;
  final String user;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: user == 'head' || user == 'agent' ? 3 : 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('List'),
          bottom: TabBar(tabs: [
            Tab(
              child: Text('Class'),
            ),
            if (user == 'head' || user == 'agent')
              Tab(
                child: Text('Teachers'),
              ),
            if (user == 'head' || user == 'agent')
              Tab(
                child: Text('Staff'),
              ),
          ]),
        ),
        body: TabBarView(children: [
          ClassTab(
            schoolCode: schoolCode,
            menuName: 'list',
          ),
          if (user == 'head' || user == 'agent')
            TeacherTab(
              schoolCode: schoolCode,
              menuName: 'list',
            ),
          if (user == 'head' || user == 'agent')
            StaffTab(
              schoolCode: schoolCode,
              menuName: 'list',
            ),
        ]),
      ),
    );
  }
}