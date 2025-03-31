import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mid_application/Blocs/Profile%20Pic/profile_pic_event.dart';
import 'package:mid_application/Blocs/Profile%20Pic/profile_pic_state.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/Blocs/Staff%20Details/staff_details_bloc.dart';
import 'package:mid_application/Blocs/Staff%20Details/staff_details_event.dart';
import 'package:mid_application/Blocs/Staff/staff_bloc.dart';
import 'package:mid_application/Blocs/Staff/staff_event.dart';
import 'package:mid_application/Blocs/Staff/staff_state.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_bloc.dart';
import 'package:mid_application/Blocs/Student%20Details/student_details_event.dart';
import 'package:mid_application/Blocs/Student/student_bloc.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/ip_address.dart';
import 'package:mid_application/models/staff.dart';
import 'package:mid_application/models/student.dart';
import 'package:mid_application/models/teacher.dart';

class ProfilePicBloc extends Bloc<ProfilePicEvent, ProfilePicState> {
  final StudentBloc studentBloc;
  final StudentDetailsBloc studentDetailsBloc;
  final StaffBloc staffBloc;
  final StaffDetailsBloc staffDetailsBloc;
  final ImagePicker _picker = ImagePicker();
  ProfilePicBloc(this.studentBloc, this.studentDetailsBloc, this.staffBloc,
      this.staffDetailsBloc)
      : super(ProfilePicInitial()) {
    on<PickAndUploadProfilePicEvent>(
      (event, emit) async {
        final XFile? imgFile =
            await _picker.pickImage(source: event.sourceType);
        if (imgFile != null) {
          final image =
              await FlutterExifRotation.rotateImage(path: imgFile.path);
          emit(ProfilePicUploading());
          String schoolCode = event.schoolCode;

          try {
            final date = DateTime.now();
            var request = http.MultipartRequest(
                'POST', Uri.parse('$ipv4/v2/saveProfilePicPicMid'));
            request.files.add(
              http.MultipartFile.fromBytes(
                  'profilePic', image.readAsBytesSync(),
                  filename:
                      '${schoolCode}_${event.userId}_${event.fullName}_${date.microsecond}${date.millisecond}${imgFile.name.substring(imgFile.name.lastIndexOf('.'))}'),
            );
            request.fields['schoolCode'] = schoolCode;
            request.fields['userId'] = event.userId;
            request.fields['user'] = event.userType;
            request.fields['oldProfilePic'] = event.oldProfilePic!;

            var response = await request.send();
            var responded = await http.Response.fromStream(response);

            if (response.statusCode == 201) {
              if (event.userType == 'student') {
                Student update = Student(
                    admNo: event.userId,
                    schoolCode: schoolCode,
                    fullName: event.fullName);
                Map data = jsonDecode(responded.body);

                final updateStudents =
                    (studentBloc.state as StudentsLoaded).students.map(
                  (student) {
                    if (student.admNo == event.userId) {
                      update = Student.fromJson(data);
                      return update;
                    }
                    return student;
                  },
                ).toList();

                studentBloc.add(UpdateStudentsList(updateStudents));
                studentDetailsBloc.add(UpdateStudentDetails(update));
              } else if (event.userType == 'teacher') {
                Teacher update = Teacher(
                  mob: event.userId,
                  schoolCode: schoolCode,
                  fullName: event.fullName,
                );
                Map data = jsonDecode(responded.body);
                final updateTeachers =
                    (staffBloc.state as StaffsLoaded).teachers.map(
                  (teacher) {
                    if (teacher.mob == event.userId) {
                      update = Teacher.fromJson(data);
                      return update;
                    }
                    return teacher;
                  },
                ).toList();
                final updateStaffs = (staffBloc.state as StaffsLoaded).staffs;
                staffBloc.add(UpdateStaffsList(updateStaffs, updateTeachers));
                staffDetailsBloc.add(UpdateStaffDetails(update));
              } else {
                Staff update = Staff(
                    mob: event.userId,
                    schoolCode: schoolCode,
                    fullName: event.fullName);

                Map data = jsonDecode(responded.body);

                final updateStaffs =
                    (staffBloc.state as StaffsLoaded).staffs.map(
                  (staff) {
                    if (staff.mob == event.userId) {
                      update = Staff.fromJson(data);
                      return update;
                    }
                    return staff;
                  },
                ).toList();
                final updateTeachers =
                    (staffBloc.state as StaffsLoaded).teachers;
                staffBloc.add(UpdateStaffsList(updateStaffs, updateTeachers));
                staffDetailsBloc.add(UpdateStaffDetails(update));
              }

              emit(ProfilePicUploaded());
            } else {
              emit(ProfilePicUploadError(responded.body));
            }
          } catch (e) {
            emit(ProfilePicUploadError(e.toString()));
          }
        }
      },
    );
  }
}
