import 'dart:convert';

import 'package:mid_application/models/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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

        state = state.copyWith(token: data['token'], isLoading: false);
        prefs.setString('token', state.token!);

        prefs.setString('user', data['user']);
        prefs.setString('schoolCode', data['schoolCode']);
      } else {
        final Map errorData = jsonDecode(response.body);

        state = state.copyWith(isLoading: false, error: errorData['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      state = state.copyWith(token: token);
    }
  }

  logout() async {
    state = state.copyWith(token: null);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, Login>((ref) {
  return LoginNotifier();
});
