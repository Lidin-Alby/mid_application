import 'package:mid_application/models/school.dart';

abstract class SchoolState {}

class SchoolInitial extends SchoolState {}

class SchoolLoading extends SchoolState {}

class SchoolLoaded extends SchoolState {
  final List<School> schools;
  SchoolLoaded(this.schools);
}

class SchoolError extends SchoolState {
  final String error;
  SchoolError(this.error);
}
