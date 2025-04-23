import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mid_application/Blocs/Attendance%20School/school_attendance_event.dart';
import 'package:mid_application/Blocs/Attendance%20School/school_attendance_state.dart';
import 'package:mid_application/ip_address.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/models/school_attendance.dart';

class SchoolAttendanceBloc
    extends Bloc<SchoolAttendanceEvent, SchoolAttendanceState> {
  SchoolAttendanceBloc() : super(SchoolAttendanceInitial()) {
    on<GetSchoolAttendance>(
      (event, emit) async {
        emit(SchoolAttendanceLoading());
        String date = DateFormat('dd-MM-yyyy').format(event.date);
        try {
          var url = Uri.parse(
              '$ipv4/v2/schoolAttendanceMid/$date/?scCode=${Uri.encodeComponent(event.schoolCode)}');
          var res = await http.get(url);
          if (res.statusCode == 200) {
            Map data = jsonDecode(res.body);

            SchoolAttendance schoolAttendance = SchoolAttendance.fromJson(data);

            emit(SchoolAttendanceLoaded(schoolAttendance));
          } else {
            emit(SchoolAttendanceLoadError(res.body));
          }
        } catch (e) {
          emit(SchoolAttendanceLoadError(e.toString()));
        }
      },
    );
  }
}
