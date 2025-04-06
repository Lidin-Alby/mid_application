class Staff {
  final String schoolCode;
  final String fullName;
  final String mob;
  final String? designation;
  final String? gender;
  final String? dob;
  final String? bloodGroup;
  final String? religion;
  final String? caste;
  final String? subCaste;
  final String? department;
  final String? joiningDate;
  final String? dlValidity;
  final String? dlNo;
  final String? address;
  final String? rfid;
  final String? fatherOrHusName;
  final String? uan;
  final String? aadhaarNo;
  final String? panNo;
  final String? qualification;
  final String? profilePic;
  final bool? check;
  final DateTime? modified;
  final String? printStatus;
  final String? oldMob;

  Staff({
    required this.schoolCode,
    required this.fullName,
    required this.mob,
    this.designation,
    this.oldMob,
    this.printStatus,
    this.modified,
    this.gender,
    this.dob,
    this.bloodGroup,
    this.religion,
    this.caste,
    this.subCaste,
    this.department,
    this.joiningDate,
    this.dlValidity,
    this.dlNo,
    this.address,
    this.rfid,
    this.fatherOrHusName,
    this.uan,
    this.aadhaarNo,
    this.panNo,
    this.qualification,
    this.check,
    this.profilePic,
  });

  factory Staff.fromJson(json) {
    return Staff(
      schoolCode: json['schoolCode'],
      fullName: json['fullName'].toString(),
      mob: json['mob'],
      printStatus: json['printStatus'],
      aadhaarNo: json['aadhaarNo'],
      address: json['address'],
      bloodGroup: json['bloodGroup'] == "null" ? null : json['bloodGroup'],
      caste: json['caste'] == "null" ? null : json['caste'],
      department: json['department'],
      designation: json['designation'],
      dlNo: json['dlNo'],
      dlValidity: json['dlValidity'] == "null" ? null : json['dlValidity'],
      dob: json['dob'] == "null" ? null : json['dob'],
      fatherOrHusName: json['fatherOrHusName'],
      gender: json['gender'] == "null" ? null : json['gender'],
      joiningDate: json['joiningDate'] == "null" ? null : json['joiningDate'],
      panNo: json['panNo'],
      profilePic: json['profilePic'],
      qualification: json['qualification'],
      religion: json['religion'] == "null" ? null : json['religion'],
      rfid: json['rfid'],
      subCaste: json['subCaste'],
      uan: json['uan'],
      check: json['check'],
      modified: json['modified'] == "null" || json['modified'] == null
          ? DateTime.now()
          : DateTime.parse(json['modified']),
      oldMob: json['mob'],
    );
  }

  Map toJson() {
    return {
      'schoolCode': schoolCode,
      'firstName': fullName,
      'mob': mob,
      'aadhaarNo': aadhaarNo,
      'address': address,
      'bloodGroup': bloodGroup.toString(),
      'caste': caste.toString(),
      'department': department,
      'designation': designation,
      'dlNo': dlNo.toString(),
      'dlValidity': dlValidity.toString(),
      'dob': dob.toString(),
      'fatherOrHusName': fatherOrHusName,
      'gender': gender.toString(),
      'joiningDate': joiningDate.toString(),
      'panNo': panNo,
      'profilePic': profilePic.toString(),
      'qualification': qualification,
      'religion': religion.toString(),
      'rfid': rfid,
      'subCaste': subCaste,
      'uan': uan,
      'printStatus': printStatus.toString(),
      'modified': DateTime.now().toString(),
      'oldMob': oldMob ?? mob,
      'check': check.toString()
    };
  }
}
