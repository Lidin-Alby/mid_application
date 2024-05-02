import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

import 'ip_address.dart';
import 'textfield_widget.dart';

class AddStaffPage extends StatefulWidget {
  const AddStaffPage({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<AddStaffPage> createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController role = TextEditingController();

  addStaffMid() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('$ipv4/addStaffMid');
      // var client = BrowserClient()..withCredentials = true;
      // var url = Uri.parse('$ipv4/addStaffMid');
      var res = await http.post(url, body: {
        'schoolCode': widget.schoolCode,
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
        'mob': mob.text.trim(),
        'password': mob.text.trim(),
        'role': role.text.trim(),
        'myClasses': jsonEncode([]),
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
          role.clear();
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Staff'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
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
                        TextFieldWidget(
                            label: 'Designation',
                            controller: role,
                            isEdit: true),
                        SizedBox(
                          height: 15,
                        ),
                        FilledButton(
                            onPressed: addStaffMid, child: Text('Add Staff'))
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }
}
