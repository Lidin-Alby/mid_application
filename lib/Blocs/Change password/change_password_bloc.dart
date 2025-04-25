import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Change%20password/change_password_event.dart';
import 'package:mid_application/Blocs/Change%20password/change_password_state.dart';
import 'package:mid_application/ip_address.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePassword>(
      (event, emit) async {
        emit(ChangePasswordSaving());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userName = prefs.getString('userName');
        String? schoolCode = prefs.getString('schoolCode');

        print(userName);

        try {
          var url = Uri.parse('$ipv4/v2/changePassword');
          var res = await http.post(url, body: {
            'currentPassword': event.currentPassword,
            'newPassword': event.newPassword,
            'schoolCode': schoolCode,
            'userName': userName
          });
          if (res.statusCode == 201) {
            emit(ChangePasswordSuccess());
          } else {
            emit(ChangePasswordSaveError(res.body));
          }
        } catch (e) {
          ChangePasswordSaveError(e.toString());
        }
      },
    );
  }
}
