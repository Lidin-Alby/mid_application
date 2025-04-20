import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_application/Blocs/School%20details/school_details_bloc.dart';
import 'package:mid_application/Blocs/School%20details/school_details_event.dart';
import 'package:mid_application/Blocs/School%20details/school_details_state.dart';
import 'package:mid_application/models/school.dart';
import 'package:mid_application/widgets/address_textfield.dart';
import 'package:mid_application/widgets/my_filled_button.dart';
import 'package:mid_application/widgets/my_textfield.dart';
import 'package:mid_application/widgets/profile_pic_with_edit.dart';

class SchoolDetailsScreen extends StatefulWidget {
  const SchoolDetailsScreen({super.key, required this.school});
  final School school;

  @override
  State<SchoolDetailsScreen> createState() => _SchoolDetailsScreenState();
}

class _SchoolDetailsScreenState extends State<SchoolDetailsScreen> {
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
  String? logo;
  String? sign;
  // late School school;

  @override
  void initState() {
    context
        .read<SchoolDetailsBloc>()
        .add(GetSchoolDetails(widget.school.schoolCode));
    super.initState();
  }

  School newSchoolValues() {
    return School(
      schoolCode: widget.school.schoolCode,
      schoolName: schoolName.text.trim(),
      principalPhone: principalPhone.text.trim(),
      affNo: affNo.text.trim(),
      estCode: estCode.text.trim(),
      principalName: principalName.text.trim(),
      schoolMail: schoolMail.text.trim(),
      schoolPhone: schoolPhone.text.trim(),
      schoolAddress: schoolAddress.text.trim(),
      schoolPincode: schoolPincode.text.trim(),
      schoolWebsite: schoolWebsite.text.trim(),
    );
  }

  assignValues(School school) {
    schoolName.text = school.schoolName;
    schoolMail.text = school.schoolMail.toString();
    estCode.text = school.estCode.toString();
    affNo.text = school.affNo.toString();
    schoolAddress.text = school.schoolAddress.toString();
    schoolPincode.text = school.schoolPincode.toString();
    schoolPhone.text = school.schoolPhone.toString();
    principalPhone.text = school.principalPhone.toString();
    schoolWebsite.text = school.schoolWebsite.toString();
    principalName.text = school.principalName.toString();
    logo = school.schoolLogo;
    sign = school.principalSign;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: BlocConsumer<SchoolDetailsBloc, SchoolDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            School school =
                School(schoolCode: '', schoolName: '', principalPhone: '');
            if (state is SchoolDetailsLoaded) {
              school = state.school;
              assignValues(school);
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Center(
                      child: ProfilePicWithEdit(
                        userId: school.principalPhone,
                        userType: 'logo',
                        fullName: school.schoolName,
                        schoolCode: school.schoolCode,
                        oldProfilePic: logo,
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
                    AddressTextfield(
                        label: 'Address', controller: schoolAddress),
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
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder()),
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
                    state is SavingSchoolDetails
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
                                  context.read<SchoolDetailsBloc>().add(
                                        SaveSchoolDetails(newSchoolValues()),
                                      );
                                },
                              )
                            ],
                          ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
