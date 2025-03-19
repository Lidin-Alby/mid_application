abstract class SchoolDetailsEvent {}

class GetSchoolDetails extends SchoolDetailsEvent {
  final String schoolCode;

  GetSchoolDetails(this.schoolCode);
}
