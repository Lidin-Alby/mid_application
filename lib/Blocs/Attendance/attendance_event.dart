import 'package:mid_application/models/attendance.dart';
import 'package:mid_application/models/student.dart';

abstract class AttendanceEvent {}

class LoadAttendance extends AttendanceEvent {
  final String date;
  final String schoolCode;
  final String classTitle;

  LoadAttendance(
      {required this.date, required this.schoolCode, required this.classTitle});
}

class UpdateStatus extends AttendanceEvent {
  final List<Attendance> students;

  UpdateStatus(this.students);
}

class SaveClassAttendance extends AttendanceEvent {
  final List<Attendance> students;

  SaveClassAttendance(this.students);
}

class LoadIndividualAttendance extends AttendanceEvent {
  final Student student;
  final DateTime date;

  LoadIndividualAttendance(this.student, this.date);
}

class UpdateSingleStatus extends AttendanceEvent {
  final String admNo;
  final String schoolCode;
  final String date;
  final String status;
  final Map<String, dynamic> attendance;

  UpdateSingleStatus(
      {required this.attendance,
      required this.date,
      required this.status,
      required this.admNo,
      required this.schoolCode});
}
