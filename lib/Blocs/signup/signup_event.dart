abstract class SignupEvent {}

class SendSigup extends SignupEvent {
  final String schoolName;
  final String contactNo;
  final String name;

  SendSigup(
      {required this.schoolName, required this.contactNo, required this.name});
}
