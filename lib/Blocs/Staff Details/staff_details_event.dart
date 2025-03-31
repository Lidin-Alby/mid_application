import 'package:mid_application/models/staff.dart';

abstract class StaffDetailsEvent {}

class LoadStaffDetails extends StaffDetailsEvent {
  final String schoolCode;
  final String mob;

  LoadStaffDetails({required this.schoolCode, required this.mob});
}

class UpdateStaffDetails extends StaffDetailsEvent {
  final Staff staff;

  UpdateStaffDetails(this.staff);
}
