abstract class SatffDetailsEvent {}

class LoadStaffDetails extends SatffDetailsEvent {
  final String schoolCode;
  final String mob;

  LoadStaffDetails({required this.schoolCode, required this.mob});
}
