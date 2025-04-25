import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_application/Blocs/Bulk%20student%20upload/bulk_student_upload_bloc.dart';
import 'package:mid_application/Blocs/Bulk%20student%20upload/bulk_student_upload_event.dart';
import 'package:mid_application/Blocs/Bulk%20student%20upload/bulk_student_upload_state.dart';
import 'package:mid_application/widgets/my_filled_button.dart';

class MultipleEntryWidget extends StatefulWidget {
  const MultipleEntryWidget({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<MultipleEntryWidget> createState() => _MultipleEntryWidgetState();
}

class _MultipleEntryWidgetState extends State<MultipleEntryWidget> {
  // Uint8List? fileByte;
  PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                setState(() {
                  file = result!.files.first;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 65,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_upload_outlined),
                    Text(
                      '.CSV file',
                      style: GoogleFonts.inter(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (file != null) Text(file!.name),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              spacing: 3,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 22,
                  child: OutlinedButton(
                    onPressed: () {
                      var data = [
                        [
                          '"schoolCode"',
                          '"admNo"',
                          '"firstName"',
                          '"lastName"',
                          '"dob"',
                          '"className"',
                          '"sec"',
                          '"gender"',
                          '"profilePic"',
                          '"fatherName"',
                          '"motherName"',
                          '"fatherMobNo"',
                          '"password"',
                          '"email"',
                          '"fatherProfilePic"',
                          '"fatherWhatsApp"',
                          '"motherMobNo"',
                          '"motherProfilePic"',
                          '"motherWhatsApp"',
                          '"religion"',
                          '"caste"',
                          '"boardingType"',
                          '"schoolHouse"',
                          '"subCaste"',
                          '"address"',
                          '"transportMode"',
                          '"vehicleNo"',
                          '"session"',
                          '"rfid"',
                          "\n"
                        ],
                        [
                          '"your school code"',
                          '"any"',
                          '"any"',
                          '"any"',
                          '"dd-mm-yyyy"',
                          '"any"',
                          '"any"',
                          '"Male/Female"',
                          '"pic name with extension"',
                          '"any"',
                          '"any"',
                          '"any"',
                          '"any"',
                          '"any"',
                          '"pic name with extension"',
                          '"any"',
                          '"any"',
                          '"pic name with extension"',
                          '"any"',
                          '"Christian/Hindu"',
                          '"General/OBC"',
                          '"Day Scholar/Hostel"',
                          '"any"',
                          '"any"',
                          '"any"',
                          '"Pedistrian/Parent"',
                          '"any"',
                          '"any"',
                          '"any"',
                        ]
                      ];
                      final List<int> codeUnitList = [];
                      for (var innerList in data) {
                        codeUnitList.addAll(
                            innerList.expand((str) => str.codeUnits).toList());
                      }
                      final fileBytes = Uint8List.fromList(codeUnitList);
                      FileSaver.instance.saveAs(
                        name: 'Sample',
                        bytes: fileBytes,
                        ext: 'csv',
                        mimeType: MimeType.csv,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      textStyle: GoogleFonts.inter(fontSize: 12),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Text('Sample'),
                  ),
                ),
                Text(
                  'ⓘ- Sample csv for uploading',
                  style: GoogleFonts.inter(fontSize: 8),
                ),
                SizedBox(),
                SizedBox(
                  height: 22,
                  child: Row(
                    children: [
                      BlocConsumer<BulkStudentUploadBloc,
                          BulkStudentUploadState>(
                        listener: (context, state) {},
                        builder: (context, state) =>
                            state is BulkUploadingStudents
                                ? SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Expanded(
                                    child: MyFilledButton(
                                      label: 'Upload',
                                      onPressed: file != null
                                          ? () {
                                              context
                                                  .read<BulkStudentUploadBloc>()
                                                  .add(
                                                    BulkUploadStudents(
                                                      widget.schoolCode,
                                                      file!.bytes!,
                                                    ),
                                                  );
                                            }
                                          : null,
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
