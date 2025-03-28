import 'package:mid_application/models/student.dart';

abstract class StudentDetailsEvent {}

class LoadStudentDetails extends StudentDetailsEvent {
  final String schoolCode;
  final String admNo;

  LoadStudentDetails({required this.admNo, required this.schoolCode});
}

class UpdateStudentDetails extends StudentDetailsEvent {
  final Student student;

  UpdateStudentDetails(this.student);
}
