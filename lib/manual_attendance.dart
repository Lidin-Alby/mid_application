import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ip_address.dart';

class ManualAttendance extends StatefulWidget {
  const ManualAttendance(
      {super.key, required this.schoolCode, required this.classTitle});
  final String schoolCode;
  final String classTitle;

  @override
  State<ManualAttendance> createState() => _ManualAttendanceState();
}

class _ManualAttendanceState extends State<ManualAttendance> {
  late Future _getClassAttendance;
  String _selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  List students = [];

  getClassDetailsMid() async {
    var url = Uri.parse(
        '$ipv4/getAttendanceClassMid/$_selectedDate/?scCode=${Uri.encodeQueryComponent(widget.schoolCode)}&classTitle=${Uri.encodeQueryComponent(widget.classTitle)}');
    var res = await http.get(url);
    print(res.body);
    return jsonDecode(res.body);
  }

  saveAttendance() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/saveClassAttendanceMid');
    var res = await http.post(url, body: {
      'students': jsonEncode(students),
      'date': _selectedDate,
      'schoolCode': widget.schoolCode
    });
    print(res.body);
  }

  @override
  void initState() {
    _getClassAttendance = getClassDetailsMid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _getClassAttendance,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            students = snapshot.data;
            for (Map element in students) {
              element.putIfAbsent('status', () => 'absent');
            }

            int presentCount = students
                .where((element) => element['status'] == 'present')
                .length;
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Students: ${snapshot.data.length}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            'Present: $presentCount',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[600]),
                          ),
                          Text(
                            'Absent: ${snapshot.data.length - presentCount}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    FilledButton.icon(
                      icon: Icon(Icons.edit_calendar_outlined),
                      onPressed: () async {
                        DateTime? datetime = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now());
                        setState(() {
                          _selectedDate =
                              DateFormat('dd-MM-yyyy').format(datetime!);
                          _getClassAttendance = getClassDetailsMid();
                        });
                      },
                      label: Text(_selectedDate),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.builder(
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              String status = students[index]['status'];
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        index == students.length - 1 ? 50 : 0),
                                child: Card(
                                  color: status == 'present'
                                      ? Colors.green[100]
                                      : status == 'half-day'
                                          ? Colors.yellow[300]
                                          : status == 'leave'
                                              ? Colors.orange[200]
                                              : Colors.red[100],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      students[index]
                                                          ['fullName'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 225,
                                                          child: Text(
                                                            'Father Name: ${students[index]['fatherName']}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 225,
                                                          child: Text(
                                                            'Mother Name: ${students[index]['motherName']}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child:
                                                          IconButton.outlined(
                                                        iconSize: 20,
                                                        onPressed: () =>
                                                            showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              MobileNoDialog(
                                                            fatherNo: students[
                                                                    index]
                                                                ['fatherMobNo'],
                                                            motherNo: students[
                                                                    index]
                                                                ['motherMobNo'],
                                                            type: 'tel',
                                                          ),
                                                        ),
                                                        icon: Icon(Icons.phone),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child:
                                                          IconButton.outlined(
                                                        iconSize: 20,
                                                        onPressed: () =>
                                                            showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              MobileNoDialog(
                                                            fatherNo: students[
                                                                    index]
                                                                ['fatherMobNo'],
                                                            motherNo: students[
                                                                    index]
                                                                ['motherMobNo'],
                                                            type: 'sms',
                                                          ),
                                                        ),
                                                        icon: Icon(
                                                            Icons.chat_rounded),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    SizedBox(
                                                      width: 41,
                                                      height: 41,
                                                      child: IconButton.filled(
                                                        iconSize: 25,
                                                        onPressed: () =>
                                                            showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              MobileNoDialog(
                                                            fatherNo: students[
                                                                    index][
                                                                'fatherWhatsApp'],
                                                            motherNo: students[
                                                                    index][
                                                                'motherWhatsApp'],
                                                            type: 'whatsapp',
                                                          ),
                                                        ),
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .whatsapp,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    visualDensity:
                                                        VisualDensity(
                                                            horizontal: -4,
                                                            vertical: -2),
                                                    value: 'present',
                                                    groupValue: students[index]
                                                        ['status'],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        students[index]
                                                            ['status'] = value;
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
                                                        VisualDensity(
                                                            horizontal: -4,
                                                            vertical: -2),
                                                    value: 'absent',
                                                    groupValue: students[index]
                                                        ['status'],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        students[index]
                                                            ['status'] = value;
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
                                                        VisualDensity(
                                                            horizontal: -4,
                                                            vertical: -2),
                                                    value: 'half-day',
                                                    groupValue: students[index]
                                                        ['status'],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        students[index]
                                                            ['status'] = value;
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
                                                          VisualDensity(
                                                              horizontal: -4,
                                                              vertical: -2),
                                                      value: 'leave',
                                                      groupValue:
                                                          students[index]
                                                              ['status'],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          students[index]
                                                                  ['status'] =
                                                              value;
                                                        });
                                                      }),
                                                  Text('Leave'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton(
                      onPressed: saveAttendance,
                      child: Text('Submit'),
                      style: FilledButton.styleFrom(
                        shape: LinearBorder(),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ],
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class MobileNoDialog extends StatelessWidget {
  const MobileNoDialog(
      {super.key,
      required this.fatherNo,
      required this.motherNo,
      required this.type});

  final String fatherNo;
  final String motherNo;
  final String type;

  @override
  Widget build(BuildContext context) {
    String link = 'tel:';
    if (type == 'sms') {
      link = 'sms:';
    } else if (type == 'whatsapp') {
      link = 'whatsapp://send?phone=';
    }
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onLongPress: () async {
              await Clipboard.setData(ClipboardData(text: fatherNo));
            },
            onTap: () => launchUrl(Uri.parse('$link$fatherNo')),
            title: Text('Father: $fatherNo'),
          ),
          ListTile(
            onLongPress: () async {
              await Clipboard.setData(ClipboardData(text: motherNo));
            },
            onTap: () => launchUrl(Uri.parse('$link$motherNo')),
            title: Text('Mother: $motherNo'),
          ),
        ],
      ),
    );
  }
}
