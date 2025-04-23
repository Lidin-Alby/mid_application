import 'dart:convert';
import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

import 'ip_address.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport(
      {super.key, required this.schoolCode, required this.classTitle});
  final String schoolCode;
  final String classTitle;

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  int? selectedMonth;
  int? selectedYear;
  late List<int> years;

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  setData(int i, Map student) {
    String date = '$i-0${selectedMonth! + 1}-$selectedYear';
    if (i < 10) {
      date = '0$i-0${selectedMonth! + 1}-$selectedYear';
    }
    // print(date);
    if (student['attendance'].containsKey(date)) {
      return pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: 2),
          child: pw.Text(student['attendance'][date] == 'present' ? 'P' : 'A'));
    }
    return pw.SizedBox(width: 12);
  }

  // getTotal(Map student) {

  //   return '';
  // }

  downloadReport() async {
    
  }

  @override
  void initState() {
    DateTime today = DateTime.now();

    years = List.generate(10, (index) => (today.year + index - 2));
    // months = List.generate(12, (index) => index + 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Report'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton(
                hint: Text('Select Month'),
                items: months
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: months.indexOf(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                },
                value: selectedMonth,
              ),
              DropdownButton(
                hint: Text('Select Year'),
                items: years
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e.toString()),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  });
                },
                value: selectedYear,
              ),
            ],
          ),
          TextButton(
              onPressed: (selectedMonth != null && selectedYear != null)
                  ? downloadReport
                  : null,
              child: Text('Download'))
        ],
      ),
    );
  }
}
