import 'package:mid_application/models/student.dart';

abstract class StudentEvent {}

class SaveStudentPressed extends StudentEvent {
  final Student student;

  SaveStudentPressed(this.student);
}

class LoadStudents extends StudentEvent {
  final String schoolCode;
  final String classTitle;

  LoadStudents(this.classTitle, this.schoolCode);
}
