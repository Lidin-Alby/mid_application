import 'package:mid_application/models/sms_call_api.dart';

abstract class SmsCallApiState {}

class SmsCallApiInitial extends SmsCallApiState {}

class SmsCallApiLoading extends SmsCallApiState {}

class SmsCallApiLoaded extends SmsCallApiState {
  final SmsCallApi smsCallApi;

  SmsCallApiLoaded(this.smsCallApi);
}

class SmsCallApiLoadError extends SmsCallApiState {
  final String error;

  SmsCallApiLoadError(this.error);
}
