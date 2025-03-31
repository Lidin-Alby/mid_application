import 'dart:convert';

import 'package:mid_application/models/staff.dart';

class Teacher extends Staff {
  final List? classes;
  Teacher({
    required super.schoolCode,
    required super.fullName,
    required super.mob,
    super.designation,
    super.aadhaarNo,
    super.address,
    super.bloodGroup,
    super.caste,
    super.check,
    super.department,
    super.dlNo,
    super.dlValidity,
    super.dob,
    super.fatherOrHusName,
    super.gender,
    super.joiningDate,
    super.panNo,
    super.profilePic,
    super.qualification,
    super.religion,
    super.rfid,
    super.subCaste,
    super.uan,
    super.oldMob,
    super.status,
    super.modified,
    this.classes,
  });

  factory Teacher.fromJson(json) {
    final staff = Staff.fromJson(json);

    return Teacher(
      schoolCode: staff.schoolCode,
      fullName: staff.fullName,
      mob: staff.mob,
      designation: staff.designation,
      aadhaarNo: staff.aadhaarNo,
      address: staff.address,
      bloodGroup: staff.bloodGroup,
      caste: staff.caste,
      check: staff.check,
      department: staff.department,
      dlNo: staff.dlNo,
      dlValidity: staff.dlValidity,
      dob: staff.dob,
      fatherOrHusName: staff.fatherOrHusName,
      gender: staff.gender,
      joiningDate: staff.joiningDate,
      panNo: staff.panNo,
      profilePic: staff.profilePic,
      qualification: staff.qualification,
      religion: staff.religion,
      rfid: staff.rfid,
      subCaste: staff.subCaste,
      uan: staff.uan,
      oldMob: staff.oldMob,
      status: staff.status,
      modified: staff.modified,
      classes: json['myClasses'],
    );
  }

  @override
  Map toJson() {
    final teacherJson = super.toJson();

    teacherJson['classes'] = jsonEncode(classes);
    return teacherJson;
  }
}
