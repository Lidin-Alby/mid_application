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
  String? schoolLogo;
  String? principalSign;
  int? studentCount;
  int? teacherCount;
  int? totalStaffCount;
  int? uncheckedCount;
  int? noPhotosCount;
  int? readyPrintCount;
  int? printingCount;
  int? deliveredCount;
  int? loginPendingCount;

  School({
    required this.schoolCode,
    required this.schoolName,
    required this.principalPhone,
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
    this.studentCount,
    this.teacherCount,
    this.totalStaffCount,
    this.uncheckedCount,
    this.noPhotosCount,
    this.readyPrintCount,
    this.printingCount,
    this.deliveredCount,
    this.loginPendingCount,
  });
  factory School.fromJson(json) {
    return School(
      schoolCode: json['schoolCode'] ?? '',
      schoolName: json['schoolName'] ?? '',
      principalPhone: json['principalPhone'] ?? '',
      principalName: json['principalName'] ?? '',
      schoolPhone: json['schoolPhone'] ?? '',
      schoolMail: json['schoolMail'] ?? '',
      schoolWebsite: json['schoolWebsite'] ?? '',
      schoolAddress: json['schoolAddress'] ?? '',
      schoolPincode: json['schoolPincode'] ?? '',
      estCode: json['estCode'] ?? '',
      affNo: json['affNo'] ?? '',
      schoolLogo: json['schoolLogo'] ?? '',
      principalSign: json['principalSign'] ?? '',
      studentCount: json['studentCount'] ?? 0,
      teacherCount: json['teacherCount'] ?? 0,
      totalStaffCount: json['totalStaffCount'] ?? 0,
      uncheckedCount: json['uncheckedCount'] ?? 0,
      noPhotosCount: json['noPhotosCount'] ?? 0,
      readyPrintCount: json['readyPrintCount'] ?? 0,
      printingCount: json['printingCount'] ?? 0,
      deliveredCount: json['deliveredCount'] ?? 0,
      loginPendingCount: json['loginPendingCount'] ?? 0,
    );
  }
  Map toMap() {
    return {
      'schoolCode': schoolCode,
      'schoolName': schoolName,
      'principalPhone': principalPhone,
      'schoolPhone': schoolPhone.toString(),
      'schoolMail': schoolMail.toString(),
      'schoolWebsite': schoolWebsite.toString(),
      'schoolAddress': schoolAddress.toString(),
      'schoolPincode': schoolPincode.toString(),
      'estCode': estCode.toString(),
      'affNo': affNo.toString(),
      'principalName': principalName.toString()
    };
  }
}
