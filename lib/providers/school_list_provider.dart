import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mid_application/models/school.dart';
import 'package:http/http.dart' as http;
import 'package:mid_application/providers/login_provider.dart';

import '../ip_address.dart';

class SchoolListNotifier {
  Future<List<School>> fetchSchools(token) async {
    // print(token);
    try {
      var url = Uri.parse('$ipv4/getMyMidSchools');
      // final String token =
      var res = await http.get(url, headers: {'authorization': token});
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        List schools = data['schools'];
        return schools
            .map(
              (school) => School(
                schoolCode: school['schoolCode'],
                schoolName: school['schoolName'],
                principalPhone: school['principalPhone'],
              ),
            )
            .toList();
      } else {
        throw Exception("${res.statusCode}");
      }
    } catch (e) {
      throw Exception("$e");
    }

    // agentMob = data['mob'];
  }
}

final schoolListProvider = FutureProvider<List<School>>(
  (ref) async {
    final loginState = ref.watch(loginProvider);
    final schoolListNotifier = SchoolListNotifier();
    return schoolListNotifier.fetchSchools(loginState.token);
  },
);
