import 'dart:typed_data';

class School {
  String schoolCode;
  String schoolName;
  String principalPhone;
  String? schoolPhone;
  String? schoolMail;
  String? schoolWebsite;
  String? schoolAddress;
  String? schoolPincode;
  String? estCode;
  String? affNo;
  String? principalName;
  Uint8List? schoolLogo;
  Uint8List? principalSign;

  School({
    required this.schoolCode,
    required this.schoolName,
    required this.principalPhone,
  });
}
