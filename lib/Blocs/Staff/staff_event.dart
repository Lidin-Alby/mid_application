import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/teacher.dart';

abstract class StaffEvent {}

class SaveStaffPressed extends StaffEvent {
  final Staff staff;
  final bool isMob;

  SaveStaffPressed({required this.staff, required this.isMob});
}

class LoadStaffs extends StaffEvent {
  final String schoolCode;

  LoadStaffs(this.schoolCode);
}

class UpdateStaffsList extends StaffEvent {
  final List<Staff> staffs;
  final List<Teacher> teachers;

  UpdateStaffsList(this.staffs, this.teachers);
}

class DeleteStaff extends StaffEvent {
  final String schoolCode;
  final String mob;

  DeleteStaff({required this.schoolCode, required this.mob});
}
