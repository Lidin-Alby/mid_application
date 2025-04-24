import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:mid_application/widgets/my_filled_button.dart';

class MultipleEntryWidget extends StatelessWidget {
  const MultipleEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
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
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
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
                      textStyle: TextStyle(fontSize: 12),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Text('Sample'),
                  ),
                ),
                Text(
                  'ⓘ- Sample csv for uploading',
                  style: TextStyle(fontSize: 8),
                ),
                SizedBox(),
                SizedBox(
                  height: 22,
                  child: Row(
                    children: [
                      Expanded(
                        child: MyFilledButton(
                          label: 'Upload',
                          onPressed: () {},
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
