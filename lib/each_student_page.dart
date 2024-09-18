import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:go_router/go_router.dart';
// import 'package:http/browser_client.dart';

import 'package:http/http.dart' as http;

import 'change_pic_dialog.dart';
import 'helper_widgets.dart';
import 'ip_address.dart';

class EachStudentPage extends StatefulWidget {
  const EachStudentPage({
    super.key,
    required this.schoolCode,
    required this.admNo,
    required this.listRefresh,
  });
  final String schoolCode;
  final String admNo;

  final VoidCallback listRefresh;

  @override
  State<EachStudentPage> createState() => _EachStudentPageState();
}

class _EachStudentPageState extends State<EachStudentPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController admNo = TextEditingController();
  TextEditingController subCaste = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController rfid = TextEditingController();
  TextEditingController session = TextEditingController();

  TextEditingController schoolHouse = TextEditingController();
  TextEditingController address = TextEditingController();
  // TextEditingController  = TextEditingController();

  TextEditingController vehicleNo = TextEditingController();
  TextEditingController fatherName = TextEditingController();

  TextEditingController fatherMobNo = TextEditingController();
  TextEditingController fatherWhatsApp = TextEditingController();

  // TextEditingController fatherPic = TextEditingController();
  // TextEditingController motherPic = TextEditingController();
  // TextEditingController studentPic = TextEditingController();

  TextEditingController motherName = TextEditingController();

  TextEditingController motherMobNo = TextEditingController();
  TextEditingController motherWhatsApp = TextEditingController();
  List boardingDropdownList = ['Day Scholer', 'Hostel'];
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
  List classDropdownList = [];
  String? religion;
  String? caste;
  // String? schoolHouse;
  String? boardingType;
  String? classNo;
  String? gender;
  String? dob;
  String? bloodGroup;
  String? transportMode;

  bool isEdit = false;
  Map form = {};
  bool getAll = false;
  bool opacity = false;
  bool check = false;
  bool ready = false;
  bool? printed = false;
  // Uint8List? _imagebytes;
  // PlatformFile? _image;
  Map oneStudent = {};
  late Future _getProfilePic;

  getClass() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getMidClasses/${widget.schoolCode}');
    var res = await http.get(url);
    Map data = jsonDecode(res.body);

    classDropdownList = data['classes'].map((e) => e['title']).toList();
  }

  getFormAccessStudent() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getFormAccessStudentMid/${widget.schoolCode}');
    var res = await http.get(url);

    Map data = jsonDecode(res.body);
    // Map form = data['studentForm'];
    print(data);
    form = data['studentFormMid'];
    getClass();

    setState(() {
      getAll = true;
    });
  }

  getOneStudent() async {
    // var client = BrowserClient()..withCredentials = true;

    var url = Uri.parse(
        '$ipv4/getOneStudent/${widget.schoolCode}/?admNo=${Uri.encodeQueryComponent(widget.admNo)}');
    var res = await http.get(url);
    print(res.body);

    Map data = jsonDecode(res.body);

    if (data["ready"] == null) {
      data['ready'] = true;
    }

    firstName.text = data['firstName'];
    lastName.text = data['lastName'].toString();
    fatherName.text = data['fatherName'];
    motherName.text = data['motherName'];
    classNo = data['classTitle'] == '' ? null : data['classTitle'];
    gender = data['gender'] == '' ? null : data['gender'];
    dob = data['dob'];
    admNo.text = data['admNo'];

    bloodGroup = data['bloodGroup'] == '' ? null : data['bloodGroup'];

    religion = data['religion'] == '' ? null : data['religion'];
    caste = data['caste'] == '' ? null : data['caste'];
    subCaste.text = data['subCaste'];
    email.text = data['email'];
    fatherMobNo.text = data['fatherMobNo'];
    fatherWhatsApp.text = data['fatherWhatsApp'].toString();
    motherMobNo.text = data['motherMobNo'].toString();
    motherWhatsApp.text = data['motherWhatsApp'].toString();
    schoolHouse.text = data['schoolHouse'].toString();

    boardingType = data['boardingType'] == '' ? null : data['boardingType'];
    // schoolHouse = data['schoolHouse'] == '' ? null : data['schoolHouse'];

    vehicleNo.text = data['vehicleNo'];
    transportMode = data['transportMode'] == '' ? null : data['transportMode'];

    rfid.text = data['rfid'];
    check = data['check'];

    ready = data['ready'];
    printed = data['printed'];

    address.text = data['address'].toString();
    session.text = data['session'].toString();

    getFormAccessStudent();
  }

  getProfilePic() async {
    var url2 = Uri.parse(
        '$ipv4/getProfilePicMid/${widget.schoolCode}/?admNo=${Uri.encodeQueryComponent(widget.admNo)}');
    // var client = BrowserClient()..withCredentials = true;
    var response2 = await http.get(url2);

    return (response2.bodyBytes);
  }

  saveStudentInfo() async {
    if (_formKey.currentState!.validate()) {
      // var client = BrowserClient()..withCredentials = true;
      var url = Uri.parse('$ipv4/updateStudentInfoMid');
      var res = await http.post(url, body: {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
        'admNo': admNo.text.trim(),
        'subCaste': subCaste.text.trim(),
        'email': email.text.trim(),
        'rfid': rfid.text.trim(),
        'session': session.text.trim(),
        'schoolHouse': schoolHouse.text.trim(),
        'address': address.text.trim(),
        'vehicleNo': vehicleNo.text.trim(),
        'fatherName': fatherName.text.trim(),
        'fatherMobNo': fatherMobNo.text.trim(),
        'fatherWhatsApp': fatherWhatsApp.text.trim(),
        'motherName': motherName.text.trim(),
        'motherMobNo': motherMobNo.text.trim(),
        'motherWhatsApp': motherWhatsApp.text.trim(),
        'religion': religion ?? '',
        'caste': caste ?? '',
        'boardingType': boardingType ?? '',
        'classTitle': classNo ?? '',
        'gender': gender ?? '',
        'dob': dob ?? '',
        'bloodGroup': bloodGroup ?? '',
        'transportMode': transportMode ?? '',
        'schoolCode': widget.schoolCode,
        'modified': DateTime.now().toString()
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

  showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.floating,
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
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    getOneStudent();
    _getProfilePic = getProfilePic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
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
                          admNo: admNo.text,
                          firstName: firstName.text,
                          lastName: lastName.text,
                          schoolCode: widget.schoolCode,
                          refresh: () {
                            setState(() {
                              _getProfilePic = getProfilePic();
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
                                admNo: admNo.text,
                                firstName: firstName.text,
                                lastName: lastName.text,
                                schoolCode: widget.schoolCode,
                                refresh: () {
                                  setState(() {
                                    _getProfilePic = getProfilePic();
                                  });
                                  widget.listRefresh();
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
        // elevation: 0,
      ),
      body: getAll
          ? Column(
              children: [
                // Container(

                //   child:
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(bottom: 20),
                //         child:

                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            if (form['classTitle'] == 'true')
                              MidDropDownWidget(
                                isEdit: isEdit,
                                selected: classNo,
                                title: 'Class/Course',
                                items: classDropdownList,
                                callBack: (p0) {
                                  setState(() {
                                    classNo = p0;
                                  });
                                },
                              ),
                            MidTextField(
                              isEdit: false,
                              isValidted: true,
                              label: 'Admission No.',
                              controller: admNo,
                            ),
                            if (form['session'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Session',
                                controller: session,
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
                                  selected: bloodGroup),
                            if (form['fatherName'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Father\'s Name',
                                controller: fatherName,
                                isValidted: true,
                              ),
                            if (form['fatherMobNo'] == 'true')
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
                                controller: fatherMobNo,
                                decoration: InputDecoration(
                                  isDense: true,
                                  label: Text('Mobile No.'),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            if (form['fatherWhatsapp'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Father\'s Whatsapp No.',
                                controller: fatherWhatsApp,
                              ),
                            if (form['motherName'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Mother\'s Name',
                                controller: motherName,
                                isValidted: true,
                              ),
                            if (form['motherMobNo'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Mother\'s Mobile No.',
                                controller: motherMobNo,
                              ),
                            if (form['motherWhatsapp'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Mother\'s Whatsapp No.',
                                controller: motherWhatsApp,
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
                            if (form['address'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'Address',
                                controller: address,
                              ),
                            if (form['schoolHouse'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'School House',
                                controller: schoolHouse,
                              ),
                            if (form['boardingType'] == 'true')
                              MidDropDownWidget(
                                  isEdit: isEdit,
                                  items: boardingDropdownList,
                                  title: 'Boarding Type',
                                  callBack: (p0) {
                                    setState(() {
                                      boardingType = p0;
                                    });
                                  },
                                  selected: boardingType),
                            if (form['transportMode'] == 'true')
                              MidDropDownWidget(
                                  isEdit: isEdit,
                                  items: [
                                    'Pedistrian',
                                    'Parent',
                                    'School Transport',
                                    'Cycle',
                                    'Other'
                                  ],
                                  title: 'Transport Mode',
                                  callBack: (p0) {
                                    setState(() {
                                      transportMode = p0;
                                    });
                                  },
                                  selected: transportMode),
                            if (form['vehicleNo'] == 'true')
                              MidTextField(
                                  label: 'Vehicle No.',
                                  controller: vehicleNo,
                                  isEdit: isEdit),
                            if (form['rfid'] == 'true')
                              MidTextField(
                                isEdit: isEdit,
                                label: 'RFId',
                                controller: rfid,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (ready == false && printed == null)
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
                                  onPressed: saveStudentInfo,
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
                                                // Navigator.of(context).pop();

                                                var url = Uri.parse(
                                                    '$ipv4/deleteMidStudent');
                                                var res = await http.post(url,
                                                    body: {
                                                      'admNo': widget.admNo,
                                                      'schoolCode':
                                                          widget.schoolCode
                                                    });

                                                if (res.body == 'true') {
                                                  widget.listRefresh();
                                                  showSnackBar();
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
                                  onPressed: () async {
                                    var url =
                                        Uri.parse('$ipv4/checkMidStudent');
                                    var res = await http.post(url, body: {
                                      'admNo': widget.admNo,
                                      'check': (!check).toString(),
                                      'schoolCode': widget.schoolCode
                                    });
                                    if (res.body == 'true') {
                                      if (mounted) {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green[600],
                                            behavior: SnackBarBehavior.floating,
                                            content: const Row(
                                              children: [
                                                Text(
                                                  'Marked Sucessfully',
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
                                      widget.listRefresh();
                                    }
                                  },
                                  icon: Icon(check
                                      ? Icons.check_rounded
                                      : Icons.close)),
                              Text(
                                check ? 'Checked' : 'Unchecked',
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
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();

                                                var url = Uri.parse(
                                                    '$ipv4/readyStudent');
                                                var res = await http.post(url,
                                                    body: {
                                                      'admNo': widget.admNo,
                                                      'schoolCode':
                                                          widget.schoolCode
                                                    });
                                                if (res.body == 'true') {
                                                  if (mounted) {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        backgroundColor:
                                                            Colors.green[600],
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        content: const Row(
                                                          children: [
                                                            Text(
                                                              'Updated Sucessfully',
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.white,
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
  State<ProfilePicView> createState() => _ProfilePicViewState();
}

class _ProfilePicViewState extends State<ProfilePicView> {
  late Future _getProfilePic;
  getProfilePic() async {
    var url2 = Uri.parse(
        '$ipv4/getProfilePicMid/${widget.schoolCode}/?admNo=${Uri.encodeQueryComponent(widget.admNo)}');
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
                      admNo: widget.admNo.trim(),
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
