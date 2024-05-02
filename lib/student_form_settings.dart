import 'dart:convert';
import 'package:flutter/material.dart';

// import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'ip_address.dart';

class StudentFormMid extends StatefulWidget {
  const StudentFormMid({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<StudentFormMid> createState() => _StudentFormMidState();
}

class _StudentFormMidState extends State<StudentFormMid> {
  // bool admDate = false;
  bool gender = false;
  bool dob = false;
  bool bloodgroup = false;
  // bool sibling = false;
  bool religion = false;
  bool caste = false;
  bool subCaste = false;
  bool email = false;
  bool rfid = false;
  bool session = false;
  bool boardingType = false;
  bool schoolHouse = false;
  bool address = false;
  bool transportMode = false;

  bool vehicleNo = false;
  bool fatherName = false;

  bool fatherMobNo = false;
  bool fatherWhatsapp = false;

  bool fatherPic = false;
  bool motherPic = false;
  bool studentPic = false;

  bool motherName = false;

  bool motherMobNo = false;
  bool motherWhatsapp = false;
  bool classTitle = false;

  late Future _getFormAcces;

  getFormAccessStudent() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getFormAccessStudentMid/${widget.schoolCode}');
    var res = await http.get(url);

    print('done');
    print(res.body);
    Map data = jsonDecode(res.body);
    if (data.containsKey('studentFormMid')) {
      data = data['studentFormMid'];
      data = {...data.map((key, value) => MapEntry(key, bool.parse(value)))};
      initialize(data);
    }
    return data;
    // schoolCode = cl.last['schoolCode'];
  }

  initialize(Map data) {
    gender = data['gender'];
    dob = data['dob'];
    bloodgroup = data['bloodgroup'];
    classTitle = data['classTitle'];

    religion = data['religion'];
    caste = data['caste'];
    subCaste = data['subCaste'];

    email = data['email'];
    rfid = data['rfid'];
    session = data['session'];
    boardingType = data['boardingType'];
    schoolHouse = data['schoolHouse'];

    vehicleNo = data['vehicleNo'];
    studentPic = data['studentPic'];
    fatherPic = data['fatherPic'];
    motherPic = data['motherPic'];

    fatherName = data['fatherName'];

    fatherMobNo = data['fatherMobNo'];

    fatherWhatsapp = data['fatherWhatsapp'];

    motherName = data['motherName'];

    motherMobNo = data['motherMobNo'];

    motherWhatsapp = data['motherWhatsapp'];
    address = data['address'];
    transportMode = data['transportMode'];
  }

  addFormAccessStudent() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/addFormAccessStudentMid');
    var res = await http.post(url, body: {
      'schoolCode': widget.schoolCode,
      'gender': gender.toString(),
      'dob': dob.toString(),
      'classTitle': classTitle.toString(),
      'bloodgroup': bloodgroup.toString(),
      'religion': religion.toString(),
      'caste': caste.toString(),
      'subCaste': subCaste.toString(),
      'email': email.toString(),
      'rfid': rfid.toString(),
      'session': session.toString(),
      'boardingType': boardingType.toString(),
      'schoolHouse': schoolHouse.toString(),
      'vehicleNo': vehicleNo.toString(),
      'fatherName': fatherName.toString(),
      'fatherPic': fatherPic.toString(),
      'motherPic': motherPic.toString(),
      'studentPic': studentPic.toString(),
      'fatherMobNo': fatherMobNo.toString(),
      'fatherWhatsapp': fatherWhatsapp.toString(),
      'motherName': motherName.toString(),
      'motherMobNo': motherMobNo.toString(),
      'motherWhatsapp': motherWhatsapp.toString(),
      'address': address.toString(),
      'transportMode': transportMode.toString()
    });
    if (res.body == 'true') {
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

  @override
  void initState() {
    _getFormAcces = getFormAccessStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _getFormAcces,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: addFormAccessStudent,
                          child: Text('Save'),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Class'),
                      value: classTitle,
                      onChanged: (value) {
                        setState(() {
                          classTitle = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Gender'),
                      value: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Date of Birth'),
                      value: dob,
                      onChanged: (value) {
                        setState(() {
                          dob = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Blood group'),
                      value: bloodgroup,
                      onChanged: (value) {
                        setState(() {
                          bloodgroup = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Religion'),
                      value: religion,
                      onChanged: (value) {
                        setState(() {
                          religion = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Student Picture'),
                      value: studentPic,
                      onChanged: (value) {
                        setState(() {
                          studentPic = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Father Picture'),
                      value: fatherPic,
                      onChanged: (value) {
                        setState(() {
                          fatherPic = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Mother Picture'),
                      value: motherPic,
                      onChanged: (value) {
                        setState(() {
                          motherPic = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Caste'),
                      value: caste,
                      onChanged: (value) {
                        setState(() {
                          caste = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Sub-Caste'),
                      value: subCaste,
                      onChanged: (value) {
                        setState(() {
                          subCaste = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Email'),
                      value: email,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Address'),
                      value: address,
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('RFID'),
                      value: rfid,
                      onChanged: (value) {
                        setState(() {
                          rfid = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Transport Mode'),
                      value: transportMode,
                      onChanged: (value) {
                        setState(() {
                          transportMode = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Session'),
                      value: session,
                      onChanged: (value) {
                        setState(() {
                          session = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Boarding Type'),
                      value: boardingType,
                      onChanged: (value) {
                        setState(() {
                          boardingType = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('School House'),
                      value: schoolHouse,
                      onChanged: (value) {
                        setState(() {
                          schoolHouse = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Vehicle No.'),
                      value: vehicleNo,
                      onChanged: (value) {
                        setState(() {
                          vehicleNo = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Father Name'),
                      value: fatherName,
                      onChanged: (value) {
                        setState(() {
                          fatherName = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Father Mobile No.'),
                      value: fatherMobNo,
                      onChanged: (value) {
                        setState(() {
                          fatherMobNo = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Father Whatsapp No.'),
                      value: fatherWhatsapp,
                      onChanged: (value) {
                        setState(() {
                          fatherWhatsapp = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Mother\'s Name'),
                      value: motherName,
                      onChanged: (value) {
                        setState(() {
                          motherName = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Mother Mobile No.'),
                      value: motherMobNo,
                      onChanged: (value) {
                        setState(() {
                          motherMobNo = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      dense: true,
                      title: Text('Mother Whatsapp No.'),
                      value: motherWhatsapp,
                      onChanged: (value) {
                        setState(() {
                          motherWhatsapp = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
