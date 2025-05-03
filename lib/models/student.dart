class Student {
  final String admNo;
  final String? honorificFather;
  final String? honorificMother;
  final String schoolCode;
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
  final bool? check;
  final DateTime? modified;
  final String? printStatus;

  final String? profilePic;

  Student(
      {required this.admNo,
      this.honorificFather,
      this.honorificMother,
      required this.schoolCode,
      required this.fullName,
      this.printStatus,
      this.modified,
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
      this.check,
      this.profilePic});

  factory Student.fromJson(json) {
    // print(json);
    return Student(
      honorificFather:
          json['honorificFather'] == 'null' || json['honorificFather'] == null
              ? 'Mr.'
              : json['honorificFather'],
      honorificMother:
          json['honorificMother'] == 'null' || json['honorificMother'] == null
              ? 'Mrs.'
              : json['honorificMother'],
      admNo: json['admNo'].toString(),
      schoolCode: json['schoolCode'].toString(),
      fullName: json['fullName'].toString(),
      classTitle: json['classTitle'] == "null" || json['classTitle'] == ""
          ? null
          : json['classTitle'],
      printStatus: json['printStatus'].toString(),
      gender: json['gender'] == "null" || json['gender'] == ""
          ? null
          : json['gender'],
      dob: json['dob'] == "null" ? null : json['dob'],
      bloodGroup: json['bloodGroup'] == "null" || json['bloodGroup'] == ""
          ? null
          : json['bloodGroup'],
      religion: json['religion'] == "null" ? null : json['religion'],
      caste:
          json['caste'] == "null" || json['caste'] == "" ? null : json['caste'],
      subCaste: json['subCaste'],
      email: json['email'],
      aadhaarNo: json['aadhaarNo'],
      address: json['address'],
      rfid: json['rfid'],
      transportMode:
          json['transportMode'] == "null" || json['transportMode'] == ""
              ? null
              : json['transportMode'],
      session: json['session'],
      boardingType: json['boardingType'] == "null" || json['boardingType'] == ""
          ? null
          : json['boardingType'],
      schoolHouse: json['schoolHouse'],
      vehicleNo: json['vehicleNo'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      fatherMobNo: json['fatherMobNo'],
      motherMobNo: json['motherMobNo'],
      fatherWhatsApp: json['fatherWhatsApp'].toString(),
      motherWhatsApp: json['motherWhatsApp'].toString(),
      check: json['check'],
      modified: json['modified'] == null
          ? DateTime.now()
          : DateTime.parse(json['modified']),
      profilePic: json['profilePic'].toString(),
    );
  }
  Map toJson() {
    return {
      'admNo': admNo.toString(),
      'schoolCode': schoolCode.toString(),
      'honorificFather': honorificFather.toString(),
      'honorificMother': honorificMother.toString(),
      'firstName': fullName.toString(),
      'classTitle': classTitle.toString(),
      'gender': gender.toString(),
      'dob': dob.toString(),
      'bloodGroup': bloodGroup.toString(),
      'religion': religion.toString(),
      'caste': caste.toString(),
      'subCaste': subCaste.toString(),
      'email': email.toString(),
      'aadhaarNo': aadhaarNo.toString(),
      'address': address.toString(),
      'rfid': rfid.toString(),
      'transportMode': transportMode.toString(),
      'session': session.toString(),
      'boardingType': boardingType.toString(),
      'schoolHouse': schoolHouse.toString(),
      'vehicleNo': vehicleNo.toString(),
      'fatherName': fatherName.toString(),
      'motherName': motherName.toString(),
      'fatherMobNo': fatherMobNo.toString(),
      'motherMobNo': motherMobNo.toString(),
      'fatherWhatsApp': fatherWhatsApp.toString(),
      'motherWhatsApp': motherWhatsApp.toString(),
      'profilePic': profilePic.toString(),
      'modified': DateTime.now().toString(),
      'check': (check ?? false).toString(),
      'printStatus': printStatus.toString()
    };
  }
}
