import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_event.dart';
import 'package:mid_application/Blocs/Form%20Settings/form__settings_state.dart';
import 'package:mid_application/ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:mid_application/models/form_staff.dart';
import 'package:mid_application/models/form_student.dart';

class FormSettingsBloc extends Bloc<FormSettingsEvent, FormSettingsState> {
  FormSettingsBloc() : super(FormInitial()) {
    on<LoadFormSettings>(
      (event, emit) async {
        emit(FormSettingsLoading());
        try {
          var url = Uri.parse(
              '$ipv4/v2/getFormAccessMid/${Uri.encodeComponent(event.schoolCode)}');
          var res = await http.get(url);
          if (res.statusCode == 200) {
            Map data = jsonDecode(res.body);
            // print(data);
            FormStudent formStudent = FormStudent();
            FormStaff formTeacher = FormStaff();
            FormStaff formStaff = FormStaff();

            if (data.containsKey('studentFormMid')) {
              formStudent = FormStudent.fromJson(data['studentFormMid']);
            }
            if (data.containsKey('teacherFormMid')) {
              formTeacher = FormStaff.fromJson(data['teacherFormMid']);
            }
            if (data.containsKey('staffFormMid')) {
              formStaff = FormStaff.fromJson(data['staffFormMid']);
            }

            // List classList = data['classes'];

            emit(FormSettingsLoaded(formStudent, formTeacher, formStaff));
          } else {
            emit(FormSettingsLoadError(res.body));
          }
        } catch (e) {
          emit(FormSettingsLoadError(e.toString()));
        }
      },
    );
    on<SaveFormSettings>(
      (event, emit) async {
        emit(SavingFormSettings());
        try {
          var url = Uri.parse('$ipv4/v2/addFormAccessStudentMid');
          var res = await http.post(url, body: {
            'schoolCode': event.schoolCode,
            'formStudent': jsonEncode(event.formStudent.toMap())
          });
          if (res.statusCode == 201) {
            // List classList = data['classes'];
            emit(FormSettingsSaved());

            emit(FormSettingsLoaded(
                event.formStudent, event.formTeacher, event.formStaff));
          } else {
            emit(SaveFormSettingsError(res.body));
          }
        } catch (e) {
          print(e);
          emit(SaveFormSettingsError(e.toString()));
        }
      },
    );
  }
}
