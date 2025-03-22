import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Class/class_bloc.dart';
import 'package:mid_application/Blocs/Class/class_event.dart';
import 'package:mid_application/Blocs/Class/class_state.dart';
import 'package:mid_application/Blocs/Student/student_bloc.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/widgets/address_textfield.dart';
import 'package:mid_application/widgets/gender_radio.dart';
import 'package:mid_application/widgets/my_date_picker.dart';
import 'package:mid_application/widgets/my_dropdown_button.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({super.key, required this.schoolCode});
  final String schoolCode;

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
  String? bloodGroup;
  String? boardingType;
  String? caste;
  String? classTitle;
  String? religion;
  String? transportMode;
  List<ClassModel> classList = [];
  List boardingTypeList = ['Day Scholer', 'Hostel'];
  List religionList = [
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
  List bloodGroupList = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  List casteList = ['General', 'OBC', 'SC', 'ST'];

  List transportList = [
    'Pedistrian',
    'Parent',
    'School Transport',
    'Cycle',
    'Other'
  ];
  late ClassLoaded s;

  double spacing = 12;
  @override
  void initState() {
    ClassBloc classBloc = context.read<ClassBloc>();
    if (classBloc.state is ClassLoaded) {
      s = classBloc.state as ClassLoaded;
      classList = s.classes;
    }
    super.initState();
  }

  clearFields() {
    admNo.clear();
    fullName.clear();
    classTitle = null;
    gender = null;
    dob = null;
    bloodGroup = null;
    religion = null;
    caste = null;
    subCaste.clear();
    email.clear();
    aadhaarNo.clear();
    address.clear();
    rfid.clear();
    transportMode = null;
    session.clear();
    boardingType = null;
    schoolHouse.clear();
    vehicleNo.clear();
    fatherName.clear();
    motherName.clear();
    fatherMobNo.clear();
    motherMobNo.clear();
    fatherWhatsApp.clear();
    motherWhatsApp.clear();
  }

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
            child: BlocConsumer<StudentBloc, StudentState>(
              listener: (context, state) {
                if (state is StudentSaved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added SuccessFully'),
                    ),
                  );
                  clearFields();
                  context.read<ClassBloc>().add(LoadClasses(widget.schoolCode));
                } else if (state is StudentSaveError) {
                  if (state.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error!),
                      ),
                    );
                  }
                }
              },
              builder: (context, state) => Column(
                spacing: 10,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // ProfilePic(),
                  BlocBuilder<ClassBloc, ClassState>(
                    builder: (context, state) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          text: 'Last : ',
                          children: [
                            TextSpan(
                              text:
                                  state is ClassLoaded ? state.lastNo : 'error',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  MyTextfield(
                    label: 'Admission No.',
                    controller: admNo,
                    error: state is StudentSaveError ? state.admNoError : null,
                  ),
                  MyTextfield(label: 'Full Name', controller: fullName),
                  MyDropdownButton(
                    value: classTitle,
                    label: 'Class',
                    onChanged: (value) {
                      setState(() {
                        classTitle = value;
                      });
                    },
                    items: classList
                        .map(
                          (e) => DropdownMenuItem(
                              value: e.classTitle, child: Text(e.classTitle)),
                        )
                        .toList(),
                  ),
                  Row(
                    spacing: spacing,
                    children: [
                      Expanded(
                        child: GenderRadio(
                          gender: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: MyDatePicker(
                          label: 'DOB',
                          onSelected: (value) {
                            dob = value;
                          },
                          value: dob,
                        ),
                      )
                    ],
                  ),
                  Row(
                    spacing: spacing,
                    children: [
                      Expanded(
                        child: MyDropdownButton(
                          value: bloodGroup,
                          label: 'Blood Group',
                          onChanged: (value) {
                            setState(() {
                              bloodGroup = value;
                            });
                          },
                          items: bloodGroupList
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Expanded(
                        child: MyDropdownButton(
                          value: religion,
                          label: 'Religion',
                          onChanged: (value) {
                            setState(() {
                              religion = value;
                            });
                          },
                          items: religionList
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spacing,
                    children: [
                      Expanded(
                        child: MyDropdownButton(
                          value: caste,
                          label: 'Caste',
                          onChanged: (value) {
                            setState(() {
                              caste = value;
                            });
                          },
                          items: casteList
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
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
                          value: transportMode,
                          label: 'Transport Mode',
                          onChanged: (value) {
                            setState(() {
                              transportMode = value;
                            });
                          },
                          items: transportList
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
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
                          value: boardingType,
                          label: 'Boarding Type',
                          onChanged: (value) {
                            setState(() {
                              boardingType = value;
                            });
                          },
                          items: boardingTypeList
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
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
                          error: state is StudentSaveError
                              ? state.fatherMobError
                              : null,
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
                  state is StudentSaveLoading
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyFilledButton(
                              label: 'Cancel',
                              onPressed: () => Navigator.pop(context),
                            ),
                            MyFilledButton(
                              label: 'Save',
                              onPressed: () {
                                BlocProvider.of<StudentBloc>(context).add(
                                  SaveStudentPressed(
                                    Student(
                                      admNo: admNo.text.trim(),
                                      fullName: fullName.text.trim(),
                                      schoolCode: widget.schoolCode,
                                      aadhaarNo: aadhaarNo.text.trim(),
                                      address: address.text.trim(),
                                      bloodGroup: bloodGroup,
                                      boardingType: boardingType,
                                      caste: caste,
                                      classTitle: classTitle!,
                                      dob: dob,
                                      email: email.text.trim(),
                                      fatherMobNo: fatherMobNo.text.trim(),
                                      fatherName: fatherName.text.trim(),
                                      fatherWhatsApp:
                                          fatherWhatsApp.text.trim(),
                                      gender: gender,
                                      motherMobNo: motherMobNo.text.trim(),
                                      motherName: motherName.text.trim(),
                                      motherWhatsApp:
                                          motherWhatsApp.text.trim(),
                                      religion: religion,
                                      rfid: rfid.text.trim(),
                                      schoolHouse: schoolHouse.text.trim(),
                                      session: session.text.trim(),
                                      subCaste: subCaste.text.trim(),
                                      transportMode: transportMode,
                                      vehicleNo: vehicleNo.text.trim(),
                                    ),
                                  ),
                                );
                              },
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
      ),
    );
  }
}
