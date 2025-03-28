abstract class ProfilePicState {}

class ProfilePicInitial extends ProfilePicState {}

class ProfilePicUploading extends ProfilePicState {}

class ProfilePicUploaded extends ProfilePicState {}

class ProfilePicUploadError extends ProfilePicState {
  final String error;

  ProfilePicUploadError(this.error);
}
