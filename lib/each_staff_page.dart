import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

import 'helper_widgets.dart';
import 'ip_address.dart';

class EachStaffPage extends StatefulWidget {
  const EachStaffPage(
      {super.key,
      required this.schoolCode,
      required this.mob,
      required this.isTeacher,
      required this.listRefresh});
  final String schoolCode;
  final String mob;
  final bool isTeacher;
  final VoidCallback listRefresh;

  @override
  State<EachStaffPage> createState() => _EachStaffPageState();
}

class _EachStaffPageState extends State<EachStaffPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController subCaste = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController fatherOrHusName = TextEditingController();
  TextEditingController aadhaarNo = TextEditingController();
  TextEditingController panNo = TextEditingController();
  TextEditingController dlNo = TextEditingController();
  TextEditingController rfid = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController designation = TextEditingController();
  String? joiningDate;
  String? gender;
  String? dob;
  String? bloodGroup;
  String? religion;
  String? caste;
  String? dlValidity;
  List myClasses = [];
  List classes = [];
  late String oldMob;
  bool showClasses = false;

  late Future _getProfilePic;
  List religionDropdownList = [
    'Hindu',
    'Islam',
    'Christian',
    'Sikh',
    'Budh',
    'Jain',
    'Parsi',
    'Yahudi',
    'Other'
  ];

  bool isEdit = false;
  bool getAll = false;
  bool opacity = false;
  Map form = {};

  getFormAccessStaff() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getFormAccessStaffMid/${widget.schoolCode}');
    var res = await http.get(url);

    Map data = jsonDecode(res.body);
    // Map form = data['studentForm'];
    print(data);
    form = data['staffFormMid'];

    setState(() {
      getAll = true;
    });
  }

  getFormAccessTeacher() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getFormAccessTeacherMid/${widget.schoolCode}');
    var res = await http.get(url);

    print('done');
    print(res.body);
    Map data = jsonDecode(res.body);
    form = data['teacherFormMid'];
    setState(() {
      getAll = true;
    });
  }

  getOneStaff() async {
    getClass();

    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getOneStaff/${widget.schoolCode}/${widget.mob}');
    var res = await http.get(url);

    Map data = jsonDecode(res.body);
    print(res.body);

    firstName.text = data['firstName'];
    lastName.text = data['lastName'].toString();
    mob.text = data['mob'].toString();
    joiningDate = data['joiningDate'];
    oldMob = data['mob'].toString();
    designation.text = data['designation'].toString();
    subCaste.text = data['subCaste'].toString();
    email.text = data['email'].toString();
    rfid.text = data['rfid'].toString();
    address.text = data['address'].toString();
    fatherOrHusName.text = data['fatherOrHusName'].toString();
    religion = data['religion'] == '' ? null : data['religion'];
    caste = data['caste'] == '' ? null : data['caste'];
    gender = data['gender'] == '' ? null : data['gender'];
    dob = data['dob'];
    bloodGroup = data['bloodGroup'] == '' ? null : data['bloodGroup'];
    qualification.text = data['qualification'].toString();
    // panNo.text = data['panNo'];
    dlValidity = data['dlValidity'].toString();
    myClasses = data['myClasses'];
    // myclasses = data['myclasses'];

    // aadhaarNo.text = data['aadhaarNo'];

    if (widget.isTeacher) {
      getFormAccessTeacher();
      showClasses = true;
    } else {
      getFormAccessStaff();
    }
  }

  getClass() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getMidClasses/${widget.schoolCode}');
    var res = await http.get(url);
    Map data = jsonDecode(res.body);

    classes = data['classes'].map((e) => e['title']).toList();
  }

  getProfilePic() async {
    var url2 =
        Uri.parse('$ipv4/getStaffPicMid/${widget.schoolCode}/${widget.mob}');
    // var client = BrowserClient()..withCredentials = true;
    var response2 = await http.get(url2);

    return (response2.bodyBytes);
  }

  saveStaffInfo() async {
    if (_formKey.currentState!.validate()) {
      // var client = BrowserClient()..withCredentials = true;
      var url = Uri.parse('$ipv4/updateStaffInfoMid');
      var res = await http.post(url, body: {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
        'mob': mob.text.trim(),
        'joiningDate': joiningDate ?? '',
        'designation': designation.text.trim(),
        'subCaste': subCaste.text.trim(),
        'email': email.text.trim(),
        'rfid': rfid.text.trim(),
        'address': address.text.trim(),
        'fatherOrHusName': fatherOrHusName.text.trim(),
        'religion': religion ?? '',
        'caste': caste ?? '',
        'gender': gender ?? '',
        'dob': dob ?? '',
        'bloodGroup': bloodGroup ?? '',
        'qualification': qualification.text.trim(),
        'panNo': panNo.text.trim(),
        'dlValidity': dlValidity ?? '',
        'dlNo': dlNo.text.trim(),
        'aadhaarNo': aadhaarNo.text.trim(),
        'schoolCode': widget.schoolCode,
        'modified': DateTime.now().toString(),
        'oldMob': oldMob,
        'myClasses': jsonEncode(myClasses)
      });
      if (res.body == 'true') {
        _getProfilePic = getProfilePic();
        if (mounted) {
          setState(() {
            isEdit = false;
          });
          widget.listRefresh();
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
  void initState() {
    getOneStaff();
    _getProfilePic = getProfilePic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
            ),
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
                          mob: mob.text,
                          firstName: firstName.text,
                          lastName: lastName.text,
                          schoolCode: widget.schoolCode,
                          refresh: () {
                            setState(() {
                              _getProfilePic = getProfilePic();
                            });
                            // widget.listRefresh();
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
                        future: _getProfilePic,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              onForegroundImageError: (exception, stackTrace) =>
                                  Text('data'),
                              child: Icon(
                                Icons.account_circle,
                                size: 100,
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
                                mob: mob.text,
                                firstName: firstName.text,
                                lastName: lastName.text,
                                schoolCode: widget.schoolCode,
                                refresh: () {
                                  setState(() {
                                    _getProfilePic = getProfilePic();
                                  });
                                  // widget.listRefresh();
                                },
                              ),
                            ),
                        child: Icon(Icons.camera_alt_rounded)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: getAll
          ? Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (form['joiningDate'] == 'true')
                              MidDateSelectWidget(
                                isEdit: isEdit,
                                title: 'Joining Date',
                                selectedDate: joiningDate,
                                callBack: (p0) {
                                  setState(() {
                                    joiningDate = p0;
                                  });
                                },
                              ),
                            MidTextField(
                              isEdit: isEdit,
                              isValidted: true,
                              label: 'First Name + Middle Name',
                              controller: firstName,
                            ),
                            MidTextField(
                              isEdit: isEdit,
                              label: 'Last Name',
                              controller: lastName,
                            ),
                            if (showClasses)
                              MidDropDownWidget(
                                  items: classes,
                                  title: 'Select Class',
                                  isEdit: isEdit,
                                  callBack: (p0) {
                                    setState(() {
                                      if (!myClasses.contains(p0)) {
                                        myClasses.add(p0);
                                      }
                                    });
                                  },
                                  selected: null),
                            if (showClasses)
                              Wrap(
                                spacing: 10,
                                // runSpacing: 10,
                                children: [
                                  for (String i in myClasses)
                                    OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          disabledForegroundColor: Colors.black,
                                        ),
                                        icon: Icon(Icons.close),
                                        onPressed: isEdit
                                            ? () {
                                                setState(() {
                                                  myClasses.remove(i);
                                                });
                                              }
                                            : null,
                                        label: Text(i))
                                ],
                              ),
                            if (form['designation'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Designation',
                                controller: designation,
                              ),
                            if (form['gender'] == 'true')
                              MidDropDownWidget(
                                isEdit: isEdit,
                                selected: gender,
                                items: ['Male', 'Female'],
                                title: 'Gender',
                                callBack: (p0) {
                                  setState(() {
                                    gender = p0;
                                  });
                                },
                              ),
                            if (form['dob'] == 'true')
                              MidDateSelectWidget(
                                isEdit: isEdit,
                                title: 'Date of Birth',
                                selectedDate: dob,
                                callBack: (p0) {
                                  setState(() {
                                    dob = p0;
                                  });
                                },
                              ),
                            if (form['bloodGroup'] == 'true')
                              MidDropDownWidget(
                                isEdit: isEdit,
                                items: [
                                  'A+',
                                  'A-',
                                  'B+',
                                  'B-',
                                  'O+',
                                  'O-',
                                  'AB+',
                                  'AB-'
                                ],
                                title: 'Blood Group',
                                callBack: (p0) {
                                  setState(() {
                                    bloodGroup = p0;
                                  });
                                },
                                selected: bloodGroup,
                              ),
                            if (form['religion'] == 'true')
                              MidDropDownWidget(
                                isEdit: isEdit,
                                items: religionDropdownList,
                                title: 'Religion',
                                callBack: (p0) {
                                  setState(() {
                                    religion = p0;
                                  });
                                },
                                selected: religion,
                              ),
                            if (form['caste'] == 'true')
                              MidDropDownWidget(
                                isEdit: isEdit,
                                items: ['General', 'OBC', 'SC', 'ST'],
                                title: 'Caste',
                                callBack: (p0) {
                                  setState(() {
                                    caste = p0;
                                  });
                                },
                                selected: caste,
                              ),
                            if (form['subCaste'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Sub-Caste',
                                controller: subCaste,
                              ),
                            if (form['email'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Email',
                                controller: email,
                              ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.length != 10) {
                                  return 'Mobile No. should be 10 digits';
                                }
                                return null;
                              },
                              readOnly: !isEdit,
                              controller: mob,
                              decoration: InputDecoration(
                                isDense: true,
                                label: Text('Mobile No.'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            if (form['rfid'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'RFId',
                                controller: rfid,
                              ),
                            if (form['qualification'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Qualification',
                                controller: qualification,
                              ),
                            if (form['fatherorHusName'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Father/Husband Name',
                                controller: fatherOrHusName,
                              ),
                            if (form['address'] == 'true')
                              MidTextField(
                                  label: 'Address',
                                  controller: address,
                                  isEdit: isEdit),
                            if (form['aadhaarNo'] == 'true')
                              MidTextField(
                                  label: 'Aadhaar No.',
                                  controller: aadhaarNo,
                                  isEdit: isEdit),
                            if (form['panNo'] == 'true')
                              MidTextField(
                                label: 'Pan No.',
                                controller: panNo,
                                isEdit: isEdit,
                              ),
                            if (form['dlNo'] == 'true')
                              MidTextField(
                                  label: 'DL No.',
                                  controller: dlNo,
                                  isEdit: isEdit),
                            if (form['dlValidity'] == 'true')
                              MidDateSelectWidget(
                                isEdit: isEdit,
                                title: 'DL Validity',
                                selectedDate: dlValidity,
                                callBack: (p0) {
                                  setState(() {
                                    dlValidity = p0;
                                  });
                                },
                              )
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
                                onPressed: saveStaffInfo,
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
                        Column(
                          children: [
                            IconButton.filledTonal(
                                // color: Colors.red[600],
                                onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Delete Permanently'),
                                        content: Text(
                                          'Are you sure you want to delete?',
                                        ),
                                        actions: [
                                          OutlinedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('Cancel'),
                                          ),
                                          FilledButton(
                                            // style: ElevatedButton.styleFrom(
                                            //     backgroundColor: Colors.red),
                                            onPressed: () async {
                                              Navigator.of(context).pop();

                                              var url = Uri.parse(
                                                  '$ipv4/deleteMidStaff');
                                              var res = await http
                                                  .post(url, body: {
                                                'mob': widget.mob,
                                                'schoolCode': widget.schoolCode
                                              });
                                              if (res.body == 'true') {
                                                Navigator.of(context).pop();

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.red[600],
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: const Row(
                                                      children: [
                                                        Text(
                                                          'Deleted Sucessfully',
                                                        ),
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );

                                                widget.listRefresh();
                                              }
                                            },
                                            child: Text('Delete'),
                                          )
                                        ],
                                      ),
                                    ),
                                icon: Icon(Icons.delete)),
                            Text(
                              'Delete',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton.filledTonal(
                                // color: Colors.teal[700],
                                onPressed: () async {},
                                icon: Icon(Icons.close)),
                            Text(
                              'Unchecked',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton.filledTonal(
                                // color: Colors.teal[700],
                                onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Warning'),
                                        content: Text(
                                          'The data send to printing can\'t be edited further. Confirm before submiting.',
                                        ),
                                        actions: [
                                          OutlinedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('Cancel'),
                                          ),
                                          FilledButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();

                                              var url =
                                                  Uri.parse('$ipv4/readyStaff');
                                              var res = await http
                                                  .post(url, body: {
                                                'mob': widget.mob,
                                                'schoolCode': widget.schoolCode
                                              });
                                              if (res.body == 'true') {
                                                if (mounted) {
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          Colors.green[600],
                                                      behavior: SnackBarBehavior
                                                          .floating,
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
                                                  widget.listRefresh();
                                                }
                                              }
                                            },
                                            child: Text('Submit'),
                                          )
                                        ],
                                      ),
                                    ),
                                icon: Icon(Icons.print)),
                            Text(
                              'Send print',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class ProfilePicView extends StatefulWidget {
  const ProfilePicView(
      {super.key,
      required this.mob,
      required this.firstName,
      required this.lastName,
      required this.schoolCode,
      required this.refresh});
  final String firstName;
  final String lastName;
  final String mob;
  final String schoolCode;
  final VoidCallback refresh;

  @override
  State<ProfilePicView> createState() => _ProfilePicViewState();
}

class _ProfilePicViewState extends State<ProfilePicView> {
  late Future _getProfilePic;
  getProfilePic() async {
    var url2 =
        Uri.parse('$ipv4/getStaffPicMid/${widget.schoolCode}/${widget.mob}');
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
                      mob: widget.mob.trim(),
                      firstName: widget.firstName.trim(),
                      lastName: widget.lastName.trim(),
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

class ChangePicDialog extends StatefulWidget {
  const ChangePicDialog(
      {super.key,
      required this.mob,
      required this.firstName,
      required this.lastName,
      required this.schoolCode,
      required this.refresh});
  final String firstName;
  final String lastName;
  final String mob;
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
  saveStaffPic() async {
    var url = Uri.parse('$ipv4/saveStaffPicMid');

    var req = http.MultipartRequest(
      'POST',
      url,
    );
    var httpImage = http.MultipartFile.fromBytes(
      'profilePic',
      _image!.readAsBytesSync(),
      filename:
          '${widget.mob}-staff-Profile-Pic${_imgXFile!.name.substring(_imgXFile!.name.lastIndexOf('.'))}',
    );
    req.files.add(httpImage);
    req.fields.addAll({'mob': widget.mob, 'schoolCode': widget.schoolCode});
    var res = await req.send();
    var responded = await http.Response.fromStream(res);
    if (responded.body == 'true') {
      print('uplooaddd');
      widget.refresh();
      // _getProfilePic = getProfilePic();
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
                    onPressed: () async {
                      _imgXFile = await _picker.pickImage(
                          source: ImageSource.camera,
                          maxHeight: 1000,
                          requestFullMetadata: true,
                          maxWidth: 1000);
                      _image = await FlutterExifRotation.rotateImage(
                          path: _imgXFile!.path);

                      saveStaffPic();
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
                      _imgXFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 1000,
                          requestFullMetadata: true,
                          maxWidth: 1000);
                      _image = await FlutterExifRotation.rotateImage(
                          path: _imgXFile!.path);

                      saveStaffPic();
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
