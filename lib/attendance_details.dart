import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'ip_address.dart';

class AttendanceDetails extends StatefulWidget {
  const AttendanceDetails(
      {super.key, required this.admNo, required this.schoolCode});
  final String admNo;
  final String schoolCode;

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  late Future _getAttendance;
  DateTime now = DateTime.now();
  late DateTime today;
  late DateTime _selectedDate;
  late int month;
  late int year;
  // String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late int selectedYear;
  late PageController _pageController;

  List weeks = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  // bool attendance = false;

  getMidAttendance(String month) async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse(
        '$ipv4/getMyAttendanceMid/${widget.schoolCode}/${widget.admNo}/$month');
    var res = await http.get(url);
    print(res.body);
    Map data = jsonDecode(res.body);
    return data;
  }

  markMidAttendanceDate(String status) async {
    var url = Uri.parse('$ipv4/markMidAttendanceDate');
    var res = await http.post(url, body: {
      'admNo': widget.admNo,
      'schoolCode': widget.schoolCode,
      'date': DateFormat('dd-MM-yyyy').format(_selectedDate),
      'status': status
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
                  'Updated Sucessfully',
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                )
              ],
            ),
          ),
        );
        setState(() {
          _getAttendance =
              getMidAttendance(DateFormat('MM-yyyy').format(today));
        });
      }
    }
  }

  Color? setColor(status) {
    Color? color;
    switch (status) {
      case 'absent':
        color = Colors.red;
        break;
      case 'half-day':
        color = Colors.yellow;
        break;
      case 'leave':
        color = Colors.orange;
        break;
    }
    return color;
  }

  @override
  void initState() {
    today = DateTime(now.year, now.month, now.day);

    month = today.month;
    year = today.year;
    _selectedDate = today;

    _pageController = PageController(initialPage: month);
    // selectedYear = _selectedDate.year;
    _getAttendance =
        getMidAttendance(DateFormat('MM-yyyy').format(_selectedDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = [];
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);

    for (int i = firstDay.day - 1; i < lastDay.day; i++) {
      dates.add(firstDay.add(Duration(days: i)));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Attendance Details'),
        ),
        body: FutureBuilder(
          future: _getAttendance,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map attendance = {};
              attendance = snapshot.data['attendance'];
              List options = ['leave', 'absent'];
              return Column(
                children: [
                  SizedBox(
                    height: 435,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          month = value;
                        });
                        if (value == 0) {
                          _pageController.jumpToPage(12);
                          year = year - 1;
                        }
                      },
                      // itemCount: months.length,
                      itemBuilder: (context, index) => Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              DateFormat('MMM-yyyy')
                                  .format(DateTime(year, month)),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 7,
                                children: [
                                  for (String week in weeks)
                                    Center(
                                      child: Text(week),
                                    ),
                                  if (firstDay.weekday != 7)
                                    for (int i = 0; i < firstDay.weekday; i++)
                                      const SizedBox(),
                                  for (DateTime date in dates)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedDate = date;
                                        });
                                      },
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              border: date == _selectedDate
                                                  ? Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)
                                                  : null,
                                              shape: BoxShape.circle,
                                              // borderRadius: BorderRadius.circular(12),
                                              color: setColor(attendance[
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(date)])),
                                          child: Text(
                                            date.day.toString(),
                                            style: TextStyle(
                                              color: date.weekday == 7
                                                  ? Colors.red
                                                  : options.contains(attendance[
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(date)])
                                                      ? Colors.white
                                                      : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(_selectedDate),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Radio(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -2),
                            value: 'present',
                            groupValue: attendance[
                                DateFormat('dd-MM-yyyy').format(_selectedDate)],
                            onChanged: (value) {
                              markMidAttendanceDate(value.toString());
                              setState(() {
                                attendance[DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate)] = value;
                              });
                            },
                          ),
                          Text('Present'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -2),
                            value: 'absent',
                            groupValue: attendance[
                                DateFormat('dd-MM-yyyy').format(_selectedDate)],
                            onChanged: (value) {
                              markMidAttendanceDate(value.toString());
                              setState(() {
                                attendance[DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate)] = value;
                              });
                            },
                          ),
                          Text('Absent'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -2),
                            value: 'half-day',
                            groupValue: attendance[
                                DateFormat('dd-MM-yyyy').format(_selectedDate)],
                            onChanged: (value) {
                              markMidAttendanceDate(value.toString());
                              setState(() {
                                attendance[DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate)] = value;
                              });
                            },
                          ),
                          Text('Half-Day'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -2),
                              value: 'leave',
                              groupValue: attendance[DateFormat('dd-MM-yyyy')
                                  .format(_selectedDate)],
                              onChanged: (value) {
                                markMidAttendanceDate(value.toString());
                                setState(() {
                                  attendance[DateFormat('dd-MM-yyyy')
                                      .format(_selectedDate)] = value;
                                });
                              }),
                          Text('Leave'),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
