import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Staff%20Details/staff_details_event.dart';
import 'package:mid_application/Blocs/Staff%20Details/staff_details_bloc.dart';
import 'package:mid_application/Blocs/Staff/staff_event.dart';
import 'package:mid_application/Blocs/Staff/staff_state.dart';
import 'package:mid_application/ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/teacher.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffDetailsBloc staffDetailsBloc;
  StaffBloc(this.staffDetailsBloc) : super(StaffInitial()) {
    on<LoadStaffs>(
      (event, emit) async {
        emit(StaffLoading());
        try {
          var url = Uri.parse(
              '$ipv4/v2/getMidTeachers/${Uri.encodeComponent(event.schoolCode)}/other');
          var res = await http.get(url);
          if (res.statusCode == 200) {
            Map data = jsonDecode(res.body);

            List st = data['staffs'];
            List te = data['teachers'];

            List<Staff> staffs = st
                .map(
                  (e) => Staff.fromJson(e),
                )
                .toList();

            List<Teacher> teachers = te
                .map(
                  (e) => Teacher.fromJson(e),
                )
                .toList();

            emit(StaffsLoaded(staffs, teachers));
          } else {
            emit(StaffLoadError(res.body));
          }
        } catch (e) {
          StaffLoadError(e.toString());
        }
      },
    );
    on<SaveStaffPressed>(
      (event, emit) async {
        if (event.staff.fullName.isEmpty) {
          emit(StaffSaveError(fullNameError: 'This field cannot be empty.'));
          return;
        }
        if (event.staff.mob.length != 10) {
          emit(
            StaffSaveError(mobError: '10 digits Mobile No.'),
          );
          return;
        }

        if (event.staff.designation!.isEmpty) {
          emit(
            StaffSaveError(designationError: 'This field cannot be empty.'),
          );
          return;
        }
        emit(StaffSaveLoading());
        try {
          var url = Uri.parse('$ipv4/v2/addStaffMid');
          if (event.isMob) {
            url = Uri.parse('$ipv4/v2/updateStaffInfoMid');
          }
          var res = await http.post(url, body: event.staff.toJson());
          print(event.staff.check);
          if (res.statusCode == 201) {
            if (event.isMob) {
              staffDetailsBloc.add(UpdateStaffDetails(event.staff));
              add(LoadStaffs(event.staff.schoolCode));
            }
            emit(StaffSaved());
          } else {
            emit(StaffSaveError(error: res.body));
          }
        } catch (e) {
          print(e);
          emit(StaffSaveError(error: e.toString()));
        }
      },
    );
    on<UpdateStaffsList>(
      (event, emit) {
        emit(StaffsLoaded(event.staffs, event.teachers));
      },
    );
  }
}
