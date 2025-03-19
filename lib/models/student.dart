class Student {
  final String admNo;
  final String fullName;
  final String? classTitle;
  final String? gender;
  final String? dob;
  final String? bloodGroup;
  final String? religion;
  final String? caste;
  final String? subCaste;
  final String? email;
  final String? aadhaarNo;
  final String? address;
  final String? rfid;
  final String? transportMode;
  final String? session;
  final String? boardingType;
  final String? schoolHouse;
  final String? vehicleNo;
  final String? fatherName;
  final String? motherName;
  final String? fatherMobNo;
  final String? motherMobNo;
  final String? fatherWhatsApp;
  final String? motherWhatsApp;

  final String? profilePic;

  Student(
      {required this.admNo,
      required this.fullName,
      this.classTitle,
      this.gender,
      this.dob,
      this.bloodGroup,
      this.religion,
      this.caste,
      this.subCaste,
      this.email,
      this.aadhaarNo,
      this.address,
      this.rfid,
      this.transportMode,
      this.session,
      this.boardingType,
      this.schoolHouse,
      this.vehicleNo,
      this.fatherName,
      this.motherName,
      this.fatherMobNo,
      this.motherMobNo,
      this.fatherWhatsApp,
      this.motherWhatsApp,
      this.profilePic});

  factory Student.fromJson(json) {
    return Student(
      admNo: json['admNo'],
      fullName: json['firstName'],
      classTitle: json['classTitle'],
      gender: json['gender'],
      dob: json['dob'],
      bloodGroup: json['bloodGroup'],
      religion: json['religion'],
      caste: json['caste'],
      subCaste: json['subCaste'],
      email: json['email'],
      aadhaarNo: json['aadhaarNo'],
      address: json['address'],
      rfid: json['rfid'],
      transportMode: json['transportMode'],
      session: json['session'],
      boardingType: json['boardingType'],
      schoolHouse: json['schoolHouse'],
      vehicleNo: json['vehicleNo'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      fatherMobNo: json['fatherMobNo'],
      motherMobNo: json['motherMobNo'],
      fatherWhatsApp: json['fatherWhatsApp'],
      motherWhatsApp: json['motherWhatsApp'],
      profilePic: json['profilePic'],
    );
  }
  Map toJson() {
    return {
      'admNo': admNo,
      'firstName': fullName,
      'classTitle': classTitle,
      'gender': gender,
      'dob': dob,
      'bloodGroup': bloodGroup,
      'religion': religion,
      'caste': caste,
      'subCaste': subCaste,
      'email': email,
      'aadhaarNo': aadhaarNo,
      'address': address,
      'rfid': rfid,
      'transportMode': transportMode,
      'session': session,
      'boardingType': boardingType,
      'schoolHouse': schoolHouse,
      'vehicleNo': vehicleNo,
      'fatherName': fatherName,
      'motherName': motherName,
      'fatherMobNo': fatherMobNo,
      'motherMobNo': motherMobNo,
      'fatherWhatsApp': fatherWhatsApp,
      'motherWhatsApp': motherWhatsApp,
      'profilePic': profilePic,
    };
  }
}
