import 'package:mid_application/models/attendance.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<Attendance> students;

  AttendanceLoaded(this.students);
}

class AttendanceLoadError extends AttendanceState {
  final String error;

  AttendanceLoadError(this.error);
}

class SaveAttendanceLoading extends AttendanceState {}

class SaveAttendanceSuccess extends AttendanceState {}

class SaveAttendanceError extends AttendanceState {
  final String error;

  SaveAttendanceError(this.error);
}
