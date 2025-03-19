abstract class LoginEvent {}

class LoginPressed extends LoginEvent {
  final String userId;
  final String schoolCode;
  final String password;

  LoginPressed({
    required this.userId,
    required this.schoolCode,
    required this.password,
  });
}

class LogoutPressed extends LoginEvent {}

class CheckLoginStatus extends LoginEvent {}
