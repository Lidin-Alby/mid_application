abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentSaveLoading extends StudentState {}

class StudentSaved extends StudentState {}

class StudentSaveError extends StudentState {
  final String error;

  StudentSaveError(this.error);
}
