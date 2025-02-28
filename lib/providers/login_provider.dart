import 'dart:convert';

import 'package:mid_application/models/login.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

import '../ip_address.dart';

class LoginNotifier extends StateNotifier<Login> {
  LoginNotifier() : super(Login());

  void updateUserId(String userId) {
    state = state.copyWith(userId: userId);
  }

  void updateSchoolCode(String schoolCode) {
    state = state.copyWith(schoolCode: schoolCode);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  Future login() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      var url = Uri.parse('$ipv4/loginMid');
      var response = await http.post(url, body: {
        'userName': state.userId,
        'password': state.password,
        'schoolCode': state.schoolCode,
        // 'ver': kIsWeb.toString()
      });
      if (response.statusCode == 200) {
        final Map data = jsonDecode(response.body);
        print(data);
        print("logged");
      } else {
        final Map errorData = jsonDecode(response.body);
        print(errorData);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, Login>((ref) {
  return LoginNotifier();
});
