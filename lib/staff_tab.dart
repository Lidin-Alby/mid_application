import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

import 'ip_address.dart';
import 'each_staff_page.dart';

class StaffTab extends StatefulWidget {
  const StaffTab({super.key, required this.schoolCode, required this.menuName});
  final String schoolCode;
  final String menuName;

  @override
  State<StaffTab> createState() => _StaffTabState();
}

class _StaffTabState extends State<StaffTab> {
  String searchText = '';
  late Future _getStaff;
  getStaffsMid() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getMidTeachers/${widget.schoolCode}/other');
    var res = await http.get(url);
    List data = jsonDecode(res.body);
    print(data);

    return data;
  }

  @override
  void initState() {
    _getStaff = getStaffsMid();
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
            future: _getStaff,
            builder: (context, snapshot) {
              List staffs = [];
              if (snapshot.hasData) {
                staffs = snapshot.data;
                return ListView.builder(
                  itemCount: staffs.length,
                  itemBuilder: (context, index) {
                    if (widget.menuName == 'print'
                        ? staffs[index]['ready']
                        : !staffs[index]['ready']) {
                      return Card(
                        child: ListTile(
                          title: Text(staffs[index]['fullName']),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EachStaffPage(
                                schoolCode: widget.schoolCode,
                                mob: staffs[index]['mob'],
                                isTeacher: false,
                                listRefresh: () {
                                  setState(() {
                                    _getStaff = getStaffsMid();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
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
