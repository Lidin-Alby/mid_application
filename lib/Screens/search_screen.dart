import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mid_application/Screens/staff_details_screen.dart';
import 'package:mid_application/Screens/student_details_screen.dart';
import 'package:mid_application/ip_address.dart';
import 'package:mid_application/widgets/my_app_bar.dart';

import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.schoolCode, required this.logo});
  final String schoolCode;
  final String logo;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // TextEditingController searchTextcontroller = TextEditingController();
  List searchResults = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        schoolCode: widget.schoolCode,
        logo: widget.logo,
        autofocus: true,
        onChanged: (value) async {
          if (value.trim().isNotEmpty) {
            var url = Uri.parse(
                '$ipv4/v2/searchAll/${Uri.encodeQueryComponent(widget.schoolCode)}/?term=$value');
            var res = await http.get(url);
            if (res.statusCode == 200) {
              List data = jsonDecode(res.body);
              setState(() {
                searchResults = data;
              });
            }
          }
        },
        onTap: () {},
      ),
      body: searchResults.isEmpty
          ? Center(child: Text('No results found'))
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                Map user = searchResults[index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => user['designation'] == 'student'
                          ? StudentDetailsScreen(
                              ready: (user['printStatus'] == "printing" ||
                                  user['printStatus'] == "printed" ||
                                  user['printStatus'] == "ready"),
                              schoolCode: widget.schoolCode,
                              admNo: user['userNo'])
                          : StaffDetailsScreen(
                              ready: (user['printStatus'] == "printing" ||
                                  user['printStatus'] == "printed" ||
                                  user['printStatus'] == "ready"),
                              schoolCode: widget.schoolCode,
                              isTeacher: user['designation'] == 'midTeacher',
                              mob: user['userNo'],
                            ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '${user['userNo']} - ${user['fullName']}',
                        ),
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
