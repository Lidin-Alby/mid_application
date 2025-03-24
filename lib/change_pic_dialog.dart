import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'ip_address.dart';

class ChangePicDialog extends StatefulWidget {
  const ChangePicDialog(
      {super.key,
      required this.admNo,
      required this.firstName,
      required this.lastName,
      required this.schoolCode,
      required this.refresh});
  final String firstName;
  final String lastName;
  final String admNo;
  final String schoolCode;
  final VoidCallback refresh;

  @override
  State<ChangePicDialog> createState() => _ChangePicDialogState();
}

class _ChangePicDialogState extends State<ChangePicDialog> {
  XFile? _imgXFile;
  // Uint8List? _bytes;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  saveStudentPic() async {
    var url = Uri.parse('$ipv4/saveStudentPicMid');

    var req = http.MultipartRequest(
      'POST',
      url,
    );
    var httpImage = http.MultipartFile.fromBytes(
      'profilePic',
      _image!.readAsBytesSync(),
      filename:
          '${widget.schoolCode}_${widget.admNo.trim()}_${widget.firstName.trim()}_${widget.lastName.trim()}${_imgXFile!.name.substring(_imgXFile!.name.lastIndexOf('.'))}',
    );
    req.files.add(httpImage);
    req.fields.addAll({'admNo': widget.admNo, 'schoolCode': widget.schoolCode});
    var res = await req.send();
    var responded = await http.Response.fromStream(res);
    if (responded.body == 'true') {
      print('uplooaddd');
      // _getProfilePic = getProfilePic();
      widget.refresh();
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            content: const Row(
              children: [
                Text(
                  'Profile Picture Updated Sucessfully',
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                )
              ],
            ),
          ),
        );
      }
    }
  }

  pickImg(ImageSource source) async {
    Navigator.of(context).pop();
    _imgXFile = await _picker.pickImage(
        source: source,
        maxHeight: 1000,
        requestFullMetadata: true,
        maxWidth: 1000);

    if (mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
    }
    saveStudentPic();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Profile Photo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                children: [
                  IconButton.outlined(
                    onPressed: () {
                      pickImg(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera_alt),
                  ),
                  Text('Camera')
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  IconButton.outlined(
                    onPressed: () async {
                      pickImg(ImageSource.gallery);
                    },
                    icon: Icon(Icons.photo_library),
                  ),
                  Text('Pick Photo')
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
