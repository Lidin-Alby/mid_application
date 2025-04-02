import 'package:mid_application/models/form_student.dart';

abstract class FormSettingsEvent {}

class LoadFormSettings extends FormSettingsEvent {
  final String schoolCode;

  LoadFormSettings(this.schoolCode);
}

class SaveFormSettings extends FormSettingsEvent {
  final FormStudent formStudent;

  SaveFormSettings({required this.formStudent});
}
