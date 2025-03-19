import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/ip_address.dart';

import 'package:http/http.dart' as http;

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<SaveStudentPressed>(
      (event, emit) async {
        emit(StudentSaveLoading());
        try {
          var url = Uri.parse('$ipv4/v2/addStudentMid');
          var res = await http.post(url, body: event.student.toJson());
          if (res.statusCode == 201) {
            emit(StudentSaved());
          } else {
            emit(StudentSaveError(res.body));
          }
        } catch (e) {
          print(e);
          emit(StudentSaveError(e.toString()));
        }
      },
    );
  }
}
