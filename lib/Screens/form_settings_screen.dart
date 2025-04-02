import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mid_application/models/form_student.dart';
import 'package:mid_application/widgets/form_settings_tile.dart';
import 'package:mid_application/widgets/tab_button.dart';

class FormSettingsScreen extends StatefulWidget {
  const FormSettingsScreen({super.key});

  @override
  State<FormSettingsScreen> createState() => _FormSettingsScreenState();
}

class _FormSettingsScreenState extends State<FormSettingsScreen> {
  FormStudent formStudent = FormStudent();
  FormStudent formStudentOld = FormStudent();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Settings'),
      ),
      body: Padding(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Personal Info',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
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
                                      formStudent.gender = value;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showMaterialBanner(MaterialBanner(
                                            elevation: 1,
                                            content: Text('Save Settings'),
                                            actions: [
                                          TextButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentMaterialBanner();
                                              },
                                              child: Text('Save'))
                                        ]));
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     action: SnackBarAction(
                                    //       label: 'Save',
                                    //       onPressed: () {},
                                    //     ),
                                    //     behavior: SnackBarBehavior.floating,
                                    //     margin: EdgeInsets.zero,
                                    //     elevation: 8,
                                    //     backgroundColor: Colors.white,
                                    //     duration: Duration(days: 1),
                                    //     content: Text(
                                    //       'Save the settings',
                                    //       style: TextStyle(color: Colors.black),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  value: formStudent.gender,
                                  icon: Icons.wc,
                                  title: 'Gender',
                                  description: 'Dropdown Gender selection',
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
                                FormSettingsTile(
                                  onTap: (value) {
                                    setState(() {
                                      formStudent.fatherMobNo = value;
                                    });
                                  },
                                  value: formStudent.fatherMobNo,
                                  icon: Icons.call,
                                  title: 'Father Mobile',
                                  description: 'Text field father mobile no.',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  onTap: (value) {
                                    setState(() {
                                      formStudent.fatherWhatsApp = value;
                                    });
                                  },
                                  value: formStudent.fatherWhatsApp,
                                  icon: FontAwesomeIcons.whatsapp,
                                  title: 'Father Whastapp',
                                  description: 'Text field father whatsapp no.',
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
                                  description: 'Text field mother name',
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
                                  description: 'Text field mother mobile no.',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  onTap: (value) {
                                    setState(() {
                                      formStudent.motherWhatsApp = value;
                                    });
                                  },
                                  value: formStudent.motherWhatsApp,
                                  icon: FontAwesomeIcons.whatsapp,
                                  title: 'Mother Whatsapp',
                                  description: 'Text field mother whatsapp no.',
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
                                  icon: Icons.location_history_rounded,
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
                            style: TextStyle(fontSize: 15, color: Colors.grey),
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
                                      formStudent.boardingType = value;
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
                                  icon: Icons.directions_bus_filled_outlined,
                                  title: 'Vehicle Number',
                                  description: 'School service vehicle number',
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
                                  description: 'Text field School House',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'More :',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
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
                                  description: 'School service vehicle number',
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
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
