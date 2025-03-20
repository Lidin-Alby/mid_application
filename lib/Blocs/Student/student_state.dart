import 'package:mid_application/models/student.dart';

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentSaveLoading extends StudentState {}

class StudentSaved extends StudentState {}

class StudentSaveError extends StudentState {
  final String? admNoError;
  final String? fatherMobError;
  final String? error;

  StudentSaveError({
    this.admNoError,
    this.fatherMobError,
    this.error,
  });
}

class StudentsLoading extends StudentState {}

class StudentsLoaded extends StudentState {
  final List<Student> students;

  StudentsLoaded(this.students);
}

class StudentLoadError extends StudentState {
  final String error;

  StudentLoadError(this.error);
}
