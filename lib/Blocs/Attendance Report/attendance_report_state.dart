abstract class AttendanceReportState {}

class AttendanceReportInitial extends AttendanceReportState {}

class AttendanceReportLoading extends AttendanceReportState {}

class AttendanceReportLoaded extends AttendanceReportState {
  final List students;

  AttendanceReportLoaded(this.students);
}

class AttendanceReportError extends AttendanceReportState {
  final String error;

  AttendanceReportError(this.error);
}
