import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mid_application/widgets/form_settings_tile.dart';
import 'package:mid_application/widgets/tab_button.dart';

class FormSettingsScreen extends StatefulWidget {
  const FormSettingsScreen({super.key});

  @override
  State<FormSettingsScreen> createState() => _FormSettingsScreenState();
}

class _FormSettingsScreenState extends State<FormSettingsScreen> {
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
                                  icon: Icons.wc,
                                  title: 'Gender',
                                  description: 'Dropdown Gender selection',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  icon: Icons.cake,
                                  title: 'DOB',
                                  description:
                                      'Date of birth calender selection',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  icon: Icons.bloodtype,
                                  title: 'Blood Group',
                                  description: 'Dropdown Blood Group',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  icon: Icons.man_outlined,
                                  title: 'Father',
                                  description: 'Text field father',
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
                                  icon: Icons.school_outlined,
                                  title: 'Class',
                                  description: 'Add Classes to teacher',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  icon: Symbols.ar_on_you,
                                  title: 'RFID',
                                  description: 'Text field RFID',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  icon: Icons.directions_bus_filled_outlined,
                                  title: 'Vehicle Number',
                                  description: 'School service vehicle number',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
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
                                  icon: Symbols.folded_hands,
                                  title: 'Religion',
                                  description: 'Add Classes to teacher',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  icon: Icons.edit_note_sharp,
                                  title: 'Caste',
                                  description: 'Text field RFID',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
                                  icon: Icons.edit_note_sharp,
                                  title: 'Sub-Caste',
                                  description: 'School service vehicle number',
                                ),
                                Divider(
                                  thickness: .5,
                                ),
                                FormSettingsTile(
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
