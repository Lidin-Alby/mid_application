import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_state.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_bloc.dart';
import 'package:mid_application/Blocs/Form%20Settings/form_settings_event.dart';
import 'package:mid_application/models/form_staff.dart';
import 'package:mid_application/models/form_student.dart';
import 'package:mid_application/widgets/form_settings_tile.dart';
import 'package:mid_application/widgets/tab_button.dart';

class FormSettingsScreen extends StatefulWidget {
  const FormSettingsScreen({super.key, required this.schoolCode});
  final String schoolCode;

  @override
  State<FormSettingsScreen> createState() => _FormSettingsScreenState();
}

class _FormSettingsScreenState extends State<FormSettingsScreen> {
  late FormStudent formStudent;
  late FormStudent formStudentOld;
  late FormStaff formTeacher;
  late FormStaff formTeacherOld;
  late FormStaff formStaff;
  late FormStaff formStaffOld;

  bool showUnsaved = false;
  int _currentIndex = 0;
  bool init = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Settings'),
      ),
      body: BlocConsumer<FormSettingsBloc, FormSettingsState>(
        listener: (context, state) {
          if (state is SaveFormSettingsError) {
            showUnsaved = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is FormSettingsLoadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is FormSettingsSaved) {
            showUnsaved = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Saved Successfully'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FormSettingsLoaded || state is SavingFormSettings) {
            if (state is FormSettingsLoaded) {
              formStudentOld = state.formStudent;
              formTeacherOld = state.formTeacher;
              formStaffOld = state.formStaff;

              if (init) {
                formStudent = FormStudent.fromJson(formStudentOld.toMap());
                formTeacher = FormStaff.fromJson(formTeacherOld.tomap());
                formStaff = FormStaff.fromJson(formStaffOld.tomap());
                init = false;
              }

              // showUnsaved = !(formStudent == formStudentOld);
              showUnsaved = !(formTeacher == formTeacherOld) ||
                  !(formStudent == formStudentOld) ||
                  !(formStaff == formStaffOld);
            }

            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        // spacing: 15,
                        children: [
                          TabButton(
                            label: 'Students',
                            selected: _currentIndex == 0,
                            onTap: () {
                              setState(() {
                                _currentIndex = 0;
                              });
                            },
                          ),
                          TabButton(
                            label: 'Teachers',
                            selected: _currentIndex == 1,
                            onTap: () {
                              setState(() {
                                _currentIndex = 1;
                              });
                            },
                          ),
                          TabButton(
                            label: 'Staff',
                            selected: _currentIndex == 2,
                            onTap: () {
                              setState(() {
                                _currentIndex = 2;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_currentIndex == 0)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Personal Info :',
                                      style: GoogleFonts.inter(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).dividerColor,
                                            width: .5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.gender = value;
                                              });
                                            },
                                            value: formStudent.gender,
                                            icon: Icons.wc,
                                            title: 'Gender',
                                            description:
                                                'Dropdown Gender selection',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.dob = value;
                                              });
                                            },
                                            value: formStudent.dob,
                                            icon: Icons.cake,
                                            title: 'DOB',
                                            description:
                                                'Date of birth calender selection',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.bloodGroup = value;
                                              });
                                            },
                                            value: formStudent.bloodGroup,
                                            icon: Icons.bloodtype,
                                            title: 'Blood Group',
                                            description: 'Dropdown Blood Group',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.fatherName = value;
                                              });
                                            },
                                            value: formStudent.fatherName,
                                            icon: Icons.man_outlined,
                                            title: 'Father Name',
                                            description: 'Text field father',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          // FormSettingsTile(
                                          //   onTap: (value) {
                                          //     setState(() {
                                          //       formStudent.fatherMobNo = value;
                                          //     });
                                          //   },
                                          //   value: formStudent.fatherMobNo,
                                          //   icon: Icons.call,
                                          //   title: 'Father Mobile',
                                          //   description:
                                          //       'Text field father mobile no.',
                                          // ),
                                          // Divider(
                                          //   thickness: .5,
                                          // ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.fatherWhatsApp =
                                                    value;
                                              });
                                            },
                                            value: formStudent.fatherWhatsApp,
                                            icon: FontAwesomeIcons.whatsapp,
                                            title: 'Father Whastapp',
                                            description:
                                                'Text field father whatsapp no.',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.motherName = value;
                                              });
                                            },
                                            value: formStudent.motherName,
                                            icon: Icons.woman,
                                            title: 'Mother Name',
                                            description:
                                                'Text field mother name',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.motherMobNo = value;
                                              });
                                            },
                                            value: formStudent.motherMobNo,
                                            icon: Icons.call,
                                            title: 'Mother Mobile',
                                            description:
                                                'Text field mother mobile no.',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.motherWhatsApp =
                                                    value;
                                              });
                                            },
                                            value: formStudent.motherWhatsApp,
                                            icon: FontAwesomeIcons.whatsapp,
                                            title: 'Mother Whatsapp',
                                            description:
                                                'Text field mother whatsapp no.',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.email = value;
                                              });
                                            },
                                            value: formStudent.email,
                                            icon: Icons.mail_outline_rounded,
                                            title: 'Mail',
                                            description: 'Text field mail id',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.address = value;
                                              });
                                            },
                                            value: formStudent.address,
                                            icon: Icons.location_city,
                                            title: 'Address',
                                            description: 'Text field address',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.aadhaarNo = value;
                                              });
                                            },
                                            value: formStudent.aadhaarNo,
                                            icon:
                                                Icons.location_history_rounded,
                                            title: 'Aadhaar No.',
                                            description: 'Text field aadhaaar',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'School Releated :',
                                      style: GoogleFonts.inter(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).dividerColor,
                                            width: .5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.session = value;
                                              });
                                            },
                                            value: formStudent.session,
                                            icon: Icons.calendar_month,
                                            title: 'Session',
                                            description: 'Textfield Session',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.rfid = value;
                                              });
                                            },
                                            value: formStudent.rfid,
                                            icon: Symbols.ar_on_you,
                                            title: 'RFID',
                                            description: 'Text field RFID',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.boardingType =
                                                    value;
                                              });
                                            },
                                            value: formStudent.boardingType,
                                            icon: Icons.run_circle_outlined,
                                            title: 'Boarding Type',
                                            description:
                                                'Dropdown for boarding to school',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.vehicleNo = value;
                                              });
                                            },
                                            value: formStudent.vehicleNo,
                                            icon: Icons
                                                .directions_bus_filled_outlined,
                                            title: 'Vehicle Number',
                                            description:
                                                'School service vehicle number',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.schoolHouse = value;
                                              });
                                            },
                                            value: formStudent.schoolHouse,
                                            icon: Icons.color_lens_outlined,
                                            title: 'School House',
                                            description:
                                                'Text field School House',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'More :',
                                      style: GoogleFonts.inter(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).dividerColor,
                                            width: .5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.religion = value;
                                              });
                                            },
                                            value: formStudent.religion,
                                            icon: Symbols.folded_hands,
                                            title: 'Religion',
                                            description:
                                                'Add Classes to teacher',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.caste = value;
                                              });
                                            },
                                            value: formStudent.caste,
                                            icon: Icons.edit_note_sharp,
                                            title: 'Caste',
                                            description: 'Text field RFID',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.subCaste = value;
                                              });
                                            },
                                            value: formStudent.subCaste,
                                            icon: Icons.edit_note_sharp,
                                            title: 'Sub-Caste',
                                            description:
                                                'School service vehicle number',
                                          ),
                                          Divider(
                                            thickness: .5,
                                          ),
                                          FormSettingsTile(
                                            onTap: (value) {
                                              setState(() {
                                                formStudent.transportMode =
                                                    value;
                                              });
                                            },
                                            value: formStudent.transportMode,
                                            icon: Icons.trending_up,
                                            title: 'Transport Mode',
                                            description:
                                                'Text field School House',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (_currentIndex == 1 || _currentIndex == 2)
                        Expanded(
                            child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Personal Info :',
                                  style: GoogleFonts.inter(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor,
                                        width: .5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      FormSettingsTile(
                                        title: 'Joining Date',
                                        icon: Icons.calendar_month,
                                        description: 'Pick date of joining',
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.joiningDate = value;
                                            } else {
                                              formTeacher.joiningDate = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.joiningDate
                                            : formTeacher.joiningDate,
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        title: 'Department',
                                        icon: Icons.school,
                                        description:
                                            'Text field for department',
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.department = value;
                                            } else {
                                              formTeacher.department = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.department
                                            : formTeacher.department,
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      // FormSettingsTile(title: 'Designation', icon: Icons.star, description: 'Tea', onTap: onTap, value: value)
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.rfid = value;
                                            } else {
                                              formTeacher.rfid = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.rfid
                                            : formTeacher.rfid,
                                        icon: Symbols.ar_on_you,
                                        title: 'RFID',
                                        description: 'Text field RFID',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.dob = value;
                                            } else {
                                              formTeacher.dob = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.dob
                                            : formTeacher.dob,
                                        icon: Icons.cake,
                                        title: 'DOB',
                                        description:
                                            'Date of birth calender selection',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),

                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.gender = value;
                                            } else {
                                              formTeacher.gender = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.gender
                                            : formTeacher.gender,
                                        icon: Icons.wc,
                                        title: 'Gender',
                                        description:
                                            'Dropdown Gender selection',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.bloodGroup = value;
                                            } else {
                                              formTeacher.bloodGroup = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.bloodGroup
                                            : formTeacher.bloodGroup,
                                        icon: Icons.bloodtype,
                                        title: 'Blood Group',
                                        description: 'Dropdown Blood Group',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.address = value;
                                            } else {
                                              formTeacher.address = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.address
                                            : formTeacher.address,
                                        icon: Icons.location_city,
                                        title: 'Address',
                                        description: 'Text field address',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.email = value;
                                            } else {
                                              formTeacher.email = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.email
                                            : formTeacher.email,
                                        icon: Icons.mail_outline_rounded,
                                        title: 'Mail',
                                        description: 'Text field mail id',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        title: 'Father or Husband Name',
                                        icon: Icons.man,
                                        description: 'Text field for name',
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.fatherOrHusName = value;
                                            } else {
                                              formTeacher.fatherOrHusName =
                                                  value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.fatherOrHusName
                                            : formTeacher.fatherOrHusName,
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        title: 'Qualification',
                                        icon: Icons.book_outlined,
                                        description:
                                            'Text field for qualification',
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.qualification = value;
                                            } else {
                                              formTeacher.qualification = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.qualification
                                            : formTeacher.qualification,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Cards :',
                                  style: GoogleFonts.inter(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor,
                                        width: .5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.aadhaarNo = value;
                                            } else {
                                              formTeacher.aadhaarNo = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.aadhaarNo
                                            : formTeacher.aadhaarNo,
                                        icon: Icons.location_history_rounded,
                                        title: 'Aadhaar',
                                        description:
                                            'Text field for aadhaar no.',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.panNo = value;
                                            } else {
                                              formTeacher.panNo = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.panNo
                                            : formTeacher.panNo,
                                        icon: Icons.account_balance,
                                        title: 'Pan',
                                        description: 'Text field pan no.',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.uan = value;
                                            } else {
                                              formTeacher.uan = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.uan
                                            : formTeacher.uan,
                                        icon: Symbols.identity_platform,
                                        title: 'Uan',
                                        description:
                                            'Text field for uan number',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.dlNo = value;
                                            } else {
                                              formTeacher.dlNo = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.dlNo
                                            : formTeacher.dlNo,
                                        icon: Icons.badge,
                                        title: 'DL',
                                        description: 'Text field for DL',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            if (_currentIndex == 2) {
                                              formStaff.dlValidity = value;
                                            } else {
                                              formTeacher.dlValidity = value;
                                            }
                                          });
                                        },
                                        value: _currentIndex == 2
                                            ? formStaff.dlValidity
                                            : formTeacher.dlValidity,
                                        icon: Icons.calendar_month,
                                        title: 'DL Validity',
                                        description:
                                            'Select date of validity of card',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'More :',
                                  style: GoogleFonts.inter(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor,
                                        width: .5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            formStudent.religion = value;
                                          });
                                        },
                                        value: formStudent.religion,
                                        icon: Symbols.folded_hands,
                                        title: 'Religion',
                                        description: 'Add Classes to teacher',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            formStudent.caste = value;
                                          });
                                        },
                                        value: formStudent.caste,
                                        icon: Icons.edit_note_sharp,
                                        title: 'Caste',
                                        description: 'Text field RFID',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            formStudent.subCaste = value;
                                          });
                                        },
                                        value: formStudent.subCaste,
                                        icon: Icons.edit_note_sharp,
                                        title: 'Sub-Caste',
                                        description:
                                            'School service vehicle number',
                                      ),
                                      Divider(
                                        thickness: .5,
                                      ),
                                      FormSettingsTile(
                                        onTap: (value) {
                                          setState(() {
                                            formStudent.transportMode = value;
                                          });
                                        },
                                        value: formStudent.transportMode,
                                        icon: Icons.trending_up,
                                        title: 'Transport Mode',
                                        description: 'Text field School House',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          ),
                        ))
                    ],
                  ),
                ),
                if (showUnsaved)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 25,
                            spreadRadius: 2,
                            color: const Color.fromARGB(60, 0, 0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Unsaved changes'),
                            state is SavingFormSettings
                                ? CircularProgressIndicator()
                                : TextButton(
                                    onPressed: () {
                                      context.read<FormSettingsBloc>().add(
                                            SaveFormSettings(
                                              schoolCode: widget.schoolCode,
                                              formStudent: formStudent,
                                              formTeacher: formTeacher,
                                              formStaff: formStaff,
                                            ),
                                          );
                                    },
                                    child: Text('Save'))
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            );
          } else {
            if (state is FormSettingsLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SizedBox();
            }
          }
        },
      ),
    );
  }
}
