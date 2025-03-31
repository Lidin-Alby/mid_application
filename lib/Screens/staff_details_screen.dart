import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_state.dart';
import 'package:mid_application/Blocs/Staff%20Details/staff_details_event.dart';
import 'package:mid_application/Blocs/Staff%20Details/staff_details_bloc.dart';
import 'package:mid_application/Blocs/Staff%20Details/staff_details_state.dart';
import 'package:mid_application/Blocs/Staff/staff_bloc.dart';
import 'package:mid_application/Blocs/Staff/staff_event.dart';
import 'package:mid_application/Blocs/Staff/staff_state.dart';
import 'package:mid_application/ip_address.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/teacher.dart';
import 'package:mid_application/widgets/address_textfield.dart';
import 'package:mid_application/widgets/gender_radio.dart';
import 'package:mid_application/widgets/multi_class_selector.dart';
import 'package:mid_application/widgets/my_alert_dialog.dart';
import 'package:mid_application/widgets/my_date_picker.dart';
import 'package:mid_application/widgets/my_dropdown_button.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_popup_menu_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';
import 'package:mid_application/widgets/profile_pic_with_edit.dart';

class StaffDetailsScreen extends StatefulWidget {
  const StaffDetailsScreen({
    super.key,
    required this.schoolCode,
    required this.isTeacher,
    required this.mob,
  });
  final String schoolCode;
  final bool isTeacher;
  final String? mob;

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

  bool isEdit = false;
  String? oldMob;
  String? profilePic;
  bool check = false;
  String? status;

  @override
  void initState() {
    if (widget.mob != null) {
      oldMob = widget.mob;
      context.read<StaffDetailsBloc>().add(
            LoadStaffDetails(schoolCode: widget.schoolCode, mob: widget.mob!),
          );
    } else {
      isEdit = true;
    }
    ClassBloc classBloc = context.read<ClassBloc>();
    if (classBloc.state is ClassLoaded) {
      final s = classBloc.state as ClassLoaded;
      classList = s.classes;
    }

    // if (widget.mob!=null) {
    //   assignValues();
    // }
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

  assignValues(Staff staff) {
    if (widget.isTeacher) {
      classes = (staff as Teacher).classes!.toSet();
    }
    fullName.text = staff.fullName;
    mob.text = staff.mob;
    designation.text = staff.designation!;
    gender = staff.gender;
    dob = staff.dob;
    bloodGroup = staff.bloodGroup;
    religion = staff.religion;
    caste = staff.caste;
    subCaste.text = staff.subCaste.toString();
    department.text = staff.department.toString();
    joiningDate = staff.joiningDate;
    dlValidity = staff.dlValidity;
    dlNo.text = staff.dlNo.toString();
    address.text = staff.address.toString();
    rfid.text = staff.rfid.toString();
    fatherOrHusName.text = staff.fatherOrHusName.toString();
    uan.text = staff.uan.toString();
    aadhaarNo.text = staff.aadhaarNo.toString();
    panNo.text = staff.panNo.toString();
    qualification.text = staff.qualification.toString();
    oldMob = staff.oldMob;
    profilePic = staff.profilePic;
    check = staff.check ?? false;
    status = staff.status;
  }

  Staff newStaffValues() {
    if (widget.isTeacher) {
      return Teacher(
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
        fatherOrHusName: fatherOrHusName.text.trim(),
        gender: gender,
        joiningDate: joiningDate,
        panNo: panNo.text.trim(),
        qualification: qualification.text.trim(),
        religion: religion,
        rfid: rfid.text.trim(),
        subCaste: subCaste.text.trim(),
        uan: uan.text.trim(),
        classes: classes.toList(),
        oldMob: oldMob,
        profilePic: profilePic,
        check: check,
        status: status.toString(),
      );
    }
    return Staff(
      schoolCode: widget.schoolCode,
      fullName: fullName.text.trim(),
      mob: mob.text.trim(),
      designation: designation.text.trim(),
      aadhaarNo: aadhaarNo.text.trim(),
      address: address.text.trim(),
      bloodGroup: bloodGroup,
      caste: caste,
      department: department.text.trim(),
      dlNo: dlNo.text.trim(),
      dlValidity: dlValidity,
      dob: dob,
      fatherOrHusName: fatherOrHusName.text.trim(),
      gender: gender,
      joiningDate: joiningDate,
      panNo: panNo.text.trim(),
      qualification: qualification.text.trim(),
      religion: religion,
      rfid: rfid.text.trim(),
      subCaste: subCaste.text.trim(),
      uan: uan.text.trim(),
      oldMob: oldMob,
      profilePic: profilePic,
      check: check,
      status: status.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isEdit && widget.mob != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEdit = false;
                  });
                },
                icon: Icon(Icons.close),
              )
            : null,
        title: Text(
          widget.mob == null
              ? widget.isTeacher
                  ? 'New Teacher'
                  : 'New Staff'
              : 'Details',
        ),
        actions: widget.mob != null
            ? [
                PopupMenuButton(
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          isEdit = true;
                        });
                      },
                      child: MyPopupMenuButton(
                          label: 'Edit', icon: Icons.edit_outlined),
                    ),
                    PopupMenuItem(
                      child: MyPopupMenuButton(
                          label: 'Share', icon: Icons.share_outlined),
                    ),
                    PopupMenuItem(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => MyAlertDialog(
                          title:
                              'Are you sure you want to perform this action?',
                          subtitle:
                              'This action only deactivates the account and you cannot use reuse the ADMISSION No. unless you contact app support.',
                          icon: Icon(
                            Icons.delete,
                            size: 35,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          cancel: () => Navigator.pop(context),
                          confirm: () {
                            Navigator.pop(context);
                            context.read<StaffBloc>().add(
                                  DeleteStaff(
                                    schoolCode: widget.schoolCode,
                                    mob: widget.mob!,
                                  ),
                                );
                          },
                        ),
                      ),
                      child: MyPopupMenuButton(
                        label: 'Delete',
                        icon: Icons.delete_outline,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => MyAlertDialog(
                          title:
                              'This action will send data to Print. Are you sure you want to perform this action.',
                          subtitle:
                              'You will need to contact app support to undo this action.',
                          icon: Icon(
                            Icons.print,
                            size: 25,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          cancel: () => Navigator.pop(context),
                          confirm: () {
                            status = 'ready';
                            Navigator.pop(context);
                            context.read<StaffBloc>().add(
                                  SaveStaffPressed(
                                    staff: newStaffValues(),
                                    isMob: widget.mob != null,
                                  ),
                                );
                          },
                        ),
                      ),
                      padding: EdgeInsets.only(left: 16),
                      child: MyPopupMenuButton(
                        label: 'Send to Print',
                        icon: Icons.print_outlined,
                      ),
                    ),
                  ],
                )
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: BlocConsumer<StaffBloc, StaffState>(
              listener: (context, saveState) {
                if (saveState is StaffSaveError) {
                  if (saveState.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(saveState.error!),
                      ),
                    );
                  }
                } else if (saveState is StaffSaved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saved Successfully'),
                    ),
                  );
                  if (widget.mob == null) {
                    clearFields();
                  }
                }
              },
              builder: (context, saveState) =>
                  BlocBuilder<StaffDetailsBloc, StaffDetailsState>(
                      builder: (context, state) {
                Staff staff = Staff(
                  designation: '',
                  fullName: '',
                  mob: '',
                  schoolCode: widget.schoolCode,
                );
                if (widget.isTeacher) {
                  staff = Teacher(
                    schoolCode: widget.schoolCode,
                    fullName: '',
                    mob: '',
                    designation: 'midTeacher',
                  );
                }
                if (state is StaffDetailsLoaded && widget.mob != null) {
                  staff = state.staff;
                  if (!isEdit) {
                    assignValues(staff);
                  }
                }

                return Column(
                  spacing: 15,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    if (widget.mob != null)
                      ProfilePicWithEdit(
                        userType: widget.isTeacher ? 'teacher' : 'staff',
                        userId: staff.mob,
                        imageUrl:
                            '$ipv4/getPic/${widget.schoolCode}/$profilePic',
                        schoolCode: widget.schoolCode,
                        fullName: staff.fullName,
                        oldProfilePic: profilePic,
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextfield(
                        label: 'Full Name',
                        controller: fullName,
                        error: saveState is StaffSaveError
                            ? saveState.fullNameError
                            : null),
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
                        error: saveState is StaffSaveError
                            ? saveState.mobError
                            : null),
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
                              setState(() {
                                dlValidity = value;
                              });
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
                              error: saveState is StaffSaveError
                                  ? saveState.designationError
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
                          child:
                              MyTextfield(label: 'UAN Card', controller: uan),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    saveState is StaffSaveLoading
                        ? CircularProgressIndicator()
                        : isEdit
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          staff: newStaffValues(),
                                          isMob: widget.mob != null,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : SizedBox(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
