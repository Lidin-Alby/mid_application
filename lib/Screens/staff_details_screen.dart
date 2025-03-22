import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Class/class_bloc.dart';
import 'package:mid_application/Blocs/Class/class_state.dart';
import 'package:mid_application/Blocs/Staff/staff_bloc.dart';
import 'package:mid_application/Blocs/Staff/staff_event.dart';
import 'package:mid_application/Blocs/Staff/staff_state.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/teacher.dart';
import 'package:mid_application/widgets/address_textfield.dart';
import 'package:mid_application/widgets/gender_radio.dart';
import 'package:mid_application/widgets/multi_class_selector.dart';
import 'package:mid_application/widgets/my_date_picker.dart';
import 'package:mid_application/widgets/my_dropdown_button.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';

class StaffDetailsScreen extends StatefulWidget {
  const StaffDetailsScreen(
      {super.key, required this.schoolCode, required this.isTeacher});
  final String schoolCode;
  final bool isTeacher;

  @override
  State<StaffDetailsScreen> createState() => _StaffDetailsScreenState();
}

class _StaffDetailsScreenState extends State<StaffDetailsScreen> {
  double spacing = 12;
  TextEditingController fullName = TextEditingController();
  String? gender;
  String? dob;
  String? bloodGroup;
  String? religion;
  String? caste;
  String? dlValidity;
  String? joiningDate;
  TextEditingController subCaste = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController dlNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController rfid = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController fatherOrHusName = TextEditingController();
  TextEditingController uan = TextEditingController();
  TextEditingController aadhaarNo = TextEditingController();
  TextEditingController panNo = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController qualification = TextEditingController();
  Set classes = {};

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
  List<ClassModel> classList = [];

  @override
  void initState() {
    ClassBloc classBloc = context.read<ClassBloc>();
    if (classBloc.state is ClassLoaded) {
      final s = classBloc.state as ClassLoaded;
      classList = s.classes;
    }
    super.initState();
  }

  clearFields() {
    fullName.clear();
    mob.clear();
    designation.clear();
    gender = null;
    dob = null;
    bloodGroup = null;
    religion = null;
    caste = null;
    subCaste.clear();
    department.clear();
    joiningDate = null;
    dlValidity = null;
    dlNo.clear();
    address.clear();
    rfid.clear();
    fatherOrHusName.clear();
    uan.clear();
    aadhaarNo.clear();
    panNo.clear();
    qualification.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isTeacher ? 'New Teacher' : 'New Staff'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: BlocConsumer<StaffBloc, StaffState>(
              listener: (context, state) {
                if (state is StaffSaveError) {
                  if (state.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error!),
                      ),
                    );
                  }
                } else if (state is StaffSaved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saved Successfully'),
                    ),
                  );
                  clearFields();
                }
              },
              builder: (context, state) => Column(
                spacing: 15,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  MyTextfield(
                      label: 'Full Name',
                      controller: fullName,
                      error:
                          state is StaffSaveError ? state.fullNameError : null),
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
                            setState(() {
                              dob = value;
                            });
                          },
                          value: dob,
                        ),
                      ),
                    ],
                  ),
                  if (widget.isTeacher)
                    MultiClassSelector(
                      classList: classList,
                      onSelected: (value) {
                        setState(() {
                          classes.add(value);
                        });
                      },
                      selectedClasses: classes,
                      onRemove: (value) {
                        setState(() {
                          classes.remove(value);
                        });
                      },
                    ),
                  MyTextfield(
                      label: 'Mobile No.',
                      controller: mob,
                      error: state is StaffSaveError ? state.mobError : null),
                  MyTextfield(
                      label: 'Qualification', controller: qualification),
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
                      ),
                    ],
                  ),
                  Row(
                    spacing: spacing,
                    children: [
                      Expanded(
                        child: MyTextfield(
                            label: 'Department', controller: department),
                      ),
                      Expanded(
                        child: MyDatePicker(
                          label: 'Joining Date',
                          onSelected: (value) {
                            setState(() {
                              joiningDate = value;
                            });
                          },
                          value: joiningDate,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spacing,
                    children: [
                      Expanded(
                        child: MyDatePicker(
                          label: 'DL Validity',
                          onSelected: (value) {
                            dlValidity = value;
                          },
                          value: dlValidity,
                        ),
                      ),
                      Expanded(
                        child: MyTextfield(label: 'DL No.', controller: dlNo),
                      ),
                    ],
                  ),
                  AddressTextfield(label: 'Address', controller: address),
                  Row(
                    spacing: spacing,
                    children: [
                      Expanded(
                        child: MyTextfield(
                            label: 'Aadhaar No.', controller: aadhaarNo),
                      ),
                      Expanded(
                        child: MyTextfield(label: 'Pan', controller: panNo),
                      )
                    ],
                  ),
                  Row(
                    spacing: spacing,
                    children: [
                      Expanded(
                        child: MyTextfield(label: 'RFID', controller: rfid),
                      ),
                      if (!widget.isTeacher)
                        Expanded(
                          child: MyTextfield(
                            label: 'Designation',
                            controller: designation,
                            error: state is StaffSaveError
                                ? state.designationError
                                : null,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    spacing: spacing,
                    children: [
                      Expanded(
                        child: MyTextfield(
                            label: 'Father/Husband',
                            controller: fatherOrHusName),
                      ),
                      Expanded(
                        child: MyTextfield(label: 'UAN Card', controller: uan),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  state is StaffSaveLoading
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
                                BlocProvider.of<StaffBloc>(context).add(
                                  SaveStaffPressed(
                                    widget.isTeacher
                                        ? Teacher(
                                            schoolCode: widget.schoolCode,
                                            fullName: fullName.text.trim(),
                                            mob: mob.text.trim(),
                                            designation: 'midTeacher',
                                            aadhaarNo: aadhaarNo.text.trim(),
                                            address: address.text.trim(),
                                            bloodGroup: bloodGroup,
                                            caste: caste,
                                            department: department.text.trim(),
                                            dlNo: dlNo.text.trim(),
                                            dlValidity: dlValidity,
                                            dob: dob,
                                            fatherOrHusName:
                                                fatherOrHusName.text.trim(),
                                            gender: gender,
                                            joiningDate: joiningDate,
                                            panNo: panNo.text.trim(),
                                            qualification:
                                                qualification.text.trim(),
                                            religion: religion,
                                            rfid: rfid.text.trim(),
                                            subCaste: subCaste.text.trim(),
                                            uan: uan.text.trim(),
                                            classes: classes.toList(),
                                          )
                                        : Staff(
                                            schoolCode: widget.schoolCode,
                                            fullName: fullName.text.trim(),
                                            mob: mob.text.trim(),
                                            designation:
                                                designation.text.trim(),
                                            aadhaarNo: aadhaarNo.text.trim(),
                                            address: address.text.trim(),
                                            bloodGroup: bloodGroup,
                                            caste: caste,
                                            department: department.text.trim(),
                                            dlNo: dlNo.text.trim(),
                                            dlValidity: dlValidity,
                                            dob: dob,
                                            fatherOrHusName:
                                                fatherOrHusName.text.trim(),
                                            gender: gender,
                                            joiningDate: joiningDate,
                                            panNo: panNo.text.trim(),
                                            qualification:
                                                qualification.text.trim(),
                                            religion: religion,
                                            rfid: rfid.text.trim(),
                                            subCaste: subCaste.text.trim(),
                                            uan: uan.text.trim(),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
