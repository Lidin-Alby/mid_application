import 'package:mid_application/models/student.dart';

abstract class StudentDetailsState {}

class StudentDetailsInitial extends StudentDetailsState {}

class StudentDetailsLoading extends StudentDetailsState {}

class StudentDetailsLoaded extends StudentDetailsState {
  final Student student;

  StudentDetailsLoaded(this.student);
}

class StudentDetailsLoadError extends StudentDetailsState {
  final String error;

  StudentDetailsLoadError(this.error);
}
