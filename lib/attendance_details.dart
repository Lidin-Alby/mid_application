import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mid_application/month_selector.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  DateTime _selectedDate = DateTime.now();
  String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late int selectedYear;

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

  markMidAttendanceDate(String date, String status) async {
    var url = Uri.parse('$ipv4/markMidAttendanceDate');
    var res = await http.post(url, body: {
      'admNo': widget.admNo,
      'schoolCode': widget.schoolCode,
      'date': date,
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
              getMidAttendance(DateFormat('MM-yyyy').format(_selectedDate));
        });
      }
    }
  }

  @override
  void initState() {
    selectedYear = _selectedDate.year;
    _getAttendance =
        getMidAttendance(DateFormat('MM-yyyy').format(_selectedDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> dates = [];
    final firstDay = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDay = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);

    for (int i = firstDay.day - 1; i < lastDay.day; i++) {
      dates.add(
          DateFormat('dd-MM-yyyy').format(firstDay.add(Duration(days: i))));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Details'),
      ),
      body: Center(
          child: FutureBuilder(
        future: _getAttendance,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map student = {};
            student = snapshot.data;
            Map attendance = {};
            if (snapshot.data.containsKey('attendance')) {
              attendance = snapshot.data['attendance'];
              // print(attendance.keys);
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  QrImageView(
                    data: widget.admNo,
                    size: 150,
                  ),
                  Text('Name: ${student['fullName']}'),
                  Text('Adm. No.${student['admNo']}'),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Absent'),
                      Switch(
                        activeColor: Colors.green[600],
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red[100],
                        value: attendance[today] == 'present',
                        onChanged: (value) {
                          if (value) {
                            markMidAttendanceDate(today, 'present');
                          } else {
                            markMidAttendanceDate(today, 'absent');
                          }
                        },
                      ),
                      Text('Present'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(DateFormat('yMMMM').format(_selectedDate)),
                      ),
                      IconButton.filledTonal(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) => MonthSelector(
                                    selectedDate: _selectedDate,
                                    setYear: (p0) {
                                      setState(() {
                                        _selectedDate = p0;
                                      });
                                    },
                                  )),
                          icon: Icon(Icons.edit))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(),
                        verticalInside: BorderSide(),
                      ),
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orange.shade50),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Date'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Status'),
                                ),
                              ),
                            ]),
                        for (String date in dates)
                          TableRow(children: [
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                child: Text(date),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('A'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Switch(
                                          activeColor: Colors.green[600],
                                          inactiveTrackColor: Colors.red[100],
                                          inactiveThumbColor: Colors.red,
                                          value: attendance[date] == 'present',
                                          onChanged: (value) {
                                            setState(() {
                                              if (value) {
                                                markMidAttendanceDate(
                                                    date, 'present');
                                              } else {
                                                markMidAttendanceDate(
                                                    date, 'absent');
                                              }
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('P'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ])
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
