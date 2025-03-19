import 'package:mid_application/models/school.dart';

abstract class SchoolListState {}

class SchoolListInitial extends SchoolListState {}

class SchoolListLoading extends SchoolListState {}

class SchoolListLoaded extends SchoolListState {
  final List<School> schools;
  SchoolListLoaded(this.schools);
}

class SchoolListError extends SchoolListState {
  final String error;
  SchoolListError(this.error);
}
