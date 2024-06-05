import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:http/browser_client.dart';
import 'dropdown_widget.dart';
import 'textfield_widget.dart';

import 'ip_address.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mob = TextEditingController();
  List selectedClasses = [];

  late Future _getClasses;

  getClass() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getMidClasses/${widget.schoolCode}');
    var res = await http.get(url);
    Map data = jsonDecode(res.body);
    return data;
  }

  getTeacherMid() async {
    // var client = BrowserClient()..withCredentials = true;
    var url = Uri.parse('$ipv4/getTeacherMid/${widget.schoolCode}');
    var res = await http.get(url);

    List staffs = json.decode(res.body);
    print(staffs);
    return staffs;
  }

  addTeacherMid() async {
    if (_formKey.currentState!.validate()) {
      // var client = BrowserClient()..withCredentials = true;
      var url = Uri.parse('$ipv4/addStaffMid');
      var res = await http.post(url, body: {
        'schoolCode': widget.schoolCode,
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
        'mob': mob.text.trim(),
        'password': mob.text.trim(),
        'role': 'midTeacher',
        'myClasses': jsonEncode(selectedClasses),
        'subCaste': '',
        'email': '',
        'rfid': '',
        'address': '',
        'fatherOrHusName': '',
        'religion': '',
        'caste': '',
        'gender': '',
        'dob': '',
        'bloodGroup': '',
        'qualification': '',
        'panNo': '',
        'dlValidity': '',
        'dlNo': '',
        'aadhaarNo': '',
        'ready': false.toString(),
        'check': false.toString(),
        'profilePic': ''
      });

      if (res.body == 'true') {
        setState(() {
          firstName.clear();
          lastName.clear();
          mob.clear();
          selectedClasses = [];
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green[600],
              behavior: SnackBarBehavior.floating,
              content: const Row(
                children: [
                  Text(
                    'Added Sucessfully',
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
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[600],
              behavior: SnackBarBehavior.floating,
              content: Row(
                children: [
                  Text(
                    res.body,
                  ),
                  Icon(
                    Icons.error,
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
    _getClasses = getClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _getClasses,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List classes = [];
                classes =
                    snapshot.data['classes'].map((e) => e['title']).toList();
                return Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldWidget(
                            isValidted: true,
                            label: 'First Name',
                            controller: firstName,
                            isEdit: true),
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                            label: 'Last Name',
                            controller: lastName,
                            isEdit: true),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              if (value.length != 10) {
                                return 'Mobile No. should be 10 digits';
                              }
                              return null;
                            },
                            readOnly: false,
                            controller: mob,
                            decoration: InputDecoration(
                              isDense: true,
                              label: Text('Mobile No.'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropDownWidget(
                            items: classes,
                            title: 'Select Class',
                            isEdit: true,
                            callBack: (p0) {
                              setState(() {
                                if (!selectedClasses.contains(p0)) {
                                  selectedClasses.add(p0);
                                }
                              });
                            },
                            selected: null),
                        SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (String i in selectedClasses)
                              OutlinedButton.icon(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      selectedClasses.remove(i);
                                    });
                                  },
                                  label: Text(i))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FilledButton(
                            onPressed: addTeacherMid,
                            child: Text('Add Teacher'))
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
