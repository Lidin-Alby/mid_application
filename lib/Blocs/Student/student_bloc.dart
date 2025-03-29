import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_bloc.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_event.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/ip_address.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/models/student.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentDetailsBloc studentDetailsBloc;
  StudentBloc(this.studentDetailsBloc) : super(StudentInitial()) {
    on<LoadStudents>(
      (event, emit) async {
        emit(StudentsLoading());
        try {
          var url = Uri.parse(
              '$ipv4/v2/getStudentsMid/${Uri.encodeComponent(event.schoolCode)}/${Uri.encodeComponent(event.classTitle)}');
          var res = await http.get(url);
          if (res.statusCode == 200) {
            List data = jsonDecode(res.body);
            List<Student> students = data
                .map(
                  (e) => Student.fromJson(e),
                )
                .toList();

            emit(StudentsLoaded(students));
          } else {
            emit(StudentSaveError(error: res.body));
          }
        } catch (e) {
          emit(StudentLoadError(e.toString()));
        }
      },
    );
    on<SaveStudentPressed>(
      (event, emit) async {
        if (event.student.admNo.isEmpty) {
          emit(StudentSaveError(admNoError: 'This field cannot be empty.'));
          return;
        }
        if (event.student.fullName.isEmpty) {
          emit(StudentSaveError(admNoError: 'This field cannot be empty.'));
          return;
        }
        if (event.student.fatherMobNo!.length != 10) {
          emit(
            StudentSaveError(fatherMobError: '10 digits Mobile No.'),
          );
          return;
        }
        if (event.student.classTitle == null) {
          emit(StudentSaveError(error: 'Please select the class'));
          return;
        }
        emit(StudentSaveLoading());
        try {
          var url = Uri.parse('$ipv4/v2/updateStudentInfoMid');
          if (event.checkAdmNo) {
            url = Uri.parse('$ipv4/v2/addStudentMid');
          }

          var res = await http.post(url, body: event.student.toJson());
          if (res.statusCode == 201) {
            if (!event.checkAdmNo) {
              print(event.student);
              studentDetailsBloc.add(UpdateStudentDetails(event.student));
              add(LoadStudents(
                  event.student.classTitle!, event.student.schoolCode));

              // List<Student> oldStudents = (state as StudentsLoaded).students;
              // final updatedStudents = oldStudents.map(
              //   (e) {
              //     if (e.admNo == event.student.admNo) {
              //       return event.student;
              //     }
              //     return e;
              //   },
              // ).toList();
              // print(updatedStudents);
              // add(UpdateStudentsList(updatedStudents));
            }
            emit(StudentSaved());
          } else {
            emit(StudentSaveError(error: res.body));
          }
        } catch (e) {
          emit(StudentSaveError(error: e.toString()));
        }
      },
    );
    on<UpdateStudentsList>(
      (event, emit) {
        emit(StudentsLoaded(event.students));
      },
    );
  }
}
