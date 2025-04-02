import 'package:mid_application/models/form_student.dart';

abstract class FormSettingsState {}

class FormInitial extends FormSettingsState {}

class FormSettingsLoading extends FormSettingsState {}

class FormSettingsLoaded extends FormSettingsState {
  final FormStudent formStudent;

  FormSettingsLoaded(this.formStudent);
}

class FormSettingsLoadError extends FormSettingsState {
  final String error;

  FormSettingsLoadError(this.error);
}
