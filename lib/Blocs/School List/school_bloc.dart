import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/School%20List/school_event.dart';
import 'package:mid_application/Blocs/School%20List/school_state.dart';
import 'package:http/http.dart' as http;
import 'package:mid_application/models/school.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ip_address.dart';

class SchoolListBloc extends Bloc<SchoolListEvent, SchoolListState> {
  SchoolListBloc() : super(SchoolListInitial()) {
    on<LoadschoolList>(
      (event, emit) async {
        emit(SchoolListLoading());
        try {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          var url = Uri.parse('$ipv4/v2/getMyMidSchools');

          var res = await http.get(url, headers: {'authorization': token!});
          if (res.statusCode == 200) {
            var data = jsonDecode(res.body);
            List d = data['schools'];

            final List<School> schools = d
                .map(
                  (school) => School.fromJson(school),
                )
                .toList();
            emit(SchoolListLoaded(schools));
          } else {
            emit(SchoolListError(res.statusCode.toString()));
          }
        } catch (e) {
          emit(SchoolListError(e.toString()));
        }
      },
    );
    on<SchoolListUpdated>(
      (event, emit) {
        emit(SchoolListLoaded(event.schools));
      },
    );
  }
}
