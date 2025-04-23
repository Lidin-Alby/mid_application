class SchoolAttendance {
  final int totalCount;
  final int presentCount;
  final int absentCount;
  final int leaveCount;
  final int halfCount;

  SchoolAttendance({
    required this.totalCount,
    required this.presentCount,
    required this.absentCount,
    required this.leaveCount,
    required this.halfCount,
  });

  factory SchoolAttendance.fromJson(json) {
    return SchoolAttendance(
        totalCount: json['totalCount'],
        presentCount: json['presentCount'],
        absentCount: json['absentCount'],
        leaveCount: json['leaveCount'],
        halfCount: json['halfCount']);
  }
}
