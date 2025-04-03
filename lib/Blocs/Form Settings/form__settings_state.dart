import 'package:mid_application/models/form_staff.dart';
import 'package:mid_application/models/form_student.dart';

abstract class FormSettingsState {}

class FormInitial extends FormSettingsState {}

class FormSettingsLoading extends FormSettingsState {}

class FormSettingsLoaded extends FormSettingsState {
  final FormStudent formStudent;
  final FormStaff formTeacher;
  final FormStaff formStaff;

  FormSettingsLoaded(
    this.formStudent,
    this.formTeacher,
    this.formStaff,
  );
}

class FormSettingsLoadError extends FormSettingsState {
  final String error;

  FormSettingsLoadError(this.error);
}

class SavingFormSettings extends FormSettingsState {}

class FormSettingsSaved extends FormSettingsState {}

class SaveFormSettingsError extends FormSettingsState {
  final String error;

  SaveFormSettingsError(this.error);
}
