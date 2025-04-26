import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/School%20details/school_details_event.dart';
import 'package:mid_application/Blocs/School%20details/school_details_state.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/ip_address.dart';
import 'package:mid_application/models/school.dart';

class SchoolDetailsBloc extends Bloc<SchoolDetailsEvent, SchoolDetailsState> {
  SchoolDetailsBloc() : super(SchoolDetailsInitial()) {
    on<GetSchoolDetails>(
      (event, emit) async {
        emit(SchoolDetailsLoading());
        try {
          var url = Uri.parse(
              '$ipv4/v2/getmidSchoolDetails/${Uri.encodeComponent(event.schoolCode)}');
          var res = await http.get(url);

          Map data = jsonDecode(res.body);

          School school = School.fromJson(data);
          emit(SchoolDetailsLoaded(school: school));
        } catch (e) {
          emit(SchoolDetailsError(e.toString()));
        }
      },
    );
    on<SaveSchoolDetails>(
      (event, emit) async {
        emit(SavingSchoolDetails());
        try {
          var url = Uri.parse('$ipv4/v2/saveSchoolDataMid');
          var res = await http.post(url, body: event.school.toMap());

          if (res.statusCode == 201) {
            emit(SavedSchoolDetails());
            emit(SchoolDetailsLoaded(school: event.school));
          } else {
            emit(SchoolDetailsSaveError(res.body));
          }
        } catch (e) {
          emit(SchoolDetailsSaveError(e.toString()));
        }
      },
    );
    on<UpdateSchoolDetails>(
      (event, emit) {
        emit(SchoolDetailsLoaded(school: event.school));
      },
    );
  }
}
