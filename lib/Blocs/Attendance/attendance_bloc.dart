import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Attendance/attendance_event.dart';
import 'package:mid_application/Blocs/Attendance/attendance_state.dart';
import 'package:http/http.dart ' as http;
import 'package:mid_application/ip_address.dart';
import 'package:mid_application/models/attendance.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    on<LoadAttendance>(
      (event, emit) async {
        emit(AttendanceLoading());
        try {
          var url = Uri.parse(
              '$ipv4/v2/getAttendanceClassMid/${event.date}/?scCode=${Uri.encodeQueryComponent(event.schoolCode)}&classTitle=${Uri.encodeQueryComponent(event.classTitle)}');
          var res = await http.get(url);
          if (res.statusCode == 200) {
            List data = jsonDecode(res.body);

            List<Attendance> students =
                data.map((e) => Attendance.fromJson(e)).toList();

            emit(AttendanceLoaded(students));
          } else {
            emit(AttendanceLoadError(res.body));
          }
        } catch (e) {
          AttendanceLoadError(e.toString());
        }
      },
    );
    on<UpdateStatus>(
      (event, emit) {
        // Map updateMap = event.updateStudent.toMap();
        // updateMap['status'] = 'present';
        // print(updateMap);
        // Attendance update = Attendance.fromJson(updateMap);
        // List<Attendance> updatedStudents = event.students.map(
        //   (e) {
        //     if (e.admNo == event.updateStudent.admNo) {
        //       return update;
        //     }
        //     return e;
        //   },
        // ).toList();
        // print(updatedStudents[0].status);
        emit(AttendanceLoaded(event.students));
      },
    );

    on<SaveClassAttendance>(
      (event, emit) async {
        emit(SaveAttendanceLoading());
        try {
          List students = event.students
              .map(
                (e) => e.toMap(),
              )
              .toList();
          var url = Uri.parse('$ipv4/v2/saveClassAttendanceMid');
          var res =
              await http.post(url, body: {'students': jsonEncode(students)});
          if (res.statusCode == 201) {
            // List classList = data['classes'];
            emit(SaveAttendanceSuccess());
          } else {
            emit(SaveAttendanceError(res.body));
          }
        } catch (e) {
          emit(SaveAttendanceError(e.toString()));
        }
      },
    );
    on<LoadIndividualAttendance>(
      (event, emit) async {
        emit(AttendanceLoading());
        print(event.student.schoolCode);
        print(event.student.admNo);
        try {
          var url = Uri.parse(
              '$ipv4/v2/getMyAttendanceMid/${Uri.encodeQueryComponent(event.student.schoolCode)}/${Uri.encodeQueryComponent(event.student.admNo)}/04-2025');
          var res = await http.get(url);
          if (res.statusCode == 200) {
            Map data = jsonDecode(res.body);
            print(data);

            // List<Attendance> students =
            //     data.map((e) => Attendance.fromJson(e)).toList();

            emit(IndividualAttendanceLoaded(data['attendance']));
          } else {
            emit(AttendanceLoadError(res.body));
          }
        } catch (e) {
          AttendanceLoadError(e.toString());
        }
      },
    );
  }
}
