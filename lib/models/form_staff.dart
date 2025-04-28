import 'package:equatable/equatable.dart';

class FormStaff extends Equatable {
  bool joiningDate;
  bool department;
  bool designation;
  bool rfid;
  bool gender;
  bool dob;
  bool bloodGroup;
  bool email;
  bool fatherOrHusName;
  bool qualification;
  bool religion;
  bool caste;
  bool subCaste;
  bool aadhaarNo;
  bool panNo;
  bool uan;
  bool dlNo;
  bool dlValidity;
  bool address;

  FormStaff({
    this.joiningDate = false,
    this.department = false,
    this.designation = false,
    this.rfid = false,
    this.gender = false,
    this.dob = false,
    this.bloodGroup = false,
    this.email = false,
    // this.mob = false,
    this.fatherOrHusName = false,
    this.qualification = false,
    this.religion = false,
    this.caste = false,
    this.subCaste = false,
    this.aadhaarNo = false,
    this.panNo = false,
    this.uan = false,
    this.dlNo = false,
    this.dlValidity = false,
    this.address = false,
  });

  factory FormStaff.fromJson(json) {
    return FormStaff(
      joiningDate: bool.parse(json['joiningDate']),
      department: bool.parse(json['department']),
      designation: bool.parse(json['designation']),
      rfid: bool.parse(json['rfid']),
      gender: bool.parse(json['gender']),
      dob: bool.parse(json['dob']),
      bloodGroup: bool.parse(json['bloodGroup'] ?? false.toString()),
      email: bool.parse(json['email']),
      //  mob:bool.parse(json[ob]),
      fatherOrHusName: bool.parse(json['fatherOrHusName'] ?? false.toString()),
      qualification: bool.parse(json['qualification']),
      religion: bool.parse(json['religion']),
      caste: bool.parse(json['caste']),
      subCaste: bool.parse(json['subCaste']),
      aadhaarNo: bool.parse(json['aadhaarNo'] ?? false.toString()),
      panNo: bool.parse(json['panNo'] ?? false.toString()),
      uan: bool.parse(json['uan']),
      dlNo: bool.parse(json['dlNo']),
      dlValidity: bool.parse(json['dlValidity']),
      address: bool.parse(json['address']),
    );
  }
  Map tomap() {
    return {
      'joiningDate': joiningDate.toString(),
      'department': department.toString(),
      'designation': designation.toString(),
      'rfid': rfid.toString(),
      'gender': gender.toString(),
      'dob': dob.toString(),
      'bloodGroup': bloodGroup.toString(),
      'email': email.toString(),
      'fatherOrHusName': fatherOrHusName.toString(),
      'qualification': qualification.toString(),
      'religion': religion.toString(),
      'caste': caste.toString(),
      'subCaste': subCaste.toString(),
      'aadhaarNo': aadhaarNo.toString(),
      'panNo': panNo.toString(),
      'uan': uan.toString(),
      'dlNo': dlNo.toString(),
      'dlValidity': dlValidity.toString(),
      'address': address.toString(),
    };
  }

  @override
  List<Object?> get props => [
        joiningDate,
        department,
        designation,
        rfid,
        gender,
        dob,
        bloodGroup,
        email,
        fatherOrHusName,
        qualification,
        religion,
        caste,
        subCaste,
        aadhaarNo,
        panNo,
        uan,
        dlNo,
        dlValidity,
        address,
      ];
}
