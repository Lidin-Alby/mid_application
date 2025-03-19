import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mid_application/widgets/address_textfield.dart';
import 'package:mid_application/widgets/my_dropdown_button.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';
import 'package:mid_application/widgets/profile_pic.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({super.key});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController admNo = TextEditingController();
  String? dob;
  TextEditingController address = TextEditingController();
  String? gender;
  TextEditingController subCaste = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController rfid = TextEditingController();
  TextEditingController session = TextEditingController();
  TextEditingController schoolHouse = TextEditingController();
  TextEditingController vehicleNo = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController fatherMobNo = TextEditingController();
  TextEditingController motherMobNo = TextEditingController();
  TextEditingController fatherWhatsApp = TextEditingController();
  TextEditingController motherWhatsApp = TextEditingController();
  TextEditingController aadhaarNo = TextEditingController();

  double spacing = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Column(
              spacing: 10,
              children: [
                SizedBox(
                  height: 5,
                ),
                ProfilePic(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      text: 'Last : ',
                      children: [
                        TextSpan(
                          text: '12487',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                MyTextfield(label: 'Admission No.', controller: admNo),
                MyTextfield(label: 'Full Name', controller: fullName),
                MyDropdownButton(
                  label: 'Class',
                  onChanged: (value) {},
                  items: [DropdownMenuItem(child: Text('data'))],
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 25,
                                child: Radio(
                                  value: 'Male',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                              ),
                              Text('Male'),
                              SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: 25,
                                child: Radio(
                                  // visualDensity: VisualDensity(horizontal: 0),
                                  value: 'Female',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                              ),
                              Text('Female')
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DOB',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1990),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setState(() {
                                  dob = DateFormat('dd-MM-yyyy').format(date);
                                });
                              }
                            },
                            child: Container(
                              height: 34,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black38,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(dob ?? ''),
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: MyDropdownButton(
                        label: 'Blood Group',
                        onChanged: (value) {},
                        items: [],
                      ),
                    ),
                    Expanded(
                      child: MyDropdownButton(
                        label: 'Religion',
                        onChanged: (value) {},
                        items: [],
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: MyDropdownButton(
                        label: 'Caste',
                        onChanged: (value) {},
                        items: [],
                      ),
                    ),
                    Expanded(
                      child: MyTextfield(
                        label: 'Sub-Caste',
                        controller: subCaste,
                      ),
                    )
                  ],
                ),
                MyTextfield(
                  label: 'Email',
                  controller: email,
                ),
                MyTextfield(label: 'Aadhaar No.', controller: aadhaarNo),
                AddressTextfield(
                  label: 'Address',
                  controller: address,
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: MyTextfield(
                        label: 'RFID',
                        controller: rfid,
                      ),
                    ),
                    Expanded(
                      child: MyDropdownButton(
                        label: 'Transport Mode',
                        onChanged: (value) {},
                        items: [],
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: MyTextfield(
                        label: 'Session',
                        controller: session,
                      ),
                    ),
                    Expanded(
                      child: MyDropdownButton(
                        label: 'Boarding Type',
                        onChanged: (value) {},
                        items: [],
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: MyTextfield(
                        label: 'School House',
                        controller: schoolHouse,
                      ),
                    ),
                    Expanded(
                      child: MyTextfield(
                        label: 'Vehicle No.',
                        controller: vehicleNo,
                      ),
                    )
                  ],
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: MyTextfield(
                        label: 'Father Name',
                        controller: fatherName,
                      ),
                    ),
                    Expanded(
                      child: MyTextfield(
                        label: 'Mother Name',
                        controller: motherName,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: MyTextfield(
                        label: 'Father Phone',
                        controller: fatherMobNo,
                      ),
                    ),
                    Expanded(
                      child: MyTextfield(
                        label: 'Mother Phone',
                        controller: motherMobNo,
                      ),
                    )
                  ],
                ),
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: MyTextfield(
                        label: 'Father WhatsApp',
                        controller: fatherWhatsApp,
                      ),
                    ),
                    Expanded(
                      child: MyTextfield(
                        label: 'Mother WhatsApp',
                        controller: motherWhatsApp,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyFilledButton(
                      label: 'Cancel',
                      onPressed: () {},
                    ),
                    MyFilledButton(
                      label: 'Save',
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
