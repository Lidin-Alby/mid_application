import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mid_application/each_student_page.dart';
import 'package:mid_application/ip_address.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  bool search = false;
  late Future _getStudents;

  getAllMidStudents(String term) async {
    var url = Uri.parse(
        '$ipv4/allForSearch/${widget.schoolCode}/?term=${Uri.encodeQueryComponent(term)}');

    var res = await http.get(url);

    List data = jsonDecode(res.body);
    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
            _getStudents = getAllMidStudents(value);
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            filled: true,
            isDense: true,
            hintText: 'Search',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: searchText != ''
          ? FutureBuilder(
              future: _getStudents,
              builder: (context, snapshot) {
                List students = [];
                if (snapshot.hasData) {
                  students = snapshot.data;
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(students[index]['fullName']),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EachStudentPage(
                          schoolCode: widget.schoolCode,
                          admNo: students[index]['admNo'],
                          listRefresh: () {},
                        ),
                      )),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          : SizedBox(),
    );
  }
}
