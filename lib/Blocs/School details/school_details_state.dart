import 'package:mid_application/models/school.dart';

abstract class SchoolDetailsState {}

class SchoolDetailsInitial extends SchoolDetailsState {}

class SchoolDetailsLoading extends SchoolDetailsState {}

class SchoolDetailsError extends SchoolDetailsState {
  final String error;

  SchoolDetailsError(this.error);
}

class SchoolDetailsLoaded extends SchoolDetailsState {
  final School school;

  SchoolDetailsLoaded({required this.school});
}

class SavingSchoolDetails extends SchoolDetailsState {}

class SavedSchoolDetails extends SchoolDetailsState {}

class SchoolDetailsSaveError extends SchoolDetailsState {
  final String error;

  SchoolDetailsSaveError(this.error);
}
