import 'package:mid_application/models/student.dart';

abstract class StudentEvent {}

class SaveStudentPressed extends StudentEvent {
  final bool checkAdmNo;
  final Student student;

  SaveStudentPressed({required this.student, required this.checkAdmNo});
}

class LoadStudents extends StudentEvent {
  final String schoolCode;
  final String classTitle;

  LoadStudents(this.classTitle, this.schoolCode);
}

class UpdateStudentsList extends StudentEvent {
  final List<Student> students;

  UpdateStudentsList(this.students);
}
