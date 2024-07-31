import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

import 'ip_address.dart';
import 'each_staff_page.dart';

class TeacherTab extends StatefulWidget {
  const TeacherTab(
      {super.key, required this.schoolCode, required this.menuName});

  final String schoolCode;
  final String menuName;

  @override
  State<TeacherTab> createState() => _TeacherTabState();
}

class _TeacherTabState extends State<TeacherTab> {
  String searchText = '';
  late Future _getTeachers;
  getTeachersMid() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getMidTeachers/${widget.schoolCode}/teacher');
    var res = await http.get(url);
    List data = jsonDecode(res.body);
    print(data);

    return data;
  }

  @override
  void initState() {
    _getTeachers = getTeachersMid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
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
        Expanded(
          child: FutureBuilder(
            future: _getTeachers,
            builder: (context, snapshot) {
              List teachers = [];
              if (snapshot.hasData) {
                teachers = snapshot.data;
                teachers = teachers
                    .where((element) => element['fullName']
                        .toLowerCase()
                        .startsWith(searchText.toLowerCase()))
                    .toList();
                return ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      bool value = true;
                      switch (widget.menuName) {
                        case 'print':
                          value = teachers[index]['ready'] ?? false;
                          break;
                        case 'unchecked':
                          value = teachers[index]['ready'] == null
                              ? false
                              : !teachers[index]['ready'];
                          break;
                        case 'noPhoto':
                          value = teachers[index]['profilePic'] == '';
                        case 'printing':
                          value = teachers[index]['printed'] == null
                              ? false
                              : !teachers[index]['printed'];
                          break;
                        case 'printed':
                          value = teachers[index]['printed'] ?? false;
                          break;
                      }
                      if (value) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              onForegroundImageError: (exception, stackTrace) =>
                                  Text('data'),
                              child: Icon(
                                Icons.account_circle,
                                size: 40,
                              ),
                              key: UniqueKey(),
                              foregroundImage: NetworkImage(
                                  "${Uri.parse('$ipv4/getStaffPicMid/${widget.schoolCode}/${teachers[index]['mob']}')}"),
                            ),
                            title: Text(teachers[index]['fullName']),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EachStaffPage(
                                schoolCode: widget.schoolCode,
                                mob: teachers[index]['mob'],
                                isTeacher: true,
                                listRefresh: () {
                                  setState(() {
                                    _getTeachers = getTeachersMid();
                                  });
                                },
                              ),
                            )),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }
                    // : SizedBox(),
                    );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
