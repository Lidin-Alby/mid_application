import 'package:mid_application/models/school.dart';

abstract class SchoolDetailsEvent {}

class GetSchoolDetails extends SchoolDetailsEvent {
  final String schoolCode;

  GetSchoolDetails(this.schoolCode);
}

class SaveSchoolDetails extends SchoolDetailsEvent {
  final School school;

  SaveSchoolDetails(this.school);
}

class UpdateSchoolDetails extends SchoolDetailsEvent {
  final School school;

  UpdateSchoolDetails(this.school);
}
