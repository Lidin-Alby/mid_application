class AddSchool {
  String schoolCode;
  String principalPhone;
  String schoolName;
  String schoolPassword;
  String agentMob;
  String? schoolMail;

  AddSchool({
    required this.schoolCode,
    required this.principalPhone,
    required this.schoolPassword,
    required this.schoolName,
    required this.agentMob,
    this.schoolMail,
  });
}
