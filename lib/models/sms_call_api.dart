class SmsCallApi {
  final bool presentCallApi;
  final bool absentCallApi;
  final bool presentsmsApi;
  final bool absentsmsApi;
  final String presentCallAudio;
  final String absentCallAudio;
  final String smsText;
  final String schoolName;

  SmsCallApi(
      {required this.presentCallApi,
      required this.absentCallApi,
      required this.presentsmsApi,
      required this.absentsmsApi,
      required this.presentCallAudio,
      required this.absentCallAudio,
      required this.smsText,
      required this.schoolName});
  factory SmsCallApi.fromJson(json) {
    return SmsCallApi(
        presentCallApi: json['presentCallApi'] ?? false,
        absentCallApi: json['absentCallApi'] ?? false,
        presentsmsApi: json['presentsmsApi'] ?? false,
        absentsmsApi: json['absentsmsApi'] ?? false,
        presentCallAudio: json['presentCallAudio'] ?? "",
        absentCallAudio: json['absentCallAudio'] ?? "",
        smsText: json['smsText'] ?? "",
        schoolName: json['schoolName']);
  }
}
