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
      aadhaarNo: json['aadhaarNo'],
      address: json['address'],
      bloodGroup: json['bloodGroup'],
      boardingType: json['boardingType'],
      caste: json['caste'],
      dob: json['dob'],
      email: json['email'],
      fatherMobNo: json['fatherMobNo'],
      fatherName: json['fatherName'],
      fatherWhatsApp: json['fatherWhatsApp'],
      gender: json['gender'],
      motherMobNo: json['motherMobNo'],
      motherName: json['motherName'],
      motherWhatsApp: json['motherWhatsApp'],
      religion: json['religion'],
      rfid: json['rfid'],
      schoolHouse: json['schoolHouse'],
      session: json['session'],
      subCaste: json['subCaste'],
      transportMode: json['transportMode'],
      vehicleNo: json['vehicleNo'],
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
