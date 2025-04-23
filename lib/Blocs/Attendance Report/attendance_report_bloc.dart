import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Attendance%20Report/attendance_report_event.dart';
import 'package:mid_application/Blocs/Attendance%20Report/attendance_report_state.dart';
import 'package:mid_application/ip_address.dart';
import 'package:http/http.dart' as http;

class AttendanceReportBloc
    extends Bloc<AttendanceReportEvent, AttendanceReportState> {
  AttendanceReportBloc() : super(AttendanceReportInitial()) {
    on<GetAttendanceReport>(
      (event, emit) async {
        emit(AttendanceReportLoading());
        try {
          var url = Uri.parse('$ipv4/v2/midAttendanceReport');
          var res = await http.post(url, body: {
            'schoolCode': event.schoolCode,
            'classTitle': event.classTitle,
            'date': event.date
          });
          if (res.statusCode == 201) {
            List students = jsonDecode(res.body);

            emit(AttendanceReportLoaded(students));
          } else {
            emit(AttendanceReportError(res.body));
          }
        } catch (e) {
          AttendanceReportError(e.toString());
        }
      },
    );
  }
}
