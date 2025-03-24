import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mid_application/Blocs/Profile%20Pic/profile_pic_event.dart';
import 'package:mid_application/Blocs/Profile%20Pic/profile_pic_state.dart';

import 'package:http/http.dart' as http;
import 'package:mid_application/Blocs/Student/student_bloc.dart';
import 'package:mid_application/Blocs/Student/student_event.dart';
import 'package:mid_application/Blocs/Student/student_state.dart';
import 'package:mid_application/ip_address.dart';
import 'package:mid_application/models/student.dart';

class ProfilePicBloc extends Bloc<ProfilePicEvent, ProfilePicState> {
  final StudentBloc studentBloc;
  final ImagePicker _picker = ImagePicker();
  ProfilePicBloc(this.studentBloc) : super(ProfilePicInitial()) {
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
            request.fields['oldProfilePic'] = event.oldProfilePic;

            var response = await request.send();
            var responded = await http.Response.fromStream(response);

            if (response.statusCode == 201) {
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

              studentBloc.add(UpdateStudent(updateStudents));

              emit(ProfilePicUploaded(update.profilePic!));
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
