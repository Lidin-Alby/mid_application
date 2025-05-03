import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/signup/signup_event.dart';
import 'package:mid_application/Blocs/signup/signup_state.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/ip_address.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SendSigup>(
      (event, emit) async {
        emit(SignupLoading());
        try {
          var url = Uri.parse('$ipv4/v2/signupMid');
          var res = await http.post(url, body: {
            'schoolName': event.schoolName,
            'contactNo': event.contactNo,
            'name': event.name,
            'dateTime': DateTime.now()
          });
          if (res.statusCode == 201) {
            emit(SignupRequestSuccess());
          } else {
            emit(SignupError(res.body));
          }
        } catch (e) {
          emit(SignupError(e.toString()));
        }
      },
    );
  }
}
