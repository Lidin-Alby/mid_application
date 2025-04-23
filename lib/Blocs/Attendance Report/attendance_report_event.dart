abstract class AttendanceReportEvent {}

class GetAttendanceReport extends AttendanceReportEvent {
  final String schoolCode;
  final String classTitle;
  final String date;

  GetAttendanceReport(
      {required this.schoolCode, required this.classTitle, required this.date});
}
