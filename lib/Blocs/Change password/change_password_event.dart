abstract class ChangePasswordEvent {}

class ChangePassword extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;

  ChangePassword(this.currentPassword, this.newPassword);
}
