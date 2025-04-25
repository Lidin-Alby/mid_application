abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

class LoggedIn extends LoginState {
  final String user;
  final String schoolCode;

  LoggedIn(this.user, this.schoolCode);
}

class LoggedOut extends LoginState {}
