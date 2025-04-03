import 'package:equatable/equatable.dart';

class FormStudent extends Equatable {
  bool gender;
  bool dob;
  bool bloodGroup;
  bool religion;
  bool caste;
  bool subCaste;
  bool email;
  bool rfid;
  bool session;
  bool boardingType;
  bool schoolHouse;
  bool vehicleNo;
  bool fatherName;
  bool fatherMobNo;
  bool fatherWhatsApp;
  bool motherName;
  bool motherMobNo;
  bool motherWhatsApp;
  bool aadhaarNo;
  bool address;
  bool transportMode;

  FormStudent({
    this.gender = false,
    this.dob = false,
    this.bloodGroup = false,
    this.religion = false,
    this.caste = false,
    this.subCaste = false,
    this.email = false,
    this.rfid = false,
    this.session = false,
    this.boardingType = false,
    this.schoolHouse = false,
    this.vehicleNo = false,
    this.fatherName = false,
    this.fatherMobNo = false,
    this.fatherWhatsApp = false,
    this.motherName = false,
    this.motherMobNo = false,
    this.motherWhatsApp = false,
    this.aadhaarNo = false,
    this.address = false,
    this.transportMode = false,
  });

  factory FormStudent.fromJson(json) {
    return FormStudent(
      aadhaarNo: bool.parse(json['aadhaarNo']),
      address: bool.parse(json['address']),
      bloodGroup: bool.parse(json['bloodGroup']),
      boardingType: bool.parse(json['boardingType']),
      caste: bool.parse(json['caste']),
      dob: bool.parse(json['dob']),
      email: bool.parse(json['email']),
      fatherMobNo: bool.parse(json['fatherMobNo']),
      fatherName: bool.parse(json['fatherName']),
      fatherWhatsApp: bool.parse(json['fatherWhatsApp']),
      gender: bool.parse(json['gender']),
      motherMobNo: bool.parse(json['motherMobNo']),
      motherName: bool.parse(json['motherName']),
      motherWhatsApp: bool.parse(json['motherWhatsApp']),
      religion: bool.parse(json['religion']),
      rfid: bool.parse(json['rfid']),
      schoolHouse: bool.parse(json['schoolHouse']),
      session: bool.parse(json['session']),
      subCaste: bool.parse(json['subCaste']),
      transportMode: bool.parse(json['transportMode']),
      vehicleNo: bool.parse(json['vehicleNo']),
    );
  }
  Map toMap() {
    return {
      'aadhaarNo': aadhaarNo.toString(),
      'address': address.toString(),
      'bloodGroup': bloodGroup.toString(),
      'boardingType': boardingType.toString(),
      'caste': caste.toString(),
      'dob': dob.toString(),
      'email': email.toString(),
      'fatherMobNo': fatherMobNo.toString(),
      'fatherName': fatherName.toString(),
      'fatherWhatsApp': fatherWhatsApp.toString(),
      'gender': gender.toString(),
      'motherMobNo': motherMobNo.toString(),
      'motherName': motherName.toString(),
      'motherWhatsApp': motherWhatsApp.toString(),
      'religion': religion.toString(),
      'rfid': rfid.toString(),
      'schoolHouse': schoolHouse.toString(),
      'session': session.toString(),
      'subCaste': subCaste.toString(),
      'transportMode': transportMode.toString(),
      'vehicleNo': vehicleNo.toString(),
    };
  }

  @override
  List<Object?> get props => [
        gender,
        dob,
        bloodGroup,
        religion,
        caste,
        subCaste,
        email,
        rfid,
        session,
        boardingType,
        schoolHouse,
        vehicleNo,
        fatherName,
        fatherMobNo,
        fatherWhatsApp,
        motherName,
        motherMobNo,
        motherWhatsApp,
        aadhaarNo,
        address,
        transportMode,
      ];
}
