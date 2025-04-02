import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_event.dart';
import 'package:mid_application/Blocs/Form%20Settings/form__settings_state.dart';

class FormBloc extends Bloc<FormSettingsEvent, FormSettingsState> {
  FormBloc() : super(FormInitial()) {
    on<LoadFormSettings>(
      (event, emit) {},
    );
  }
}
