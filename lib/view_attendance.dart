import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'attendance_details.dart';
import 'ip_address.dart';

class ViewAttendance extends StatefulWidget {
  const ViewAttendance(
      {super.key, required this.schoolCode, required this.classTitle});
  final String schoolCode;
  final String classTitle;

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  late Future _getStudents;
  getStudentsEachClass() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse(
        '$ipv4/eachClassMid/${widget.schoolCode}/${widget.classTitle}');
    var res = await http.get(url);

    print('done');
    print(res.body);
    List data = jsonDecode(res.body);

    return data;
  }

  @override
  void initState() {
    _getStudents = getStudentsEachClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classTitle),
      ),
      body: FutureBuilder(
        future: _getStudents,
        builder: (context, snapshot) {
          List students = [];
          if (snapshot.hasData) {
            students = snapshot.data;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  title: Text(students[index]['fullName']),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AttendanceDetails(
                        schoolCode: widget.schoolCode,
                        admNo: students[index]['admNo'],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
