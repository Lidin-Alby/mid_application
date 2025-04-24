import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_bloc.dart';
import 'package:mid_application/Blocs/Class%20Model/class_event.dart';
import 'package:mid_application/Blocs/Class%20Model/class_state.dart';
import 'package:mid_application/Blocs/Form%20Settings/form__settings_state.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_bloc.dart';
import 'package:mid_application/Blocs/School%20details/school_details_bloc.dart';
import 'package:mid_application/Blocs/School%20details/school_details_event.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_bloc.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_event.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_state.dart';
import 'package:mid_application/Blocs/Student/student_bloc.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/models/class_model.dart';
import 'package:mid_application/models/form_student.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/widgets/address_textfield.dart';
import 'package:mid_application/widgets/gender_radio.dart';
import 'package:mid_application/widgets/multiple_entry_widget.dart';
import 'package:mid_application/widgets/my_alert_dialog.dart';
import 'package:mid_application/widgets/my_date_picker.dart';
import 'package:mid_application/widgets/my_dropdown_button.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_popup_menu_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';
import 'package:mid_application/widgets/profile_pic_with_edit.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({
    super.key,
    required this.schoolCode,
    required this.admNo,
  });
  final String schoolCode;
  final String? admNo;

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
  bool isEdit = false;
  String? profilePic;
  bool check = false;
  String? printStatus;
  bool sendToPrint = false;
  bool isExpanded = false;
//  late DateTime modified;

  double spacing = 12;
  @override
  void initState() {
    if (widget.admNo != null) {
      context.read<StudentDetailsBloc>().add(LoadStudentDetails(
          admNo: widget.admNo!, schoolCode: widget.schoolCode));
    } else {
      isEdit = true;
    }
    ClassBloc classBloc = context.read<ClassBloc>();
    if (classBloc.state is ClassLoaded) {
      s = classBloc.state as ClassLoaded;
      classList = s.classes;
    }

    // if (widget.student != null) {
    //   student = widget.student!;
    //   assignValues();
    // }

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

  assignValues(Student student) {
    admNo.text = student.admNo;
    fullName.text = student.fullName;
    classTitle = student.classTitle;
    gender = student.gender;
    dob = student.dob;
    bloodGroup = student.bloodGroup;
    religion = student.religion;
    caste = student.caste;
    subCaste.text = student.subCaste.toString();
    email.text = student.email.toString();
    aadhaarNo.text = student.aadhaarNo.toString();
    address.text = student.address.toString();
    rfid.text = student.rfid.toString();
    transportMode = student.transportMode;
    session.text = student.session.toString();
    boardingType = student.boardingType;
    schoolHouse.text = student.schoolHouse.toString();
    vehicleNo.text = student.vehicleNo.toString();
    fatherName.text = student.fatherName.toString();
    motherName.text = student.motherName.toString();
    fatherMobNo.text = student.fatherMobNo.toString();
    motherMobNo.text = student.motherName.toString();
    fatherWhatsApp.text = student.fatherWhatsApp.toString();
    motherWhatsApp.text = student.motherWhatsApp.toString();
    profilePic = student.profilePic;
    check = student.check ?? false;
    printStatus = student.printStatus;
  }

  Student newStudentValues() {
    return Student(
      admNo: admNo.text.trim(),
      fullName: fullName.text.trim(),
      schoolCode: widget.schoolCode,
      aadhaarNo: aadhaarNo.text.trim(),
      address: address.text.trim(),
      bloodGroup: bloodGroup,
      boardingType: boardingType,
      caste: caste,
      classTitle: classTitle,
      dob: dob,
      email: email.text.trim(),
      fatherMobNo: fatherMobNo.text.trim(),
      fatherName: fatherName.text.trim(),
      fatherWhatsApp: fatherWhatsApp.text.trim(),
      gender: gender,
      motherMobNo: motherMobNo.text.trim(),
      motherName: motherName.text.trim(),
      motherWhatsApp: motherWhatsApp.text.trim(),
      religion: religion,
      rfid: rfid.text.trim(),
      schoolHouse: schoolHouse.text.trim(),
      session: session.text.trim(),
      subCaste: subCaste.text.trim(),
      transportMode: transportMode,
      vehicleNo: vehicleNo.text.trim(),
      profilePic: profilePic,
      check: check,
      printStatus: printStatus.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isEdit && widget.admNo != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEdit = false;
                  });
                },
                icon: Icon(Icons.close))
            : null,
        title: Text(widget.admNo == null ? 'New Student' : 'Details'),
        actions: widget.admNo != null
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
                            context.read<StudentBloc>().add(
                                  DeleteStudent(
                                    widget.schoolCode,
                                    widget.admNo!,
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
                            printStatus = 'ready';
                            sendToPrint = true;
                            Navigator.pop(context);
                            context.read<StudentBloc>().add(
                                  SaveStudentPressed(
                                    student: newStudentValues(),
                                    checkAdmNo: widget.admNo == null,
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
      body: PopScope(
        canPop: widget.admNo == null ? isEdit : !isEdit,
        onPopInvokedWithResult: (didPop, result) {
          setState(() {
            isEdit = false;
          });
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                children: [
                  if (widget.admNo == null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Multiple Entries',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 17,
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 6,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (isExpanded) MultipleEntryWidget(),
                        Text(
                          'Single Student',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Divider(
                          height: 7,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  BlocBuilder<FormSettingsBloc, FormSettingsState>(
                      builder: (context, formState) {
                    if (formState is FormSettingsLoaded) {
                      FormStudent studentFormMid = formState.formStudent;
                      return BlocConsumer<StudentBloc, StudentState>(
                        listener: (context, saveState) {
                          if (saveState is StudentDeleted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Deleted Successfully'),
                              ),
                            );
                          }
                          if (saveState is StudentDeleteError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(saveState.error),
                              ),
                            );
                          }
                          if (saveState is StudentSaved) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Saved Successfully'),
                              ),
                            );
                            if (sendToPrint) {
                              Navigator.pop(context);
                              context
                                  .read<SchoolDetailsBloc>()
                                  .add(GetSchoolDetails(widget.schoolCode));
                            }
                            if (widget.admNo != null) {
                              setState(() {
                                isEdit = false;
                              });
                            }
                            clearFields();
                            context
                                .read<ClassBloc>()
                                .add(LoadClasses(widget.schoolCode));
                          } else if (saveState is StudentSaveError) {
                            if (saveState.error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(saveState.error!),
                                ),
                              );
                            }
                          }
                        },
                        builder: (context, saveState) => BlocConsumer<
                                StudentDetailsBloc, StudentDetailsState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              Student student = Student(
                                  admNo: '',
                                  schoolCode: widget.schoolCode,
                                  fullName: '');
                              if (state is StudentDetailsLoading) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 60,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (state is StudentDetailsLoaded &&
                                  widget.admNo != null) {
                                student = state.student;
                                if (!isEdit) {
                                  assignValues(student);
                                }
                              }

                              return Column(
                                spacing: 10,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (widget.admNo != null)
                                    ProfilePicWithEdit(
                                      userType: 'student',
                                      userId: student.admNo,
                                      // imageUrl:
                                      //     '$ipv4/getPic/${widget.schoolCode}/$profilePic',
                                      schoolCode: widget.schoolCode,
                                      fullName: student.fullName,
                                      oldProfilePic: profilePic,
                                    ),
                                  if (widget.admNo == null)
                                    BlocBuilder<ClassBloc, ClassState>(
                                      builder: (context, state) => Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Last : ',
                                            children: [
                                              TextSpan(
                                                text: state is ClassLoaded
                                                    ? state.lastNo
                                                    : 'error',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
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
                                    error: saveState is StudentSaveError
                                        ? saveState.admNoError
                                        : null,
                                  ),
                                  MyTextfield(
                                      label: 'Full Name', controller: fullName),
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
                                              value: e.classTitle,
                                              child: Text(e.classTitle)),
                                        )
                                        .toList(),
                                  ),
                                  if (studentFormMid.gender &&
                                      studentFormMid.dob)
                                    Row(
                                      spacing: spacing,
                                      children: [
                                        if (studentFormMid.gender)
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
                                        if (studentFormMid.dob)
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
                                          )
                                      ],
                                    ),
                                  if (studentFormMid.bloodGroup &&
                                      studentFormMid.religion)
                                    Row(
                                      spacing: spacing,
                                      children: [
                                        if (studentFormMid.bloodGroup)
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
                                        if (studentFormMid.religion)
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
                                  if (studentFormMid.caste &&
                                      studentFormMid.subCaste)
                                    Row(
                                      spacing: spacing,
                                      children: [
                                        if (studentFormMid.caste)
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
                                        if (studentFormMid.subCaste)
                                          Expanded(
                                            child: MyTextfield(
                                              label: 'Sub-Caste',
                                              controller: subCaste,
                                            ),
                                          )
                                      ],
                                    ),
                                  if (studentFormMid.email)
                                    MyTextfield(
                                      label: 'Email',
                                      controller: email,
                                    ),
                                  if (studentFormMid.aadhaarNo)
                                    MyTextfield(
                                        label: 'Aadhaar No.',
                                        controller: aadhaarNo),
                                  if (studentFormMid.address)
                                    AddressTextfield(
                                      label: 'Address',
                                      controller: address,
                                    ),
                                  if (studentFormMid.rfid &&
                                      studentFormMid.transportMode)
                                    Row(
                                      spacing: spacing,
                                      children: [
                                        if (studentFormMid.rfid)
                                          Expanded(
                                            child: MyTextfield(
                                              label: 'RFID',
                                              controller: rfid,
                                            ),
                                          ),
                                        if (studentFormMid.transportMode)
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
                                  if (studentFormMid.session &&
                                      studentFormMid.boardingType)
                                    Row(
                                      spacing: spacing,
                                      children: [
                                        if (studentFormMid.session)
                                          Expanded(
                                            child: MyTextfield(
                                              label: 'Session',
                                              controller: session,
                                            ),
                                          ),
                                        if (studentFormMid.boardingType)
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
                                  if (studentFormMid.schoolHouse &&
                                      studentFormMid.vehicleNo)
                                    Row(
                                      spacing: spacing,
                                      children: [
                                        if (studentFormMid.schoolHouse)
                                          Expanded(
                                            child: MyTextfield(
                                              label: 'School House',
                                              controller: schoolHouse,
                                            ),
                                          ),
                                        if (studentFormMid.vehicleNo)
                                          Expanded(
                                            child: MyTextfield(
                                              label: 'Vehicle No.',
                                              controller: vehicleNo,
                                            ),
                                          )
                                      ],
                                    ),
                                  if (studentFormMid.fatherName &&
                                      studentFormMid.motherName)
                                    Row(
                                      spacing: spacing,
                                      children: [
                                        if (studentFormMid.fatherName)
                                          Expanded(
                                            child: MyTextfield(
                                              label: 'Father Name',
                                              controller: fatherName,
                                            ),
                                          ),
                                        if (studentFormMid.motherName)
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
                                          error: saveState is StudentSaveError
                                              ? saveState.fatherMobError
                                              : null,
                                        ),
                                      ),
                                      if (studentFormMid.motherMobNo)
                                        Expanded(
                                          child: MyTextfield(
                                            label: 'Mother Phone',
                                            controller: motherMobNo,
                                          ),
                                        )
                                    ],
                                  ),
                                  if (studentFormMid.fatherWhatsApp &&
                                      studentFormMid.motherWhatsApp)
                                    Row(
                                      spacing: spacing,
                                      children: [
                                        if (studentFormMid.fatherWhatsApp)
                                          Expanded(
                                            child: MyTextfield(
                                              label: 'Father WhatsApp',
                                              controller: fatherWhatsApp,
                                            ),
                                          ),
                                        if (studentFormMid.motherWhatsApp)
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
                                  if (!isEdit)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MyFilledButton(
                                            color: check
                                                ? Colors.amber
                                                : const Color.fromARGB(
                                                    255, 54, 166, 31),
                                            label: check ? 'Uncheck' : 'Check',
                                            onPressed: () => showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  MyAlertDialog(
                                                title:
                                                    'The data will be marked as checked. You can change it later.',
                                                subtitle:
                                                    'Press OK to contine, Cancel to stay on current page.',
                                                icon: Icon(
                                                  Icons.warning_rounded,
                                                  color: Colors.amber,
                                                  size: 35,
                                                ),
                                                cancel: () =>
                                                    Navigator.pop(context),
                                                confirm: () {
                                                  check = !check;
                                                  Navigator.pop(context);
                                                  context
                                                      .read<StudentBloc>()
                                                      .add(
                                                        SaveStudentPressed(
                                                          student:
                                                              newStudentValues(),
                                                          checkAdmNo:
                                                              widget.admNo ==
                                                                  null,
                                                        ),
                                                      );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  saveState is StudentSaveLoading
                                      ? CircularProgressIndicator()
                                      : isEdit
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                MyFilledButton(
                                                  label: 'Cancel',
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                MyFilledButton(
                                                  label: 'Save',
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                StudentBloc>(
                                                            context)
                                                        .add(
                                                      SaveStudentPressed(
                                                        student:
                                                            newStudentValues(),
                                                        checkAdmNo:
                                                            widget.admNo ==
                                                                null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              );
                            }),
                      );
                    } else if (formState is FormSettingsLoadError) {
                      return Text(formState.error);
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
