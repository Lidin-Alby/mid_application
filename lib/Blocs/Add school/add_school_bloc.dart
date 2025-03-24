import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Add%20school/add_school_event.dart';
import 'package:mid_application/Blocs/Add%20school/add_school_state.dart';
import 'package:http/http.dart' as http;
import 'package:mid_application/Blocs/School%20List/school_bloc.dart';
import 'package:mid_application/Blocs/School%20List/school_event.dart';
import 'package:mid_application/Blocs/School%20List/school_state.dart';
import 'package:mid_application/models/school.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ip_address.dart';

class AddSchoolBloc extends Bloc<AddSchoolEvent, AddSchoolState> {
  final SchoolListBloc schoolListBloc;
  AddSchoolBloc(this.schoolListBloc) : super(AddSchoolInitial()) {
    on<AddSchoolPressed>(
      (event, emit) async {
        emit(AddSchoolLoading());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        print(token);
        try {
          var url = Uri.parse('$ipv4/v2/addNewSchoolMid');
          var res = await http.post(url, body: {
            'schoolCode': event.schoolCode,
            'principalPhone': event.principalPhone,
            'schoolName': event.schoolName,
            'schoolPassword': event.schoolPassword,
            'schoolMail': event.schoolMail,
            'token': token,
          });
          if (res.statusCode == 201) {
            final currentState = schoolListBloc.state as SchoolListLoaded;
            final updatedList = List<School>.from(currentState.schools)
              ..add(School(
                  schoolCode: event.schoolCode,
                  schoolName: event.schoolName,
                  principalPhone: event.principalPhone));
            schoolListBloc.add(SchoolListUpdated(schools: updatedList));
            emit(SchoolAdded());
          }
        } catch (e) {
          emit(SchoolAddError(e.toString()));
        }
      },
    );
  }
}
