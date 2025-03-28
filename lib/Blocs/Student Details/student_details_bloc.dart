import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_event.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_state.dart';
import 'package:mid_application/ip_address.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/models/student.dart';

class StudentDetailsBloc
    extends Bloc<StudentDetailsEvent, StudentDetailsState> {
  StudentDetailsBloc() : super(StudentDetailsInitial()) {
    on<LoadStudentDetails>(
      (event, emit) async {
        emit(StudentDetailsLoading());

        var url = Uri.parse(
            '$ipv4/v2/oneStudentDetailsMid/${Uri.encodeComponent(event.schoolCode)}/${Uri.encodeComponent(event.admNo)}');
        var res = await http.get(url);
        if (res.statusCode == 200) {
          Map data = jsonDecode(res.body);
          Student student = Student.fromJson(data);

          emit(StudentDetailsLoaded(student));
        } else {
          emit(StudentDetailsLoadError(res.body));
        }
      },
    );
    on<UpdateStudentDetails>(
      (event, emit) {
        emit(StudentDetailsLoaded(event.student));
      },
    );
  }
}
