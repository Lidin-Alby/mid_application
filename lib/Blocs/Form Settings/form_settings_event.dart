import 'package:mid_application/models/form_staff.dart';
import 'package:mid_application/models/form_student.dart';

abstract class FormSettingsEvent {}

class LoadFormSettings extends FormSettingsEvent {
  final String schoolCode;

  LoadFormSettings(this.schoolCode);
}

class SaveFormSettings extends FormSettingsEvent {
  final String schoolCode;
  final FormStudent formStudent;
  final FormStaff formTeacher;
  final FormStaff formStaff;

  SaveFormSettings(
      {required this.formTeacher,
      required this.formStaff,
      required this.schoolCode,
      required this.formStudent});
}
