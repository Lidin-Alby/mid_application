import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Sms%20and%20call%20api/sms_call_api_event.dart';
import 'package:mid_application/Blocs/Sms%20and%20call%20api/sms_call_api_state.dart';
import 'package:mid_application/ip_address.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/models/sms_call_api.dart';

class SmsCallApiBloc extends Bloc<SmsCallApiEvent, SmsCallApiState> {
  SmsCallApiBloc() : super(SmsCallApiInitial()) {
    on<GetSmsCallApi>(
      (event, emit) async {
        emit(SmsCallApiLoading());
        try {
          var url = Uri.parse('$ipv4/v2/getApiSettings/${event.schoolCode}');

          var res = await http.get(url);
          if (res.statusCode == 200) {
            Map data = jsonDecode(res.body);
            SmsCallApi smsCallApi = SmsCallApi.fromJson(data);

            emit(SmsCallApiLoaded(smsCallApi));
          } else {
            emit(SmsCallApiLoadError(res.statusCode.toString()));
          }
        } catch (e) {
          emit(SmsCallApiLoadError(e.toString()));
        }
      },
    );
  }
}
