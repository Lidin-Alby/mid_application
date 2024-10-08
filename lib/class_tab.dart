import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ip_address.dart';
import 'each_student_page.dart';

class ClassTab extends StatefulWidget {
  const ClassTab({super.key, required this.schoolCode, required this.menuName});
  final String schoolCode;
  final String menuName;

  @override
  State<ClassTab> createState() => _ClassTabState();
}

class _ClassTabState extends State<ClassTab> {
  late Future _getClasses;

  getClass() async {
    Map data = {};
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    print(user);
    if (user == 'midTeacher') {
      var url = Uri.parse('$ipv4/getMyClasses');
      final String? token = prefs.getString('token');
      var res = await http.get(url, headers: {'authorization': token!});
      print(res.body);
      data = jsonDecode(res.body);
    } else {
      var url = Uri.parse('$ipv4/getMidClasses/${widget.schoolCode}');
      var res = await http.get(url);
      print(res.body);
      data = jsonDecode(res.body);
    }
    return data;

    // var client = BrowserClient()..withCredentials = true;
  }

  @override
  void initState() {
    _getClasses = getClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getClasses,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List classes = [];
          classes = snapshot.data['classes'];
          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) => Card(
                child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.class_)),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EachClassPage(
                  schoolCode: widget.schoolCode,
                  classTitle: classes[index]['title'],
                  menuName: widget.menuName,
                ),
              )),
              title: Text(
                classes[index]['title'],
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Total Students: ${classes[index]['count']}',
                style: TextStyle(fontSize: 16),
              ),
            )),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class EachClassPage extends StatefulWidget {
  const EachClassPage(
      {super.key,
      required this.schoolCode,
      required this.classTitle,
      required this.menuName});
  final String schoolCode;
  final String classTitle;
  final String menuName;

  @override
  State<EachClassPage> createState() => _EachClassPageState();
}

class _EachClassPageState extends State<EachClassPage> {
  Set filter = {'all'};
  late Future _getStudents;
  // late bool printReady;
  late String barTitle;
  String searchText = '';
  bool search = false;
  String sort = 'name';

  Future getStudentsEachClass() async {
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
        appBar: search
            ? AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    setState(() {
                      search = false;
                      searchText = '';
                    });
                  },
                ),
                title: Text(widget.classTitle),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(65),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          isDense: true,
                          hintText: 'Search',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                ),
              )
            : AppBar(
                title: Text(widget.classTitle),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          search = true;
                        });
                      },
                      icon: Icon(Icons.search))
                ],
              ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.menuName == 'unchecked')
                  SegmentedButton(
                    segments: [
                      ButtonSegment(label: Text('All'), value: 'all'),
                      ButtonSegment(
                          label: Text('Unchecked'), value: 'unchecked'),
                      ButtonSegment(label: Text('Checked'), value: 'checked')
                    ],
                    selected: filter,
                    // multiSelectionEnabled: true,
                    onSelectionChanged: (p0) {
                      setState(() {
                        // print(p0);
                        filter = p0;
                      });
                    },
                  ),
                SizedBox(
                  width: 10,
                ),
                MenuAnchor(
                  builder: (context, controller, child) =>
                      IconButton.filledTonal(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: Icon(Icons.sort_rounded),
                  ),
                  menuChildren: [
                    RadioMenuButton(
                      value: 'name',
                      groupValue: sort,
                      onChanged: (value) {
                        setState(() {
                          sort = value!;
                        });
                      },
                      child: Text('Name'),
                    ),
                    RadioMenuButton(
                      value: 'admNo',
                      groupValue: sort,
                      onChanged: (value) {
                        setState(() {
                          sort = value!;
                        });
                      },
                      child: Text('Adm No.'),
                    ),
                    RadioMenuButton(
                      value: 'date',
                      groupValue: sort,
                      onChanged: (value) {
                        setState(() {
                          sort = value!;
                        });
                      },
                      child: Text('Date Modified'),
                    )
                  ],
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   children: [
            //     ActionChip(
            //       label: Text('All'),
            //       onPressed: () {
            //         setState(() {
            //           filter = 'all';
            //         });
            //       },
            //     ),
            //   ],
            // ),
            Expanded(
              child: FutureBuilder(
                future: _getStudents,
                builder: (context, snapshot) {
                  List students = [];

                  if (snapshot.hasData) {
                    // searchText.startsWith(pattern)
                    students = snapshot.data;
                    switch (sort) {
                      case 'admNo':
                        students.sort(
                          (a, b) => a['admNo'].compareTo(b['admNo']),
                        );
                        break;
                      case 'date':
                        students.sort(
                          (a, b) => DateTime.parse(b['modified'])
                              .compareTo(DateTime.parse(a['modified'])),
                        );
                        break;

                      default:
                        students.sort(
                          (a, b) => a['fullName'].compareTo(b['fullName']),
                        );
                    }

                    switch (filter.first) {
                      case 'checked':
                        students = students
                            .where((element) => element['check'])
                            .toList();
                        break;
                      case 'unchecked':
                        students = students
                            .where((element) => !element['check'])
                            .toList();
                    }
                    students = students
                        .where((element) => element['fullName']
                            .toLowerCase()
                            .startsWith(searchText.toLowerCase()))
                        .toList();
                    return RefreshIndicator(
                      onRefresh: getStudentsEachClass,
                      child: ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          bool value = false;

                          switch (widget.menuName) {
                            case 'list':
                              value = true;
                              break;
                            case 'print':
                              value = students[index]['ready'] ?? false;
                              break;
                            case 'unchecked':
                              {
                                if (students[index]['ready'] == false &&
                                    students[index]['printed'] == null) {
                                  value = true;
                                }
                              }
                              break;
                            case 'noPhoto':
                              value = students[index]['profilePic'] == '';
                            case 'printing':
                              {
                                if (students[index]['printed'] == false) {
                                  value = false;
                                }
                              }
                              break;
                            case 'printed':
                              {
                                if (students[index]['printed'] == true) {
                                  value = true;
                                }
                              }
                              break;
                          }

                          if (value) {
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EachStudentPage(
                                    schoolCode: widget.schoolCode,
                                    admNo: students[index]['admNo'],
                                    listRefresh: () {
                                      setState(() {
                                        _getStudents = getStudentsEachClass();
                                      });
                                    },
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CircleAvatar(
                                      radius: 45,
                                      onForegroundImageError:
                                          (exception, stackTrace) =>
                                              CircleAvatar(
                                        foregroundImage: AssetImage(
                                            'assets/images/logoImg.jpg'),
                                      ),
                                      child: Icon(
                                        Icons.account_circle,
                                        size: 90,
                                      ),
                                      key: UniqueKey(),
                                      foregroundImage: students[index]
                                                      ['profilePic'] ==
                                                  '' ||
                                              !students[index]
                                                  .containsKey('profilePic')
                                          ? AssetImage(
                                              'assets/images/logoImg.jpg')
                                          : NetworkImage(
                                                  "${Uri.parse('$ipv4/getProfilePicMid/${widget.schoolCode}/?admNo=${Uri.encodeQueryComponent(students[index]['admNo'])}')}")
                                              as ImageProvider,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 220,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            students[index]['fullName'],
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            'Adm No.: ${students[index]['admNo']}',
                                          ),
                                          Text(
                                            'Father Name: ${students[index]['fatherName']}',
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            'Mother Name: ${students[index]['motherName']}',
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                          ),
                                          Text(
                                              'DOB: ${students[index]['dob']}'),
                                        ],
                                      ),
                                    ),
                                    if (students[index]['check'])
                                      Icon(Icons.check_circle_outline_rounded),
                                  ],

                                  //   future: _getProfilePic,
                                  //   builder: (context, snapshot) {
                                  //     if (snapshot.hasData) {
                                  //       return CircleAvatar(
                                  //         onForegroundImageError: (exception, stackTrace) =>
                                  //             Text('data'),
                                  //         child: Icon(
                                  //           Icons.account_circle,
                                  //           size: 100,
                                  //         ),
                                  //         radius: 50,
                                  //         foregroundImage:
                                  //             MemoryImage(snapshot.data as Uint8List),
                                  //       );
                                  //     } else {
                                  //       return Icon(Icons.error_outline_rounded);
                                  //     }
                                  //   },
                                  // ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ));
  }
}
