import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/teacher.dart';

abstract class StaffState {}

class StaffInitial extends StaffState {}

class StaffSaveLoading extends StaffState {}

class StaffSaved extends StaffState {}

class StaffSaveError extends StaffState {
  final String? mobError;
  final String? fullNameError;
  final String? designationError;
  final String? error;

  StaffSaveError(
      {this.error, this.mobError, this.fullNameError, this.designationError});
}

class StaffLoading extends StaffState {}

class StaffsLoaded extends StaffState {
  final List<Staff> staffs;
  final List<Teacher> teachers;

  StaffsLoaded(this.staffs, this.teachers);
}

class StaffLoadError extends StaffState {
  final String error;

  StaffLoadError(this.error);
}
