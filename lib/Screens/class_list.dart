import 'package:flutter/material.dart';
import 'package:mid_application/Screens/students_list.dart';
import 'package:mid_application/widgets/class_tile.dart';

class ClassList extends StatelessWidget {
  const ClassList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          ClassTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentsList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
