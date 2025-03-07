import 'dart:typed_data';

class School {
  String schoolCode;
  String? schoolName;
  String? principalPhone;
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
    this.schoolName,
    this.principalPhone,
    this.schoolPhone,
    this.schoolMail,
    this.schoolWebsite,
    this.schoolAddress,
    this.schoolPincode,
    this.estCode,
    this.affNo,
    this.principalName,
    this.schoolLogo,
    this.principalSign,
  });
  factory School.fromJson(json) {
    return School(
      schoolCode: json['schoolCode'] ?? '',
      schoolName: json['schoolName'] ?? '',
      principalPhone: json['principalPhone'] ?? '',
      schoolPhone: json['schoolPhone'] ?? '',
      schoolMail: json['schoolPhone'] ?? '',
      schoolWebsite: json['schoolWebsite'] ?? '',
      schoolAddress: json['schoolAddress'] ?? '',
      schoolPincode: json['schoolPincode'] ?? '',
      estCode: json['estCode'] ?? '',
      affNo: json['principalName'] ?? '',
      schoolLogo: json['schoolLogo'] ?? '',
      principalSign: json['principalSign'] ?? '',
    );
  }
}
