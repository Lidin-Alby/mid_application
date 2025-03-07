import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mid_application/models/school.dart';
import 'package:http/http.dart' as http;

import '../ip_address.dart';

final schoolDetailsProvider = FutureProvider.family<School, String>(
  (ref, schoolCode) async {
    var url = Uri.parse('$ipv4/getmidSchoolDetails/$schoolCode}');

    var res = await http.get(url);
    if (res.statusCode == 200) {
      Map jsonData = jsonDecode(res.body);
      return School.fromJson(jsonData);
    } else {
      throw Exception('Failed to Load data');
    }
  },
);
