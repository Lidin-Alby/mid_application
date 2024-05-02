import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ip_address.dart';
import 'add_staff_page.dart';
import 'add_student.dart';
import 'add_teacher.dart';
import 'form_settings.dart';
import 'mid_tile_widget.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key, required this.schoolCode, required this.user});

  final String schoolCode;
  final String user;
  // final String schoolName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.maximize_rounded,
            size: 40,
          ),
          // SizedBox(
          //   height: 15,
          // ),
          // Text(
          //   '$schoolName\n$schoolCode',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          if (user == 'head' || user == 'agent')
            Row(
              children: [
                MidTile(
                  icon: Icons.book,
                  title: 'Add Class',
                  color: Colors.blue,
                  callback: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddClassPage(
                        schoolCode: schoolCode,
                      ),
                    ));
                  },
                ),
              ],
            ),
          if (user == 'head' || user == 'agent')
            Row(
              children: [
                MidTile(
                  icon: Icons.view_list_rounded,
                  title: 'Form Settings',
                  color: Colors.black,
                  callback: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormSettingsPage(
                        schoolCode: schoolCode,
                      ),
                    ));
                  },
                ),
              ],
            ),
          if (user == 'head' || user == 'agent')
            Row(
              children: [
                MidTile(
                  icon: Icons.add_rounded,
                  title: 'Add Teacher',
                  color: Colors.teal,
                  callback: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddTeacherPage(
                        schoolCode: schoolCode,
                      ),
                    ));
                  },
                ),
              ],
            ),
          if (user == 'head' || user == 'agent')
            Row(
              children: [
                MidTile(
                  icon: Icons.add_rounded,
                  title: 'Add Staff',
                  color: Colors.purple,
                  callback: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AddStaffPage(schoolCode: schoolCode),
                    ));
                  },
                ),
              ],
            ),
          Row(
            children: [
              MidTile(
                icon: Icons.add_rounded,
                title: 'Add Student',
                color: Colors.brown,
                callback: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AddStudentPage(schoolCode: schoolCode),
                  ));
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class AddClassPage extends StatefulWidget {
  const AddClassPage({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<AddClassPage> createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  TextEditingController className = TextEditingController();
  TextEditingController section = TextEditingController();
  bool validate = false;
  late Future _getClasses;
  getClass() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getMidClasses/${widget.schoolCode}');
    var res = await http.get(url);
    Map data = jsonDecode(res.body);
    return data;
  }

  @override
  void initState() {
    _getClasses = getClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: className,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Class / Department',
                    errorText: validate ? 'This Field is required' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: section,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Section',
                    errorText: validate ? 'This Field is required' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              FilledButton(
                onPressed: () async {
                  setState(() {
                    section.text.trim().isEmpty || className.text.trim().isEmpty
                        ? validate = true
                        : validate = false;
                  });
                  if (!validate) {
                    var url = Uri.parse('$ipv4/addClassOrBranchMid');
                    var res = await http.post(url, body: {
                      'schoolCode': widget.schoolCode,
                      'title':
                          '${className.text.trim()}-${section.text.trim()}',
                      'className': className.text.trim(),
                      'sec': section.text.trim()
                    });
                    if (res.body == 'true') {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green[600],
                            behavior: SnackBarBehavior.floating,
                            content: const Row(
                              children: [
                                Text(
                                  'Added Sucessfully',
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      className.clear();
                      section.clear();
                      setState(() {
                        _getClasses = getClass();
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[600],
                          behavior: SnackBarBehavior.floating,
                          content: Row(
                            children: [
                              Text(
                                res.body,
                              ),
                              Icon(
                                Icons.error,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Text('Add Class'),
              )
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: _getClasses,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List classes = snapshot.data['classes'];

                    return ListView.builder(
                      itemCount: classes.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(classes[index]['title']),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
