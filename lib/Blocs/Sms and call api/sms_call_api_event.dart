abstract class SmsCallApiEvent {}

class GetSmsCallApi extends SmsCallApiEvent {
  final String schoolCode;

  GetSmsCallApi(this.schoolCode);
}
