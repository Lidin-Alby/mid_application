abstract class AddSchoolEvent {}

class AddSchoolPressed extends AddSchoolEvent {
  String schoolCode;
  String principalPhone;
  String schoolName;
  String schoolPassword;

  String? schoolMail;

  AddSchoolPressed(
      {required this.schoolCode,
      required this.principalPhone,
      required this.schoolName,
      required this.schoolPassword,
      this.schoolMail});
}
