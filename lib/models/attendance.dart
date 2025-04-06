import 'package:intl/intl.dart';

class Attendance {
  final String schoolCode;
  final String fullName;
  final String admNo;
  final DateTime date;
  final String? fatherName;
  final String? motherName;
  final String? profilePic;
  String? status;

  Attendance(
      {this.fatherName,
      this.motherName,
      required this.profilePic,
      required this.schoolCode,
      required this.fullName,
      required this.admNo,
      required this.date,
      required this.status});

  factory Attendance.fromJson(Map json) {
    return Attendance(
      profilePic: json['profilePic'],
      fullName: json['fullName'],
      schoolCode: json['schoolCode'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      admNo: json['admNo'],
      date: json['date'] == null
          ? DateTime.now()
          : DateFormat('dd-MM-yyyy').parse(json['date']),
      status: json['status'] ?? 'absent',
    );
  }
  Map toMap() {
    return {
      // 'fullName': fullName,
      'schoolCode': schoolCode,
      'admNo': admNo,
      'date': DateFormat('dd-MM-yyyy').format(date),
      'status': status,
    };
  }
}
