class Staff {
  final String schoolCode;
  final String fullName;
  final String mob;
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
  final String? designation;
  final String? fatherOrHusName;
  final String? uan;
  final String? aadhaarNo;
  final String? panNo;
  final String? qualification;
  final String? profilePic;
  final String role;

  Staff(
      {required this.schoolCode,
      required this.fullName,
      required this.mob,
      required this.role,
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
      this.designation,
      this.fatherOrHusName,
      this.uan,
      this.aadhaarNo,
      this.panNo,
      this.qualification,
      this.profilePic});

  factory Staff.fromJson(json) {
    return Staff(
      schoolCode: json['schoolCode'],
      fullName: json['firstName'],
      mob: json['mob'],
      role: json['role'],
      aadhaarNo: json['aadhaarNo'],
      address: json['address'],
      bloodGroup: json['bloodGroup'],
      caste: json['caste'],
      department: json['department'],
      designation: json['designation'],
      dlNo: json['dlNo'],
      dlValidity: json['dlValidity'],
      dob: json['dob'],
      fatherOrHusName: json['fatherOrHusName'],
      gender: json['gender'],
      joiningDate: json['joiningDate'],
      panNo: json['panNo'],
      profilePic: json['profilePic'],
      qualification: json['qualification'],
      religion: json['religion'],
      rfid: json['rfid'],
      subCaste: json['subCaste'],
      uan: json['uan'],
    );
  }

  Map toJson() {
    return {
      'schoolCode': schoolCode,
      'firstName': fullName,
      'mob': mob,
      'role': role,
      'aadhaarNo': aadhaarNo,
      'address': address,
      'bloodGroup': bloodGroup,
      'caste': caste,
      'department': department,
      'designation': designation,
      'dlNo': dlNo,
      'dlValidity': dlValidity,
      'dob': dob,
      'fatherOrHusName': fatherOrHusName,
      'gender': gender,
      'joiningDate': joiningDate,
      'panNo': panNo,
      'profilePic': profilePic,
      'qualification': qualification,
      'religion': religion,
      'rfid': rfid,
      'subCaste': subCaste,
      'uan': uan,
    };
  }
}
