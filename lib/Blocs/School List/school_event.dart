import 'package:mid_application/models/school.dart';

abstract class SchoolListEvent {}

class LoadschoolList extends SchoolListEvent {}

class SchoolListUpdated extends SchoolListEvent {
  final List<School> schools;

  SchoolListUpdated({required this.schools});
}
