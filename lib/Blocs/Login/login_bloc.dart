import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Login/login_event.dart';
import 'package:mid_application/Blocs/Login/login_state.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../ip_address.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<CheckLoginStatus>(
      (event, emit) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          emit(LoggedIn());
        }
      },
    );

    on<LoginPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        var url = Uri.parse('$ipv4/loginMid');
        var response = await http.post(url, body: {
          'userName': event.userId,
          'password': event.password,
          'schoolCode': event.schoolCode,
          // 'ver': kIsWeb.toString()
        });
        if (response.statusCode == 200) {
          final Map data = jsonDecode(response.body);

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', data['token']);

          prefs.setString('user', data['user']);
          prefs.setString('schoolCode', data['schoolCode']);
          emit(LoggedIn());
        } else {
          final Map errorData = jsonDecode(response.body);
          emit(LoginFailure(error: errorData['message']));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
    on<LogoutPressed>(
      (event, emit) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        emit(LoggedOut());
      },
    );
    add(CheckLoginStatus());
  }
}
