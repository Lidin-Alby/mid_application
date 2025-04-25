import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/Sms%20and%20call%20api/sms_call_api_bloc.dart';
import 'package:mid_application/Blocs/Sms%20and%20call%20api/sms_call_api_event.dart';
import 'package:mid_application/Blocs/Sms%20and%20call%20api/sms_call_api_state.dart';
import 'package:mid_application/models/sms_call_api.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:permission_handler/permission_handler.dart';

class AttendanceCallSmsDialog extends StatefulWidget {
  const AttendanceCallSmsDialog(
      {super.key, required this.onConfirm, required this.schoolCode});
  final String schoolCode;
  final Function(bool smsAbsent, bool smsPresent, bool callAbsent,
      bool callPresent, String smsText) onConfirm;

  @override
  State<AttendanceCallSmsDialog> createState() =>
      _AttendanceCallSmsDialogState();
}

class _AttendanceCallSmsDialogState extends State<AttendanceCallSmsDialog> {
  bool smsAbsent = false;
  bool smsPresent = false;
  bool callAbsent = false;
  bool callPresent = false;
  bool permanentDisable = false;
  bool disable = true;

  var permission = Permission.sms;

  checkPermissions() async {
    var permissionStatus = await permission.request();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        disable = false;
      });
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      setState(() {
        permanentDisable = true;
      });
    }
  }

  @override
  void initState() {
    checkPermissions();
    context.read<SmsCallApiBloc>().add(GetSmsCallApi(widget.schoolCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: BlocBuilder<SmsCallApiBloc, SmsCallApiState>(
            builder: (context, state) {
          if (state is SmsCallApiLoadError) {
            return Center(child: Text(state.error));
          }
          if (state is SmsCallApiLoaded) {
            SmsCallApi smsCallApi = state.smsCallApi;
            bool textDisable = smsCallApi.smsText.isEmpty;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SMS',
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  endIndent: 30,
                  thickness: 1,
                  height: 0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        visualDensity: VisualDensity(vertical: -3),
                        value: smsAbsent,
                        onChanged: textDisable
                            ? null
                            : (value) {
                                if (disable) {
                                  checkPermissions();
                                } else {
                                  setState(() {
                                    smsAbsent = value!;
                                  });
                                }
                              },
                      ),
                    ),
                    SizedBox(
                        width: 58,
                        child: Text(
                          'Absent',
                          style: GoogleFonts.inter(
                              color: permanentDisable || textDisable
                                  ? Colors.grey
                                  : null),
                        )),
                    Icon(
                      Icons.dangerous,
                      size: 16,
                      color: Theme.of(context).colorScheme.error,
                    )
                  ],
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        visualDensity: VisualDensity(vertical: -4),
                        value: smsPresent,
                        onChanged: textDisable
                            ? null
                            : (value) {
                                if (disable) {
                                  checkPermissions();
                                } else {
                                  setState(() {
                                    smsPresent = value!;
                                  });
                                }
                              },
                      ),
                    ),
                    SizedBox(
                      width: 58,
                      child: Text(
                        'Present',
                        style: GoogleFonts.inter(
                            color: permanentDisable || textDisable
                                ? Colors.grey
                                : null),
                      ),
                    ),
                    Icon(
                      Icons.check_box,
                      size: 16,
                      color: Colors.green,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                if (textDisable)
                  Text(
                    ' No sms Text Added. Contact admin.',
                    style: GoogleFonts.inter(
                        fontSize: 8,
                        color: Theme.of(context).colorScheme.error),
                  ),
                if (permanentDisable)
                  Text(
                    'You Permanently denied the permission, enable them in settings.',
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.error),
                  ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Call',
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  endIndent: 30,
                  thickness: 1,
                  height: 0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        visualDensity: VisualDensity(vertical: -3),
                        value: callAbsent,
                        onChanged: (smsCallApi.absentCallApi &&
                                smsCallApi.absentCallAudio.isNotEmpty)
                            ? (value) {
                                setState(() {
                                  callAbsent = value!;
                                });
                              }
                            : null,
                      ),
                    ),
                    SizedBox(
                        width: 58,
                        child: Text(
                          'Absent',
                          style: GoogleFonts.inter(
                              color: (smsCallApi.absentCallApi &&
                                      smsCallApi.absentCallAudio.isNotEmpty)
                                  ? null
                                  : Colors.grey),
                        )),
                    Icon(
                      Icons.dangerous,
                      size: 16,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    if (!smsCallApi.absentCallApi)
                      Text(
                        ' No admin Permission',
                        style: GoogleFonts.inter(
                            fontSize: 8,
                            color: Theme.of(context).colorScheme.error),
                      ),
                    if (smsCallApi.absentCallAudio.isEmpty)
                      Text(
                        ', No audio',
                        style: GoogleFonts.inter(
                            fontSize: 8,
                            color: Theme.of(context).colorScheme.error),
                      )
                  ],
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        visualDensity: VisualDensity(vertical: -4),
                        value: callPresent,
                        onChanged: (smsCallApi.presentCallApi &&
                                smsCallApi.presentCallAudio.isNotEmpty)
                            ? (value) {
                                setState(() {
                                  callPresent = value!;
                                });
                              }
                            : null,
                      ),
                    ),
                    SizedBox(
                        width: 58,
                        child: Text(
                          'Present',
                          style: GoogleFonts.inter(
                              color: (smsCallApi.presentCallApi &&
                                      smsCallApi.presentCallAudio.isNotEmpty)
                                  ? null
                                  : Colors.grey),
                        )),
                    Icon(
                      Icons.check_box,
                      size: 16,
                      color: Colors.green,
                    ),
                    if (!smsCallApi.presentCallApi)
                      Text(
                        ' No admin Permission',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    if (smsCallApi.presentCallAudio.isEmpty)
                      Text(
                        ', No audio',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyFilledButton(
                        label: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      MyFilledButton(
                        label: 'Confirm',
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onConfirm(
                              smsAbsent,
                              smsPresent,
                              callAbsent,
                              callPresent,
                              smsCallApi.smsText.replaceAll(
                                '{schoolName}',
                                smsCallApi.schoolName,
                              ));
                        },
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              )
            ]);
          }
        }),
      ),
    );
  }
}
