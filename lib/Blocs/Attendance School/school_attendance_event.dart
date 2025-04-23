abstract class SchoolAttendanceEvent {}

class GetSchoolAttendance extends SchoolAttendanceEvent {
  final String schoolCode;
  final DateTime date;

  GetSchoolAttendance(this.schoolCode, this.date);
}
