abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupRequestSuccess extends SignupState {}

class SignupError extends SignupState {
  final String error;

  SignupError(this.error);
}
