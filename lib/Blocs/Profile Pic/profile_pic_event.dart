import 'package:image_picker/image_picker.dart';

abstract class ProfilePicEvent {}

class PickAndUploadProfilePicEvent extends ProfilePicEvent {
  final ImageSource sourceType;
  final String userType;
  final String userId;
  final String schoolCode;
  final String fullName;
  final String? oldProfilePic;
  PickAndUploadProfilePicEvent({
    required this.oldProfilePic,
    required this.schoolCode,
    required this.fullName,
    required this.userType,
    required this.userId,
    required this.sourceType,
  });
}
