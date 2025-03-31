import 'package:mid_application/models/staff.dart';

abstract class StaffDetailsState {}

class StaffDetailsInitial extends StaffDetailsState {}

class StaffDetailsLoading extends StaffDetailsState {}

class StaffDetailsLoaded extends StaffDetailsState {
  final Staff staff;

  StaffDetailsLoaded(this.staff);
}

class StaffDetailsLoadError extends StaffDetailsState {
  final String error;

  StaffDetailsLoadError(this.error);
}
