import 'package:mid_application/models/attendance.dart';

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
