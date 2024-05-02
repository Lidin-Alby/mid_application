import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

import 'ip_address.dart';
import 'helper_widgets.dart';

class EachSchool extends StatefulWidget {
  const EachSchool(
      {super.key, required this.schoolCode, required this.listRefresh});
  final String schoolCode;
  final VoidCallback listRefresh;

  @override
  State<EachSchool> createState() => _EachSchoolState();
}

class _EachSchoolState extends State<EachSchool> {
  final _formKey = GlobalKey<FormState>();
  late Future _schoolDetails;

  TextEditingController schoolName = TextEditingController();
  TextEditingController schoolPhone = TextEditingController();
  TextEditingController schoolMail = TextEditingController();
  TextEditingController schoolWebsite = TextEditingController();
  TextEditingController schoolAddress = TextEditingController();
  TextEditingController schoolPincode = TextEditingController();
  TextEditingController estCode = TextEditingController();
  TextEditingController affNo = TextEditingController();
  TextEditingController principalName = TextEditingController();
  TextEditingController principalPhone = TextEditingController();
  bool isEdit = false;
  bool opacity = false;
  late Future _getSchoolLogo;
  late String principalSign;

  @override
  void initState() {
    _schoolDetails = getSchoolDetails();
    _getSchoolLogo = getSchoolLogo();
    super.initState();
  }

  getSchoolLogo() async {
    var url2 = Uri.parse('$ipv4/getSchoolLogoMid/${widget.schoolCode}');
    // var client = BrowserClient()..withCredentials = true;
    var response2 = await http.get(url2);

    return (response2.bodyBytes);
  }

  getSchoolDetails() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getmidSchoolDetails/${widget.schoolCode}');
    var res = await http.get(url);
    Map data = jsonDecode(res.body);

    assign(data);
    return data;
  }

  assign(Map data) {
    schoolName.text = data['schoolName'].toString();
    schoolPhone.text = data['schoolPhone'].toString();
    schoolMail.text = data['schoolMail'].toString();
    schoolWebsite.text = data['schoolWebsite'].toString();
    schoolAddress.text = data['schoolAddress'].toString();
    schoolPincode.text = data['schoolPincode'].toString();
    estCode.text = data['estCode'].toString();
    affNo.text = data['affNo'].toString();
    principalName.text = data['principalName'].toString();
    principalPhone.text = data['principalPhone'].toString();
    principalSign = data['principalSign'].toString();
  }

  saveSchoolInfo() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('$ipv4/updateSchoolDataMid');
      var res = await http.post(url, body: {
        'schoolCode': widget.schoolCode,
        'schoolName': schoolName.text.trim(),
        'schoolPhone': schoolPhone.text.trim(),
        'schoolMail': schoolMail.text.trim(),
        'schoolWebsite': schoolWebsite.text.trim(),
        'schoolAddress': schoolAddress.text.trim(),
        'schoolPincode': schoolPincode.text.trim(),
        'estCode': estCode.text.trim(),
        'affNo': affNo.text.trim(),
        'principalName': principalName.text.trim(),
        'principalPhone': principalPhone.text.trim()
      });
      if (res.body == 'true') {
        setState(() {
          isEdit = !isEdit;
        });
        widget.listRefresh();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green[600],
              behavior: SnackBarBehavior.floating,
              content: const Row(
                children: [
                  Text(
                    'Updated Sucessfully',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Code : ${widget.schoolCode}'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: InkWell(
              hoverColor: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              onHover: (value) {
                setState(() {
                  opacity = value;
                });
              },
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ProfilePicView(
                          schoolCode: widget.schoolCode,
                          type: 'logo',
                          refresh: () {
                            setState(() {
                              _getSchoolLogo = getSchoolLogo();
                            });
                            widget.listRefresh();
                          },
                        )),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: 'profile-pic',
                      child: FutureBuilder(
                        future: _getSchoolLogo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              onForegroundImageError: (exception, stackTrace) =>
                                  Text('data'),
                              child: Icon(
                                Icons.business_rounded,
                                size: 75,
                              ),
                              radius: 50,
                              foregroundImage:
                                  MemoryImage(snapshot.data as Uint8List),
                            );
                          } else {
                            return Icon(Icons.error_outline_rounded);
                          }
                        },
                      ),
                    ),
                  ),
                  if (opacity)
                    CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.black.withOpacity(.60)),
                  if (opacity)
                    Positioned(
                      top: 35,
                      left: 35,
                      child: Icon(
                        color: Colors.white,
                        Icons.open_in_full_rounded,
                        size: 30,
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    right: -15,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.white,
                          // foregroundColor: Colors.indigo,
                          // padding: EdgeInsets.all(15),
                          shape: CircleBorder()),
                      onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (context) => ChangePicDialog(
                          schoolCode: widget.schoolCode,
                          type: 'logo',
                          refresh: () {
                            setState(() {
                              _getSchoolLogo = getSchoolLogo();
                            });
                            widget.listRefresh();
                          },
                        ),
                      ),
                      child: Icon(Icons.camera_alt_rounded),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _schoolDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: Wrap(
                          runSpacing: 20,
                          children: [
                            MidTextField(
                              label: 'School Name',
                              controller: schoolName,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'School Phone',
                              controller: schoolPhone,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'School Mail Id',
                              controller: schoolMail,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'School Website',
                              controller: schoolWebsite,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'School Address',
                              controller: schoolAddress,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'School Pincode',
                              controller: schoolPincode,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'Establishment Code',
                              controller: estCode,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'Affiliation No.',
                              controller: affNo,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'Principal Name',
                              controller: principalName,
                              isEdit: isEdit,
                            ),
                            MidTextField(
                              label: 'Principal Phone',
                              controller: principalPhone,
                              isEdit: isEdit,
                            ),
                            Row(
                              children: [
                                Text('Principal Sign:'),
                                IconButton.outlined(
                                  onPressed: () => showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    context: context,
                                    builder: (context) => ChangePicDialog(
                                      schoolCode: widget.schoolCode,
                                      type: 'sign',
                                      refresh: () {
                                        imageCache.clear();
                                        setState(() {
                                          _schoolDetails = getSchoolDetails();
                                        });
                                        widget.listRefresh();
                                      },
                                    ),
                                  ),
                                  icon: Icon(Icons.add_photo_alternate_rounded),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                      Uri.parse(
                                              '$ipv4/getPic/${widget.schoolCode}/$principalSign?t=${DateTime.now().millisecondsSinceEpoch}')
                                          .toString(),
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                    if (error.toString().contains('404')) {
                                      return Center(
                                          child: Text(
                                        'No Image Found',
                                        textAlign: TextAlign.center,
                                      ));
                                    } else {
                                      return Icon(Icons.error_outline);
                                    }
                                  }),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card.outlined(
                  // elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (!isEdit)
                          Column(
                            children: [
                              IconButton.filledTonal(
                                // color: Colors.teal[600],
                                onPressed: () {
                                  setState(() {
                                    isEdit = true;
                                  });
                                },
                                icon: Icon(Icons.edit_rounded),
                              ),
                              Text(
                                'Edit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal[700],
                                ),
                              )
                            ],
                          ),
                        if (isEdit)
                          Column(
                            children: [
                              IconButton.filled(
                                // color: Colors.green[600],
                                onPressed: saveSchoolInfo,
                                icon: Icon(Icons.save_outlined),
                              ),
                              Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal[700],
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ChangePicDialog extends StatefulWidget {
  const ChangePicDialog(
      {super.key,
      required this.schoolCode,
      required this.type,
      required this.refresh});

  final String schoolCode;
  final String type;
  final VoidCallback refresh;

  @override
  State<ChangePicDialog> createState() => _ChangePicDialogState();
}

class _ChangePicDialogState extends State<ChangePicDialog> {
  XFile? _imgXFile;
  // Uint8List? _bytes;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  saveSignPic() async {
    print('object');
    var url = Uri.parse('$ipv4/saveSignPic');

    var req = http.MultipartRequest(
      'POST',
      url,
    );
    var httpImage = http.MultipartFile.fromBytes(
      'signPic',
      _image!.readAsBytesSync(),
      filename:
          '${widget.schoolCode}_principalSign${_imgXFile!.name.substring(_imgXFile!.name.lastIndexOf('.'))}',
    );
    req.files.add(httpImage);
    req.fields.addAll({'schoolCode': widget.schoolCode});
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

  saveSchoolLogo() async {
    var url = Uri.parse('$ipv4/saveSchoolLogo');

    var req = http.MultipartRequest(
      'POST',
      url,
    );
    var httpImage = http.MultipartFile.fromBytes(
      'schoolLogo',
      _image!.readAsBytesSync(),
      filename:
          '${widget.schoolCode}_schoolLogo${_imgXFile!.name.substring(_imgXFile!.name.lastIndexOf('.'))}',
    );
    req.files.add(httpImage);
    req.fields.addAll({'schoolCode': widget.schoolCode});
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
                  'Picture Updated Sucessfully',
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

    _image = await FlutterExifRotation.rotateImage(path: _imgXFile!.path);

    if (mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
    }
    if (widget.type == 'sign') {
      saveSignPic();
    } else {
      saveSchoolLogo();
    }
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

class ProfilePicView extends StatefulWidget {
  const ProfilePicView(
      {super.key,
      required this.schoolCode,
      required this.type,
      required this.refresh});

  final String schoolCode;
  final String type;
  final VoidCallback refresh;

  @override
  State<ProfilePicView> createState() => _ProfilePicViewState();
}

class _ProfilePicViewState extends State<ProfilePicView> {
  late Future _getProfilePic;
  getProfilePic() async {
    var url2 = Uri.parse('$ipv4/getSchoolLogoMid/${widget.schoolCode}');
    // var client = BrowserClient()..withCredentials = true;
    var response2 = await http.get(url2);

    return (response2.bodyBytes);
  }

  @override
  void initState() {
    _getProfilePic = getProfilePic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile Photo'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                context: context,
                builder: (context) => ChangePicDialog(
                      type: widget.type,
                      schoolCode: widget.schoolCode,
                      refresh: () {
                        setState(() {
                          _getProfilePic = getProfilePic();
                        });
                        widget.refresh();
                      },
                    )),
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: Hero(
        tag: 'profile-pic',
        child: Center(
          child: FutureBuilder(
            future: _getProfilePic,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: _getProfilePic,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.memory(
                        snapshot.data,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Text(
                          'No Profile Photo',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return Icon(Icons.error_outline_rounded);
                    }
                  },
                );
              } else {
                return Icon(Icons.error_outline_rounded);
              }
            },
          ),
        ),
      ),
    );
  }
}
