import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/Attendance%20Report/attendance_report_bloc.dart';
import 'package:mid_application/Blocs/Attendance%20Report/attendance_report_event.dart';
import 'package:mid_application/Blocs/Attendance%20Report/attendance_report_state.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DownloadAttendanceReportScreen extends StatefulWidget {
  const DownloadAttendanceReportScreen(
      {super.key, required this.schoolCode, required this.classTitle});
  final String schoolCode;
  final String classTitle;

  @override
  State<DownloadAttendanceReportScreen> createState() =>
      _DownloadAttendanceReportScreenState();
}

class _DownloadAttendanceReportScreenState
    extends State<DownloadAttendanceReportScreen> {
  List students = [];
  String? selectedMonth;
  String? selectedYear;
  List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  setData(int i, Map student) {
    String date = '$i-0${int.parse(selectedMonth!) + 1}-$selectedYear';
    if (i < 10) {
      date = '0$i-0${int.parse(selectedMonth!) + 1}-$selectedYear';
    }
    // print(date);
    if (student['attendance'].containsKey(date)) {
      return pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: 2),
          child: pw.Text(student['attendance'][date] == 'present' ? 'P' : 'A'));
    }
    return pw.SizedBox(width: 12);
  }

  generatePdf(List students) async {
    int noOfDays = DateUtils.getDaysInMonth(
        int.parse(selectedYear!), int.parse(selectedMonth!));

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a3,
          margin: pw.EdgeInsets.all(5),
          build: (context) => pw.Column(
                children: [
                  pw.Text('School Code: ${widget.schoolCode}'),
                  pw.Text('class: ${widget.classTitle}'),
                  pw.Text('Month: $selectedMonth-$selectedYear'),
                  pw.SizedBox(height: 20),
                  pw.Table(border: pw.TableBorder.all(), children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 1),
                          child: pw.Text('Name'),
                        ),
                        for (int i = 1; i <= noOfDays; i++)
                          pw.Padding(
                              padding: pw.EdgeInsets.only(left: 1),
                              child: pw.Text(i.toString())),
                        pw.Text('Total')
                      ],
                    ),
                    for (Map student in students)
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 1),
                          child: pw.Text(student['fullName']),
                        ),
                        for (int i = 1; i <= noOfDays; i++) setData(i, student),
                        pw.Center(
                            child: pw.Text(student['attendance']
                                .values
                                .where((element) =>
                                    (element != 'absent' && element != 'leave'))
                                .length
                                .toString()))
                      ])
                  ]),
                ],
              )),
    );
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");

    var a = await file.writeAsBytes(await pdf.save());
    FileSaver().saveAs(
        name:
            "${widget.schoolCode}_${widget.classTitle}_${selectedMonth}_$selectedYear",
        ext: "pdf",
        mimeType: MimeType.pdf,
        file: a);
  }

  @override
  Widget build(BuildContext context) {
    if (selectedMonth != null && selectedYear != null) {
      context.read<AttendanceReportBloc>().add(
            GetAttendanceReport(
              schoolCode: widget.schoolCode,
              classTitle: widget.classTitle,
              date: '${int.parse(selectedMonth!) + 1}-$selectedYear',
            ),
          );
    }
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report',
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              // endIndent: 30,
              thickness: 1,
              height: 0,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton(
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      iconSize: 20,
                      isExpanded: true,
                      hint: Text(
                        'Select Month',
                      ),
                      underline: Text(''),
                      items: months
                          .map(
                            (e) => DropdownMenuItem(
                              value: months.indexOf(e).toString(),
                              child: Text(
                                e,
                                style: GoogleFonts.inter(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          )
                          .toList(),
                      value: selectedMonth,
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value.toString();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton(
                      iconSize: 20,
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.w500),
                      hint: Text('Select Year'),
                      underline: Text(''),
                      isExpanded: true,
                      items: List.generate(
                        20,
                        (index) => DropdownMenuItem(
                          value: (2023 + index).toString(),
                          child: Text(
                            (2023 + index).toString(),
                            style: GoogleFonts.inter(
                                color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                      value: selectedYear,
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<AttendanceReportBloc, AttendanceReportState>(
                    builder: (context, state) {
                  if (state is AttendanceReportError) {
                    return Text(state.error);
                  }
                  if (state is AttendanceReportLoading) {
                    return SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AttendanceReportLoaded) {
                    students = state.students;
                  }
                  return Expanded(
                    child: SizedBox(
                      height: 22,
                      child: MyFilledButton(
                        label: 'Download',
                        onPressed: (selectedMonth != null &&
                                selectedYear != null &&
                                state is AttendanceReportLoaded)
                            ? () => generatePdf(students)
                            : null,
                      ),
                    ),
                  );
                }),
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
