import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Staff%20Details/satff_details_event.dart';
import 'package:mid_application/Blocs/Staff%20Details/staff_details_state.dart';
import 'package:mid_application/ip_address.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/models/staff.dart';

class StaffDetailsBloc extends Bloc<SatffDetailsEvent, StaffDetailsState> {
  StaffDetailsBloc() : super(StaffDetailsInitial()) {
    on<LoadStaffDetails>(
      (event, emit) async {
        emit(StaffDetailsLoading());
        try {
          var url = Uri.parse(
              '$ipv4/v2/oneStaffDetailsMid/${Uri.encodeComponent(event.schoolCode)}/${Uri.encodeComponent(event.mob)}');
          var res = await http.get(url);
          if (res.statusCode == 200) {
            if (res.statusCode == 200) {
              Map data = jsonDecode(res.body);
              Staff staff = Staff.fromJson(data);

              emit(StaffDetailsLoaded(staff));
            } else {
              emit(StaffDetailsLoadError(res.body));
            }
          }
        } catch (e) {
          emit(StaffDetailsLoadError(e.toString()));
        }
      },
    );
  }
}
