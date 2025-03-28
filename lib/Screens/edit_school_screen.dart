import 'package:flutter/material.dart';
import 'package:mid_application/ip_address.dart';
import 'package:mid_application/models/school.dart';
import 'package:mid_application/widgets/address_textfield.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';
import 'package:mid_application/widgets/profile_pic_with_edit.dart';

class EditSchoolScreen extends StatefulWidget {
  const EditSchoolScreen({super.key, required this.school});
  final School school;

  @override
  State<EditSchoolScreen> createState() => _EditSchoolScreenState();
}

class _EditSchoolScreenState extends State<EditSchoolScreen> {
  TextEditingController schoolName = TextEditingController();
  TextEditingController schoolMail = TextEditingController();
  TextEditingController estCode = TextEditingController();
  TextEditingController affNo = TextEditingController();
  TextEditingController schoolAddress = TextEditingController();
  TextEditingController schoolPincode = TextEditingController();
  TextEditingController schoolPhone = TextEditingController();
  TextEditingController principalPhone = TextEditingController();
  TextEditingController schoolWebsite = TextEditingController();
  TextEditingController principalName = TextEditingController();
  late School school;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Center(
                child: ProfilePicWithEdit(
                  userId: widget.school.principalPhone,
                  userType: 'school',
                  fullName: school.schoolName,
                  imageUrl:
                      '$ipv4/getPic/${school.schoolCode}/${school.schoolLogo}',
                  schoolCode: school.schoolCode,
                  oldProfilePic: school.schoolLogo!,
                ),
              ),
              Text(
                'Code : ${widget.school.schoolCode}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              MyTextfield(
                label: 'School Name',
                controller: schoolName,
              ),
              MyTextfield(
                label: 'Email',
                controller: schoolMail,
              ),
              Row(
                spacing: 15,
                children: [
                  Expanded(
                    child: MyTextfield(
                      label: 'Establishment Code',
                      controller: estCode,
                    ),
                  ),
                  Expanded(
                    child: MyTextfield(
                      label: 'Affliation No.',
                      controller: affNo,
                    ),
                  ),
                ],
              ),
              AddressTextfield(label: 'Address', controller: schoolAddress),
              Row(
                spacing: 15,
                children: [
                  Expanded(
                    child: MyTextfield(
                      label: 'Pincode',
                      controller: schoolPincode,
                    ),
                  ),
                  Expanded(
                    child: MyTextfield(
                      label: 'School Phone',
                      controller: schoolPhone,
                    ),
                  )
                ],
              ),
              Row(
                spacing: 15,
                children: [
                  Expanded(
                    child: MyTextfield(
                      label: 'Principal Name',
                      controller: principalName,
                    ),
                  ),
                  Expanded(
                    child: MyTextfield(
                      label: 'Principal Phone',
                      controller: principalPhone,
                    ),
                  )
                ],
              ),
              MyTextfield(
                label: 'Website URL',
                controller: schoolWebsite,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Signature :',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 70,
                        width: 180,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 20, top: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          'Signature\nHere',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: -10,
                        top: -5,
                        child: ElevatedButton(
                          onPressed: () {},
                          style:
                              ElevatedButton.styleFrom(shape: CircleBorder()),
                          child: Icon(Icons.attach_file_rounded),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
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
                  )
                ],
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
