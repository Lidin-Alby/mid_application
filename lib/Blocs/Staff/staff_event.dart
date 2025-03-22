import 'package:mid_application/models/staff.dart';

abstract class StaffEvent {}

class SaveStaffPressed extends StaffEvent {
  final Staff staff;

  SaveStaffPressed(this.staff);
}

class LoadStaffs extends StaffEvent {
  final String schoolCode;

  LoadStaffs(this.schoolCode);
}
