abstract class AddSchoolState {}

class AddSchoolInitial extends AddSchoolState {}

class AddSchoolLoading extends AddSchoolState {}

class SchoolAdded extends AddSchoolState {}

class SchoolAddError extends AddSchoolState {
  final String error;
  SchoolAddError(this.error);
}
