import 'package:mid_application/models/school_attendance.dart';

abstract class SchoolAttendanceState {}

class SchoolAttendanceInitial extends SchoolAttendanceState {}

class SchoolAttendanceLoading extends SchoolAttendanceState {}

class SchoolAttendanceLoaded extends SchoolAttendanceState {
  final SchoolAttendance schoolAttendance;

  SchoolAttendanceLoaded(this.schoolAttendance);
}

class SchoolAttendanceLoadError extends SchoolAttendanceState {
  final String error;

  SchoolAttendanceLoadError(this.error);
}
